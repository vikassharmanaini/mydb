# SPEC.md — Technical Specification: DBStudio

## 1. Tech Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| UI Framework | Flutter | ≥3.22 |
| Language | Dart | ≥3.4 |
| State Management | Riverpod (code-gen) | ≥2.5 |
| Navigation | go_router | ≥14 |
| SQL Editor Widget | re_editor | latest |
| Syntax Highlighting | highlight | latest |
| Data Grid | Custom (TwoDimensionalScrollView) | Flutter built-in |
| PostgreSQL | dart_postgres | ≥3.1 |
| MySQL | mysql_client | latest |
| SQLite | sqlite3 (FFI) | latest |
| SSH Tunnel | dartssh2 | latest |
| Local DB (history) | drift | ≥2.18 |
| Secure Storage | flutter_secure_storage | ≥9 |
| Encrypted Prefs | hive + hive_flutter | latest |
| File Picker | file_picker | ≥8 |
| Excel Export/Import | excel | ≥4 |
| Window Management | window_manager | ≥0.3 |
| ER Diagram Canvas | custom CustomPainter + InteractiveViewer | |
| Logging | logger | latest |
| DI / Service Locator | Riverpod providers (no get_it) | |

---

## 2. pubspec.yaml (Key Dependencies)

```yaml
name: dbstudio
description: A professional database management tool built with Flutter.
version: 1.0.0+1
publish_to: none

environment:
  sdk: '>=3.4.0 <4.0.0'
  flutter: '>=3.22.0'

dependencies:
  flutter:
    sdk: flutter

  # State
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5

  # Navigation
  go_router: ^14.2.0

  # SQL Editor
  re_editor: ^0.3.0
  highlight: ^0.7.0

  # Database Drivers
  postgres: ^3.1.0
  mysql_client: ^0.0.27
  sqlite3: ^2.4.0
  sqlite3_flutter_libs: ^0.5.0

  # SSH
  dartssh2: ^2.9.0

  # Local Storage
  drift: ^2.18.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_secure_storage: ^9.0.0

  # File Handling
  file_picker: ^8.0.0
  excel: ^4.0.0
  csv: ^6.0.0
  path_provider: ^2.1.3
  path: ^1.9.0

  # Window
  window_manager: ^0.3.8

  # Utils
  logger: ^2.3.0
  uuid: ^4.4.0
  intl: ^0.19.0
  collection: ^1.18.0
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0

dev_dependencies:
  build_runner: ^2.4.11
  riverpod_generator: ^2.4.0
  freezed: ^2.5.2
  json_serializable: ^6.8.0
  drift_dev: ^2.18.0
  flutter_lints: ^4.0.0
  mocktail: ^1.0.4
  flutter_test:
    sdk: flutter
```

---

## 3. Project Structure

```
dbstudio/
├── lib/
│   ├── main.dart
│   ├── app.dart                      # MaterialApp + GoRouter
│   │
│   ├── models/                       # Pure Dart data classes (freezed)
│   │   ├── connection_profile.dart
│   │   ├── database_object.dart
│   │   ├── query_result.dart
│   │   ├── result_page.dart
│   │   ├── schema_metadata.dart
│   │   ├── column_metadata.dart
│   │   ├── index_metadata.dart
│   │   ├── fk_metadata.dart
│   │   ├── app_settings.dart
│   │   ├── ssh_config.dart
│   │   ├── ssl_config.dart
│   │   └── export_config.dart
│   │
│   ├── drivers/                      # DB driver implementations
│   │   ├── driver_interface.dart     # abstract DatabaseDriver
│   │   ├── driver_registry.dart
│   │   ├── connection_event.dart
│   │   ├── postgres/
│   │   │   ├── postgres_driver.dart
│   │   │   └── postgres_metadata.dart
│   │   ├── mysql/
│   │   │   ├── mysql_driver.dart
│   │   │   └── mysql_metadata.dart
│   │   ├── sqlite/
│   │   │   ├── sqlite_driver.dart
│   │   │   └── sqlite_metadata.dart
│   │   └── mssql/
│   │       └── mssql_driver.dart
│   │
│   ├── services/
│   │   ├── connection_service.dart
│   │   ├── query_service.dart
│   │   ├── schema_service.dart
│   │   ├── export_service.dart
│   │   ├── import_service.dart
│   │   ├── history_service.dart
│   │   ├── credential_service.dart
│   │   ├── ssh_tunnel_service.dart
│   │   ├── formatter_service.dart
│   │   └── session_restore_service.dart
│   │
│   ├── state/
│   │   ├── connection_state.dart
│   │   ├── explorer_state.dart
│   │   ├── editor_state.dart
│   │   ├── query_state.dart
│   │   ├── grid_state.dart
│   │   ├── schema_cache_state.dart
│   │   └── settings_state.dart
│   │
│   ├── ui/
│   │   ├── layout/
│   │   │   ├── app_shell.dart        # Main scaffold: sidebar + content
│   │   │   ├── split_pane.dart       # Resizable split pane widget
│   │   │   └── tab_bar_view.dart     # Custom tab bar
│   │   │
│   │   ├── connections/
│   │   │   ├── connection_dialog.dart
│   │   │   ├── connection_list.dart
│   │   │   └── ssh_config_form.dart
│   │   │
│   │   ├── explorer/
│   │   │   ├── object_tree.dart
│   │   │   ├── tree_node_widget.dart
│   │   │   └── context_menus/
│   │   │       ├── table_context_menu.dart
│   │   │       └── schema_context_menu.dart
│   │   │
│   │   ├── editor/
│   │   │   ├── sql_editor_tab.dart
│   │   │   ├── editor_toolbar.dart
│   │   │   ├── autocomplete_handler.dart
│   │   │   └── snippet_panel.dart
│   │   │
│   │   ├── grid/
│   │   │   ├── data_grid.dart
│   │   │   ├── grid_header.dart
│   │   │   ├── grid_cell.dart
│   │   │   ├── cell_editors/
│   │   │   │   ├── text_cell_editor.dart
│   │   │   │   ├── date_cell_editor.dart
│   │   │   │   ├── bool_cell_editor.dart
│   │   │   │   ├── json_cell_editor.dart
│   │   │   │   └── blob_cell_viewer.dart
│   │   │   ├── filter_bar.dart
│   │   │   └── export_dialog.dart
│   │   │
│   │   ├── er_diagram/
│   │   │   ├── er_canvas.dart
│   │   │   ├── table_card.dart
│   │   │   ├── relation_painter.dart
│   │   │   └── force_layout.dart    # Runs in isolate
│   │   │
│   │   ├── schema/
│   │   │   ├── ddl_viewer.dart
│   │   │   ├── schema_compare.dart
│   │   │   └── diff_viewer.dart
│   │   │
│   │   └── settings/
│   │       ├── settings_page.dart
│   │       ├── appearance_settings.dart
│   │       └── shortcut_settings.dart
│   │
│   ├── local_db/                    # Drift database for history etc
│   │   ├── app_database.dart
│   │   ├── tables/
│   │   │   ├── query_history_table.dart
│   │   │   └── snippets_table.dart
│   │   └── daos/
│   │       ├── history_dao.dart
│   │       └── snippet_dao.dart
│   │
│   └── utils/
│       ├── sql_formatter.dart
│       ├── type_detector.dart       # Dart type from DB column type string
│       ├── color_extensions.dart
│       └── keyboard_shortcuts.dart
│
├── test/
│   ├── drivers/
│   ├── services/
│   ├── state/
│   └── ui/
│
├── integration_test/
├── assets/
│   ├── icons/
│   └── sql_grammars/
│
├── windows/
├── macos/
├── linux/
└── pubspec.yaml
```

---

## 4. Core Interface Contracts

### 4.1 DatabaseDriver
```dart
abstract interface class DatabaseDriver {
  DatabaseType get type;
  bool get isConnected;
  Stream<ConnectionEvent> get events;

  Future<void> connect(ConnectionProfile profile);
  Future<void> disconnect();
  Future<void> cancelCurrentQuery();

  Stream<ResultPage> executeQuery(String sql, {int pageSize = 500});
  Future<int> executeUpdate(String sql);
  Future<void> beginTransaction();
  Future<void> commit();
  Future<void> rollback();

  Future<List<SchemaInfo>> listSchemas();
  Future<List<TableInfo>> listTables(String schema);
  Future<List<ColumnInfo>> listColumns(String schema, String table);
  Future<List<IndexInfo>> listIndexes(String schema, String table);
  Future<List<ForeignKeyInfo>> listForeignKeys(String schema, String table);
  Future<List<ViewInfo>> listViews(String schema);
  Future<List<RoutineInfo>> listRoutines(String schema);

  Future<String> generateDDL(DatabaseObject object);
  Future<int> getRowCount(String schema, String table);
}
```

### 4.2 ResultPage
```dart
@freezed
class ResultPage with _$ResultPage {
  const factory ResultPage({
    required int pageIndex,
    required int pageSize,
    required List<String> columns,
    required List<List<dynamic>> rows,
    required int? totalRows,         // null if unknown
    required Duration queryDuration,
    String? error,
  }) = _ResultPage;
}
```

### 4.3 ConnectionProfile
```dart
@freezed
class ConnectionProfile with _$ConnectionProfile {
  const factory ConnectionProfile({
    required String id,
    required String name,
    required DatabaseType type,
    required String host,
    required int port,
    required String database,
    required String username,
    // password fetched from secure storage at connect time
    SSLConfig? ssl,
    SSHConfig? ssh,
    required ConnectionPoolConfig pool,
    required String colorHex,
    required DateTime createdAt,
  }) = _ConnectionProfile;
}
```

---

## 5. Autocomplete Architecture

```
AutocompleteHandler
  ├── tokenize(sql, cursorPosition) → TokenContext
  ├── resolve(context, schemaCache) → List<Completion>
  └── rank(completions) → List<Completion>

TokenContext
  ├── triggerType: keyword | table | column | alias | schema
  ├── prefix: String
  └── referencedTables: List<String>

SchemaMetaCache (per connection)
  ├── tables: Trie<TableInfo>
  ├── columns: Map<tableName, Trie<ColumnInfo>>
  └── keywords: List<String> (dialect-specific)
```

Cache invalidated on DDL operations or manual refresh.

---

## 6. ER Diagram Layout Algorithm

Run in isolate:
```
Input: List<TableNode>, List<FKEdge>
Algorithm: Fruchterman–Reingold (force-directed)
  iterations: 200
  cooling: linear from 100 to 1
  repulsion: O(n²) naive — switch to Barnes-Hut if n > 50
Output: Map<tableId, Offset>
```

---

## 7. Export Pipeline

```
ExportService.export(config: ExportConfig)
  ├── csv  → write rows to StringSink → File.writeAsString (streamed)
  ├── json → JsonEncoder.withIndent + stream
  ├── xlsx → excel package, add rows in batches of 5000
  └── sql  → generate INSERT statements per row, batched
```

All exports run in Dart isolate. Progress reported via `Stream<double>`.

---

## 8. Error Handling Strategy

| Error Type | Behavior |
|-----------|---------|
| Connection refused | Show inline error banner in sidebar tile |
| Query syntax error | Highlight line in editor, show error in results panel |
| Query timeout | Auto-cancel, show timeout message with retry button |
| SSL handshake failure | Show detailed SSL error dialog with fix suggestions |
| SSH auth failure | Re-open SSH config with error highlighted |
| Import row error | Log to in-app error table, continue or abort per config |
| App-level exception | Caught at root, show snackbar, log to file |

---

## 9. Keyboard Shortcuts (Default)

| Action | Windows/Linux | macOS |
|--------|-------------|-------|
| Run query | F5 | ⌘↩ |
| Run selection | Ctrl+Enter | Ctrl+↩ |
| Format SQL | Ctrl+Shift+F | ⌘⇧F |
| New tab | Ctrl+T | ⌘T |
| Close tab | Ctrl+W | ⌘W |
| Open connection | Ctrl+Shift+N | ⌘⇧N |
| Toggle explorer | Ctrl+B | ⌘B |
| Query history | Ctrl+H | ⌘H |
| Commit | Ctrl+Shift+C | ⌘⇧C |
| Rollback | Ctrl+Shift+R | ⌘⇧R |
| Find in editor | Ctrl+F | ⌘F |
| Explain plan | Ctrl+Shift+E | ⌘⇧E |

---

## 10. Theming

Material 3 with custom ColorScheme:

```dart
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF1565C0),  // Deep Blue
    brightness: Brightness.dark,         // or light
  ),
  // Editor background separate from app background
  extensions: [DBStudioTheme(
    editorBackground: Color(0xFF1E1E1E),
    gridRowAlternate: Color(0xFF2A2A2A),
    nullValueColor: Color(0xFF888888),
    pendingEditColor: Color(0xFFFFEB3B).withOpacity(0.2),
  )],
)
```
