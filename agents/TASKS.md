# TASKS.md — Development Task Breakdown: DBStudio

## Phase 0: Project Bootstrap (Agent: Setup)
- [ ] T-000: `flutter create dbstudio --platforms=windows,macos,linux`
- [ ] T-001: Add all pubspec dependencies, run `flutter pub get`
- [ ] T-002: Configure `analysis_options.yaml` (flutter_lints + strict)
- [ ] T-003: Setup `build_runner` code generation pipeline
- [ ] T-004: Create folder structure as per SPEC.md §3
- [ ] T-005: Configure `go_router` routes skeleton
- [ ] T-006: Setup Riverpod `ProviderScope` in `main.dart`
- [ ] T-007: Register all drivers in `DriverRegistry`
- [ ] T-008: Setup `logger` with file sink

---

## Phase 1: Core Data Models (Agent: Models)
- [ ] T-100: `ConnectionProfile` (freezed + json_serializable)
- [ ] T-101: `SSHConfig`, `SSLConfig`, `ConnectionPoolConfig`
- [ ] T-102: `DatabaseType` enum + display names + default ports
- [ ] T-103: `DatabaseObject` sealed class hierarchy (table, view, column, index, fk, proc, func, schema, sequence, trigger)
- [ ] T-104: `QueryResult`, `ResultPage`, `ResultRow`
- [ ] T-105: `SchemaMetadata`, `TableInfo`, `ColumnInfo`, `IndexInfo`, `ForeignKeyInfo`, `ViewInfo`, `RoutineInfo`
- [ ] T-106: `AppSettings` (freezed)
- [ ] T-107: `ExportConfig`, `ImportConfig`
- [ ] T-108: `QueryHistoryEntry`, `Snippet`

---

## Phase 2: Driver Abstraction Layer (Agent: Drivers)
- [ ] T-200: Define `DatabaseDriver` abstract interface (SPEC §4.1)
- [ ] T-201: Define `ConnectionEvent` sealed class (connected, disconnected, error, reconnecting)
- [ ] T-202: `DriverRegistry` with `register()` and `create()`

### PostgreSQL Driver
- [ ] T-210: `PostgresDriver.connect()` using `dart_postgres`
- [ ] T-211: `PostgresDriver.executeQuery()` → stream ResultPage
- [ ] T-212: `PostgresDriver.executeUpdate()`
- [ ] T-213: `PostgresDriver` transaction support (begin/commit/rollback)
- [ ] T-214: `PostgresDriver.cancelCurrentQuery()` using pg_cancel_backend
- [ ] T-215: `PostgresMetadata.listSchemas/Tables/Columns/Indexes/FKs/Views/Routines`
- [ ] T-216: `PostgresMetadata.generateDDL()` for all object types
- [ ] T-217: PostgreSQL connection pool (min 1, max 10)

### MySQL Driver
- [ ] T-220: `MySQLDriver.connect()` using `mysql_client`
- [ ] T-221: `MySQLDriver.executeQuery()` → stream ResultPage
- [ ] T-222: `MySQLDriver.executeUpdate()`
- [ ] T-223: `MySQLDriver` transaction support
- [ ] T-224: `MySQLMetadata` — all metadata methods
- [ ] T-225: `MySQLMetadata.generateDDL()`

### SQLite Driver
- [ ] T-230: `SQLiteDriver.connect()` — file path or in-memory
- [ ] T-231: `SQLiteDriver.executeQuery()`
- [ ] T-232: `SQLiteDriver.executeUpdate()`
- [ ] T-233: `SQLiteMetadata` — all metadata methods

### SSH Tunnel Service
- [ ] T-240: `SSHTunnelService.openTunnel(sshConfig, remoteHost, remotePort)` → localPort
- [ ] T-241: Keepalive ping every 30s
- [ ] T-242: Auto-close tunnel on connection drop
- [ ] T-243: Reconnect tunnel with exponential backoff

---

## Phase 3: Local Storage & Services (Agent: Storage)
- [ ] T-300: Drift `AppDatabase` setup with migrations
- [ ] T-301: `QueryHistoryTable` + `HistoryDao` (insert, list recent, search, delete)
- [ ] T-302: `SnippetsTable` + `SnippetDao` (CRUD)
- [ ] T-303: `CredentialService` using `flutter_secure_storage`
- [ ] T-304: `ConnectionProfileRepository` — Hive encrypted box (store/load/delete profiles)
- [ ] T-305: `AppSettingsRepository` — JSON file read/write
- [ ] T-306: `SessionRestoreService` — save/restore open tabs on crash

---

## Phase 4: Application Services (Agent: Services)
- [ ] T-400: `ConnectionService` — open, close, manage open connections map
- [ ] T-401: `QueryService.execute()` — delegates to driver, wraps stream, tracks time
- [ ] T-402: `QueryService.cancel()` — delegates to driver.cancelCurrentQuery
- [ ] T-403: `SchemaService.getChildren(node)` — fetches and caches metadata
- [ ] T-404: `SchemaMetaCache` — trie-based cache, per connection, invalidated on DDL
- [ ] T-405: `ExportService` — CSV, JSON, XLSX, SQL INSERT (all in isolate)
- [ ] T-406: `ImportService` — CSV/Excel → table (column mapping, preview, error log)
- [ ] T-407: `FormatterService` — SQL formatter (Dart implementation)
- [ ] T-408: `AutocompleteService` — tokenize + trie lookup on schema cache

---

## Phase 5: State (Riverpod) (Agent: State)
- [ ] T-500: `connectionProfilesProvider` — CRUD on profiles
- [ ] T-501: `openConnectionsProvider` — map of connectionId → driver
- [ ] T-502: `explorerStateProvider(connectionId)` — tree node loading + cache
- [ ] T-503: `editorTabsProvider` — list of open tabs, active tab
- [ ] T-504: `queryStateProvider(tabId)` — execution state, results stream
- [ ] T-505: `gridStateProvider(tabId)` — page, sort, filter, pending edits
- [ ] T-506: `schemaCacheProvider(connectionId)` — autocomplete metadata
- [ ] T-507: `settingsProvider` — app settings, persisted
- [ ] T-508: `historyProvider(connectionId)` — recent queries list

---

## Phase 6: UI — Layout & Shell (Agent: UI-Shell)
- [ ] T-600: `AppShell` — three-pane layout (sidebar | editor/content | optional right panel)
- [ ] T-601: `SplitPane` — resizable divider widget (horizontal + vertical)
- [ ] T-602: `CustomTabBar` — tabs with close button, drag reorder, pin, detach
- [ ] T-603: `TopMenuBar` — File / Edit / View / Query / Tools menus
- [ ] T-604: `StatusBar` — connection indicator, row count, exec time, zoom

---

## Phase 7: UI — Connection Dialog (Agent: UI-Connections)
- [ ] T-700: `ConnectionListPanel` — shows all profiles, grouped, with color dots
- [ ] T-701: `NewConnectionDialog` — stepper: choose DB type → fill params → test → save
- [ ] T-702: `SSHConfigForm` — host, port, user, key file picker, password
- [ ] T-703: `SSLConfigForm` — mode (disable/allow/require/verify), cert file pickers
- [ ] T-704: Connection test UI — spinner, green tick, red error with message

---

## Phase 8: UI — Object Explorer (Agent: UI-Explorer)
- [ ] T-800: `ObjectTree` — lazy-loading tree using `explorerStateProvider`
- [ ] T-801: `TreeNodeWidget` — icon + label, expand arrow, loading spinner
- [ ] T-802: Context menu: table → Open Data, View DDL, Copy Name, Generate SELECT, Drop
- [ ] T-803: Context menu: schema → New Table, ER Diagram, Schema Compare, Refresh
- [ ] T-804: Context menu: column → Copy Name, View Type
- [ ] T-805: Object search bar — filter tree by name (fuzzy match)

---

## Phase 9: UI — SQL Editor (Agent: UI-Editor)
- [ ] T-900: `SQLEditorTab` — `re_editor` widget configured with SQL grammar
- [ ] T-901: `EditorToolbar` — Run, Explain, Format, History, Snippets, Connection selector
- [ ] T-902: Autocomplete popup — custom overlay widget, keyboard navigable
- [ ] T-903: Error gutter — red markers on error lines from last execution
- [ ] T-904: `QueryHistoryPanel` — slide-out panel, click to load query into editor
- [ ] T-905: `SnippetPanel` — library of saved queries with tags and search
- [ ] T-906: `ExecutionPlanTab` — shows EXPLAIN output as text + tree visualization
- [ ] T-907: Multiple results tabs — when query returns multiple result sets

---

## Phase 10: UI — Data Grid (Agent: UI-Grid)
- [ ] T-1000: `DataGrid` widget — `TwoDimensionalScrollView` based, virtual rows
- [ ] T-1001: `GridHeader` — sortable columns, resize handle, hide/show menu
- [ ] T-1002: `GridCell` — read mode + edit mode toggle on double-click
- [ ] T-1003: `TextCellEditor` — inline text field
- [ ] T-1004: `DateCellEditor` — date/datetime picker popup
- [ ] T-1005: `BoolCellEditor` — checkbox toggle
- [ ] T-1006: `JSONCellEditor` — expandable JSON viewer with syntax highlighting
- [ ] T-1007: `BlobCellViewer` — hex dump for binary; image preview for image blobs
- [ ] T-1008: `FilterBar` — per-column filter inputs above header row
- [ ] T-1009: `GridFooter` — page selector, row count, commit/rollback buttons
- [ ] T-1010: `ExportDialog` — format selector, path picker, progress bar
- [ ] T-1011: NULL value rendering (grey italic "NULL" text)
- [ ] T-1012: Pending-edit row highlight (yellow tint)
- [ ] T-1013: Right-click context menu on cell: copy, copy row as JSON/CSV, set null

---

## Phase 11: UI — ER Diagram (Agent: UI-ER)
- [ ] T-1100: `ERCanvas` — `InteractiveViewer` wrapping `CustomPaint`
- [ ] T-1101: `ForceLayout` isolate — input: tables+FKs → output: positions
- [ ] T-1102: `TableCard` painter — table name header + column rows
- [ ] T-1103: `RelationPainter` — curved/straight arrows with FK label
- [ ] T-1104: Drag table card to new position
- [ ] T-1105: Table filter sidebar (show/hide specific tables)
- [ ] T-1106: Export canvas as PNG (`toImage()`)
- [ ] T-1107: Export canvas as SVG (custom SVG serializer)

---

## Phase 12: UI — Schema & DDL Tools (Agent: UI-Schema)
- [ ] T-1200: `DDLViewer` — syntax-highlighted DDL in read-only code view
- [ ] T-1201: `SchemaCompareDialog` — pick two connections/schemas
- [ ] T-1202: `DiffViewer` — side-by-side diff, color-coded add/remove/change
- [ ] T-1203: `GenerateMigrationDialog` — shows migration SQL, copy/download button
- [ ] T-1204: `ImportDDLDialog` — file picker + execute DDL script

---

## Phase 13: UI — Settings (Agent: UI-Settings)
- [ ] T-1300: `SettingsPage` — sidebar-based settings sections
- [ ] T-1301: `AppearanceSettings` — theme, font, font size
- [ ] T-1302: `EditorSettings` — tab size, line wrap, autocomplete toggle
- [ ] T-1303: `GridSettings` — page size, null display text, date format
- [ ] T-1304: `ShortcutSettings` — list of shortcuts, click to remap
- [ ] T-1305: `ProxySettings` — HTTP proxy host/port/auth

---

## Phase 14: Testing (Agent: QA)
- [ ] T-1400: Unit tests for all Driver implementations (mock TCP)
- [ ] T-1401: Unit tests for all Services
- [ ] T-1402: Unit tests for State notifiers
- [ ] T-1403: Widget tests for DataGrid (virtual scroll, cell editing)
- [ ] T-1404: Widget tests for SQLEditor (autocomplete, error markers)
- [ ] T-1405: Widget tests for ObjectTree (lazy load, context menus)
- [ ] T-1406: Integration tests: connect → query → edit → export flow
- [ ] T-1407: Performance test: render 1M rows at 60fps

---

## Phase 15: Packaging & CI (Agent: DevOps)
- [ ] T-1500: GitHub Actions CI: lint + test on push
- [ ] T-1501: Windows build + NSIS installer
- [ ] T-1502: macOS build + .dmg
- [ ] T-1503: Linux .deb + .AppImage
- [ ] T-1504: Code signing (macOS notarization, Windows Authenticode)
- [ ] T-1505: Auto-update via `upgrader` package
- [ ] T-1506: Crash reporting (Sentry optional, opt-in)
