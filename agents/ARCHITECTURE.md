# ARCHITECTURE.md — DBStudio System Architecture

## 1. High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                        Flutter Desktop App                          │
│                                                                     │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌────────────────────┐  │
│  │Connections│  │  SQL     │  │  Data    │  │  Schema /          │  │
│  │ Explorer  │  │ Editor   │  │  Grid    │  │  ER Diagram        │  │
│  │ (Sidebar) │  │ (Tabs)   │  │ (Panel)  │  │  Tools             │  │
│  └─────┬─────┘  └─────┬────┘  └────┬─────┘  └────────┬───────────┘  │
│        │              │            │                  │              │
│  ──────────────────── Presentation Layer (UI) ──────────────────── │
│                                                                     │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │              State Management (Riverpod)                    │   │
│  │  ConnectionNotifier | QueryNotifier | GridNotifier | ...    │   │
│  └─────────────────────────┬───────────────────────────────────┘   │
│                            │                                        │
│  ──────────────────── Application Layer ───────────────────────── │
│                                                                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────────┐  │
│  │  Connection  │  │  Query       │  │  Schema                  │  │
│  │  Service     │  │  Service     │  │  Service                 │  │
│  └──────┬───────┘  └──────┬───────┘  └────────────┬─────────────┘  │
│         │                 │                        │               │
│  ──────────────────── Domain Layer ────────────────────────────── │
│                                                                     │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  Driver Abstraction Layer (DAL)                              │  │
│  │  DatabaseDriver interface → PostgresDriver | MySQLDriver ... │  │
│  └─────────────────────────┬────────────────────────────────────┘  │
│                            │                                        │
└────────────────────────────┼────────────────────────────────────────┘
                             │
        ┌────────────────────┼────────────────────────────┐
        │                   │                            │
   ┌────▼──────┐    ┌───────▼──────┐           ┌────────▼──────┐
   │ dart_     │    │  mysql_      │           │  dartssh2     │
   │ postgres  │    │  client      │           │  (SSH tunnel) │
   └───────────┘    └──────────────┘           └───────────────┘
```

---

## 2. Layer Definitions

### 2.1 Presentation Layer (`lib/ui/`)
Pure Flutter widgets. No business logic. Reads from Riverpod providers, dispatches events to notifiers.

```
lib/ui/
  layout/           # AppShell, sidebar, tab bar, panel splits
  connections/      # Connection dialog, connection list tile
  explorer/         # Object tree, context menus
  editor/           # SQL editor tab, toolbar
  grid/             # DataGrid, cell editors, filter bar
  er_diagram/       # ERDiagram canvas, table card widget
  schema/           # DDL viewer, schema compare
  settings/         # Settings pages
  shared/           # Buttons, dialogs, loaders, icons
```

### 2.2 State Layer (`lib/state/`)
Riverpod `AsyncNotifier` and `Notifier` classes. One notifier per domain concern.

```
lib/state/
  connection_state.dart     # Open connections map, active connection
  explorer_state.dart       # Expanded nodes, loaded children cache
  editor_state.dart         # Open tabs, tab content, cursor position
  query_state.dart          # Query execution state, results
  grid_state.dart           # Page, sort, filter, pending edits
  schema_state.dart         # Cached schema metadata
  settings_state.dart       # App preferences
```

### 2.3 Application / Service Layer (`lib/services/`)
Orchestrates domain logic. Pure Dart (no Flutter imports).

```
lib/services/
  connection_service.dart   # Open/close connections, pool management
  query_service.dart        # Execute SQL, stream results, cancel
  schema_service.dart       # Fetch metadata, DDL generation
  export_service.dart       # Export results to CSV/JSON/Excel
  import_service.dart       # Import CSV/Excel into table
  history_service.dart      # Persist query history to SQLite
  credential_service.dart   # Secure storage R/W
  ssh_tunnel_service.dart   # Tunnel lifecycle
  formatter_service.dart    # SQL formatting
```

### 2.4 Driver Abstraction Layer (`lib/drivers/`)

```dart
abstract class DatabaseDriver {
  Future<void> connect(ConnectionProfile profile);
  Future<void> disconnect();
  Stream<List<Map<String, dynamic>>> executeQuery(String sql, {Map<String, dynamic>? params});
  Future<int> executeUpdate(String sql);
  Future<SchemaMetadata> getMetadata();
  Future<String> generateDDL(DatabaseObject object);
  Future<void> cancelQuery();
  bool get isConnected;
  Stream<ConnectionEvent> get events;
}
```

Implementations:
- `lib/drivers/postgres/postgres_driver.dart`
- `lib/drivers/mysql/mysql_driver.dart`
- `lib/drivers/sqlite/sqlite_driver.dart`
- `lib/drivers/mssql/mssql_driver.dart`
- `lib/drivers/mongodb/mongo_driver.dart`

### 2.5 Domain Models (`lib/models/`)
```
ConnectionProfile, DatabaseObject, TableMetadata, ColumnMetadata,
IndexMetadata, ForeignKeyMetadata, QueryResult, ResultRow, ResultPage,
SchemaMetadata, ExportConfig, ImportConfig, QueryHistoryEntry,
AppSettings, SSHConfig, SSLConfig
```

---

## 3. Data Flow: Query Execution

```
User presses Ctrl+Enter in SQL Editor
        │
        ▼
EditorWidget.onRunQuery()
        │
        ▼
queryStateNotifier.execute(sql, connectionId)
        │
        ▼
QueryService.execute(sql, driver)
  ├── driver.cancelPrevious()
  ├── timer.start()
  ├── driver.executeQuery(sql)  → returns Stream<ResultPage>
  │         │
  │         └── Pages arrive async (500 rows each)
  │
  ▼
GridState updated per page (append rows)
        │
        ▼
DataGrid re-renders only visible viewport
  (virtual scroll — O(1) render cost regardless of row count)
```

---

## 4. Data Flow: Lazy Tree Loading

```
User expands "Tables" node in explorer
        │
        ▼
ExplorerWidget.onNodeExpand(node)
        │
        ▼
explorerStateNotifier.loadChildren(node)
  checks cache (schemaMetadataCache)
  if miss:
        │
        ▼
  SchemaService.fetchChildren(node, driver)
        │
        ▼
  driver.getMetadata() — specific to node type
        │
        ▼
  result stored in explorerCache
        │
        ▼
  tree updates, spinner removed
```

---

## 5. Connection Pool Architecture

```
ConnectionPool (per ConnectionProfile)
  ├── idle: List<RawConnection>   (max 5 idle)
  ├── active: Map<id, RawConnection>
  ├── maxSize: 10
  └── acquire() / release() with timeout
```

- Separate pool per profile
- Idle connections pinged every 30s (keepalive)
- Dead connections removed and replaced
- SSH tunnel counts as 1 connection to tunnel server, N to DB

---

## 6. Memory Management for Large Results

```
ResultWindowCache
  ├── currentPage: int
  ├── windowSize: 3 pages (1500 rows in memory)
  ├── pageCache: Map<int, ResultPage>
  └── evict() — removes pages outside window

DataGrid
  ├── rowCount: totalRows (from DB COUNT or cursor)
  ├── visibleRange: computed from scroll offset
  └── onScroll → if row not in cache → fetch page
```

---

## 7. Riverpod Provider Graph

```
appSettingsProvider
    ↑
connectionProfilesProvider ──→ credentialServiceProvider
    ↑
openConnectionsProvider ──→ driverProvider(connectionId)
    ↑                              ↑
explorerStateProvider    queryStateProvider(tabId)
    ↑                              ↑
schemaMetaCacheProvider  gridStateProvider(tabId)
```

All async providers — loading / error / data states handled uniformly.

---

## 8. File & Storage Layout

```
{appDataDir}/dbstudio/
  ├── settings.json              # App preferences (non-sensitive)
  ├── connections.hive           # Encrypted connection profiles
  ├── history.db                 # SQLite: query history
  ├── snippets.json              # Saved SQL snippets
  ├── session.json               # Last open tabs (for restore on crash)
  └── logs/
      └── dbstudio_YYYY-MM-DD.log
```

OS Keychain: credentials keyed by `dbstudio.{connectionId}.password`

---

## 9. Threading Model

| Work Type | Where |
|-----------|-------|
| UI rendering | Main isolate |
| DB query execution | `compute()` / separate isolate via driver |
| ER diagram layout (force simulation) | Isolate via `Isolate.run()` |
| File export (large CSV) | Isolate |
| SQL formatting | Main isolate (fast enough) |
| Schema metadata fetch | `async/await` on main isolate (I/O bound) |

---

## 10. Plugin / Driver Registration

```dart
// lib/drivers/driver_registry.dart
class DriverRegistry {
  static final _drivers = <DatabaseType, DriverFactory>{};

  static void register(DatabaseType type, DriverFactory factory) {
    _drivers[type] = factory;
  }

  static DatabaseDriver create(ConnectionProfile profile) {
    final factory = _drivers[profile.type] ?? (throw DriverNotFoundException(profile.type));
    return factory(profile);
  }
}

// main.dart
void main() {
  DriverRegistry.register(DatabaseType.postgres, PostgresDriver.new);
  DriverRegistry.register(DatabaseType.mysql, MySQLDriver.new);
  DriverRegistry.register(DatabaseType.sqlite, SQLiteDriver.new);
  runApp(const ProviderScope(child: DBStudioApp()));
}
```
