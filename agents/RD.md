# RD.md — Requirements Document: DBStudio

## Project Overview
**Name:** DBStudio  
**Type:** Flutter Desktop Application (Windows / macOS / Linux)  
**Goal:** A full-featured, open-source database management tool with feature parity to DBeaver Community, built entirely in Flutter/Dart.

---

## 1. Functional Requirements

### FR-01: Connection Management
- FR-01.1: User can create, edit, delete, duplicate connection profiles
- FR-01.2: Each profile stores: type, host, port, database, username, password (encrypted), SSL config, SSH tunnel config, display name, color tag
- FR-01.3: Connections are grouped in a collapsible sidebar tree
- FR-01.4: User can open multiple connections simultaneously
- FR-01.5: System must test connection before saving profile
- FR-01.6: Credentials are stored in OS keychain, never plaintext
- FR-01.7: Supports SSH tunnel with key-based and password auth
- FR-01.8: Connection timeout and retry policy configurable per profile

### FR-02: Database Object Explorer
- FR-02.1: Left sidebar shows live tree of database objects
- FR-02.2: Tree supports lazy loading — children loaded only when node is expanded
- FR-02.3: Tree nodes: Connection → Database/Schema → Tables / Views / Procedures / Functions / Sequences / Types / Indexes / Triggers / Users
- FR-02.4: Right-click context menu on each node type with relevant actions
- FR-02.5: Search/filter box to find objects by name within a connection
- FR-02.6: Manual refresh button and auto-refresh on DDL operations

### FR-03: SQL Editor
- FR-03.1: Multi-tab editor, each tab bound to a connection
- FR-03.2: Syntax highlighting for: PostgreSQL, MySQL, SQLite, MSSQL, generic SQL
- FR-03.3: Keyword autocomplete + schema-aware autocomplete (table names, columns)
- FR-03.4: Run full query (F5) or run selected text (Ctrl+Enter)
- FR-03.5: Execution stops on error (configurable: stop-on-error / continue)
- FR-03.6: Show query execution time
- FR-03.7: SQL formatter (Ctrl+Shift+F)
- FR-03.8: Persistent query history per connection (last 1000 queries)
- FR-03.9: Snippet library — save and name frequently used queries
- FR-03.10: Show execution plan (EXPLAIN) in separate tab
- FR-03.11: Multi-cursor, bracket matching, line numbers, code folding

### FR-04: Results Data Grid
- FR-04.1: Display query results in a virtual-scroll grid
- FR-04.2: Support ≥1,000,000 rows via pagination (page size: 500 rows default)
- FR-04.3: Inline cell editing with type-aware editors
- FR-04.4: Row-level add / delete with pending change indicator
- FR-04.5: Commit / Rollback buttons for DML changes
- FR-04.6: Column resize, reorder, hide/show
- FR-04.7: Per-column sort (click header)
- FR-04.8: Per-column filter bar (text, number range, date range, null check)
- FR-04.9: Export results: CSV, JSON, Excel (.xlsx), SQL INSERT statements
- FR-04.10: Copy selection as CSV or JSON
- FR-04.11: BLOB cells: open hex viewer; image BLOBs show thumbnail preview
- FR-04.12: NULL values visually distinct from empty string

### FR-05: Table Data Viewer
- FR-05.1: Double-click table in explorer opens data grid for that table
- FR-05.2: Data viewer uses same grid as query results
- FR-05.3: Shows total row count
- FR-05.4: Filtering, sorting, editing all supported

### FR-06: DDL Viewer & Schema Tools
- FR-06.1: Right-click any object → "View DDL" shows CREATE statement
- FR-06.2: DDL is syntax-highlighted and copyable
- FR-06.3: Schema compare: pick two schemas → side-by-side diff
- FR-06.4: Generate migration SQL from schema diff
- FR-06.5: Execute DDL scripts from file

### FR-07: ER Diagram
- FR-07.1: Right-click schema → "Open ER Diagram"
- FR-07.2: Auto-layout using force-directed algorithm
- FR-07.3: Tables as cards, FK relationships as labeled arrows
- FR-07.4: Drag tables, zoom/pan canvas
- FR-07.5: Export diagram as PNG or SVG
- FR-07.6: Filter: show only selected tables

### FR-08: Data Import
- FR-08.1: Import CSV / Excel file into existing table
- FR-08.2: Column mapping UI (source column → target column)
- FR-08.3: Preview first 20 rows before import
- FR-08.4: On-error: skip row / abort / log

### FR-09: Application Settings
- FR-09.1: Global theme: Light / Dark / System
- FR-09.2: Font family and size for editor and grid
- FR-09.3: Default page size for data grid
- FR-09.4: Keyboard shortcut customization
- FR-09.5: Proxy settings
- FR-09.6: Auto-save editor tabs on close

### FR-10: Multi-Window & Tabs
- FR-10.1: Detach any editor tab into its own OS window
- FR-10.2: Drag-and-drop tab reordering
- FR-10.3: Pin tabs

---

## 2. Non-Functional Requirements

### NFR-01: Performance
- NFR-01.1: App cold start < 2 seconds
- NFR-01.2: SQL editor keystroke-to-render latency < 16 ms
- NFR-01.3: Grid scroll at 60 fps with 1M rows loaded (virtual window)
- NFR-01.4: DB metadata fetch must not block UI (all async with loading indicators)
- NFR-01.5: Memory usage < 300 MB for typical session

### NFR-02: Reliability
- NFR-02.1: Connection drop → automatic reconnect with user notification
- NFR-02.2: App crash → restore open tabs and unsaved editor content on next launch
- NFR-02.3: Long queries cancellable without killing the connection

### NFR-03: Security
- NFR-03.1: No plaintext credentials on disk
- NFR-03.2: SSL/TLS enforced for remote connections (opt-out allowed)
- NFR-03.3: SSH private keys stored encrypted
- NFR-03.4: No telemetry without explicit opt-in

### NFR-04: Usability
- NFR-04.1: Keyboard-first: all core actions accessible without mouse
- NFR-04.2: Context menus on right-click everywhere
- NFR-04.3: Inline loading spinners, not full-screen blockers
- NFR-04.4: Undo/redo in editor (Ctrl+Z / Ctrl+Y)

### NFR-05: Extensibility
- NFR-05.1: Driver system plugin-based — new DB types added without touching core
- NFR-05.2: UI panels registrable — future panels don't require core changes

### NFR-06: Platform Support
- NFR-06.1: Windows 10+, macOS 12+, Ubuntu 22+
- NFR-06.2: ARM64 and x86_64 builds
- NFR-06.3: Installers: .exe (NSIS), .dmg, .deb / .AppImage

---

## 3. Out of Scope (v1)
- Mobile app
- Cloud sync
- Team collaboration / shared workspaces
- Paid features / licensing
- Plugin marketplace
- DBeaver import of existing profiles (v2 roadmap)
