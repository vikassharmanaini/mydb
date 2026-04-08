# RESEARCH.md — DBStudio Flutter Desktop App

## 1. DBeaver Feature Inventory (Target Parity)

### 1.1 Connection Management
- Multi-connection support (simultaneous open connections)
- Connection profiles: host, port, DB name, user, password, SSL, SSH tunnel
- Connection pooling per profile (min/max pool size, idle timeout)
- Test-connection before save
- Secure credential storage (OS keychain / encrypted local store)
- Connection grouping / folders in sidebar

### 1.2 Supported Database Drivers (Priority Order)
| Priority | Driver | Protocol |
|----------|--------|----------|
| P0 | PostgreSQL | libpq / dart_postgres |
| P0 | MySQL / MariaDB | MySQL wire protocol |
| P0 | SQLite | embedded via sqlite3 FFI |
| P1 | Microsoft SQL Server | TDS protocol |
| P1 | Oracle | OCI / JDBC bridge |
| P2 | MongoDB | mongo wire |
| P2 | Redis | RESP |
| P3 | Cassandra, DynamoDB, BigQuery | custom |

### 1.3 Database Explorer (Object Tree)
- Schemas → Tables → Columns, Indexes, Constraints, Triggers
- Views, Materialized Views
- Stored Procedures, Functions
- Sequences, Enums, Types (PostgreSQL)
- Users & Roles
- Tablespaces
- Live refresh / manual refresh per node
- Right-click context menus: DDL, Data, Alter, Drop, Rename

### 1.4 SQL Editor
- Multi-tab editor (per connection or cross-connection)
- Syntax highlighting (per dialect)
- Auto-complete: keywords, table names, column names, aliases
- SQL formatter / beautifier
- Query history (persistent)
- Query bookmarks / snippets library
- Execution plan (EXPLAIN / EXPLAIN ANALYZE)
- Run selected text
- Split view: editor + results
- Multiple result panels per query
- Error highlighting with line markers

### 1.5 Data Grid / Results Viewer
- Virtual scrolling (millions of rows, load on demand)
- Inline cell editing with type-aware editors (date picker, JSON editor, bool toggle)
- Row add / delete
- Commit / Rollback controls
- Column ordering, resizing, hiding
- Column filter (per-column filter bar)
- Global text search across result
- Export: CSV, JSON, Excel, SQL INSERT, XML
- Copy selection as CSV / JSON
- BLOB / CLOB viewer (hex for binary, text for clob, image preview for images)
- Pagination control

### 1.6 ER Diagram
- Auto-generate ER diagram from schema
- Drag-to-rearrange tables
- Relationship lines (FK detection)
- Zoom / pan
- Export as PNG/SVG

### 1.7 Schema / DDL Tools
- Generate DDL for any object
- Compare two schemas (diff viewer)
- Schema migration scripts
- Import DDL from file

### 1.8 Data Import / Export
- Import CSV/Excel into table
- Column mapping UI
- Export entire schema data
- Schedule exports (optional v2)

### 1.9 Metadata & Statistics
- Table row counts
- Index statistics
- Table size on disk
- Query performance statistics

### 1.10 Dashboard / Monitoring (v2)
- Active connections count
- Running queries
- Lock monitor
- Session list

---

## 2. Technology Research

### 2.1 Flutter Desktop
- **Platform:** Windows, macOS, Linux via `flutter build windows/macos/linux`
- **Rendering:** Impeller (macOS/iOS), Skia fallback (Windows/Linux)
- **Window management:** `window_manager` package
- **Multi-window:** `desktop_multi_window` or custom platform channels
- **System tray:** `system_tray` package

### 2.2 Database Connectivity (Dart native)
| DB | Package | Notes |
|----|---------|-------|
| PostgreSQL | `dart_postgres` / `postgres` | Pure Dart, no FFI |
| MySQL | `mysql_client` | Pure Dart |
| SQLite | `sqlite3` (FFI) | Bundled native binary |
| MSSQL | no pure Dart — use `dart:ffi` + ODBC bridge or HTTP proxy sidecar |
| MongoDB | `mongo_dart` | Pure Dart |
| Redis | `redis` | Pure Dart |

**SSH Tunnel:** `dartssh2` — pure Dart SSH2 client. Create a local port-forward before connecting.

### 2.3 SQL Parsing & Highlighting
- **Code editor widget:** `flutter_code_editor` or `re_editor` (better performance)
- **Syntax highlighting grammar:** `highlight` package with SQL grammar
- **SQL formatter:** custom Dart port or call `sql-formatter` via Dart FFI / subprocess

### 2.4 Virtual Scrolling / Data Grid
- `two_dimensional_scrollables` (Flutter team) — base
- Custom `TableView` built on `TwoDimensionalScrollView`
- Lazy loading rows in pages of 500

### 2.5 State Management
- **Riverpod** (code-gen) — chosen for:
  - Fine-grained reactivity
  - Async providers with caching
  - Easy testing
  - No BuildContext dependency

### 2.6 Local Storage
- **App settings:** `shared_preferences` or `hive`
- **Connection profiles:** `hive` encrypted box (AES-256)
- **Query history:** SQLite (ironic) via `drift` ORM
- **Credentials:** `flutter_secure_storage` → OS keychain on all platforms

### 2.7 Rendering Large Data
- Never load full result set into memory
- Stream rows from DB cursor in pages
- Keep only 3 pages in memory (virtual window)
- Use `RepaintBoundary` on each cell group

### 2.8 ER Diagram Rendering
- `flutter_graph_view` or custom `CustomPainter`
- Position algorithm: force-directed (Fruchterman–Reingold)
- `InteractiveViewer` for pan/zoom

---

## 3. Competitive Analysis

| Feature | DBeaver | TablePlus | DataGrip | DBngin |
|---------|---------|-----------|----------|--------|
| Free | Community ✓ | Freemium | Paid | Free |
| Cross-platform | ✓ | Mac/Win | ✓ | Mac only |
| ER Diagram | ✓ | ✗ | ✓ | ✗ |
| SSH Tunnel | ✓ | ✓ | ✓ | ✗ |
| Dark theme | ✓ | ✓ | ✓ | ✓ |
| Flutter-based | ✗ | ✗ | ✗ | ✗ |

**Opportunity:** First serious Flutter-native DB tool. Native performance, single codebase, beautiful Material 3 UI.

---

## 4. Key Engineering Challenges

1. **MSSQL / Oracle on pure Dart** — requires ODBC bridge sidecar or Dart FFI to native drivers
2. **SSH tunnel lifecycle** — must close tunnel on connection drop, handle reconnect
3. **SQL autocomplete** — requires schema metadata cache + trie-based lookup
4. **Large BLOB streaming** — must not buffer full BLOB in memory
5. **Cross-platform file dialogs** — `file_picker` handles this
6. **ER diagram layout** — O(n²) force simulation; needs isolate offloading
7. **Secure credential storage** — different APIs per OS, abstracted via `flutter_secure_storage`
