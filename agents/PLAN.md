# PLAN.md — Development Plan: DBStudio

## Vision
Build DBStudio — a Flutter-native, cross-platform database management application with full DBeaver feature parity. The app targets developers and DBAs who want a fast, modern, keyboard-first tool that runs natively on Windows, macOS, and Linux.

---

## Guiding Principles
1. **Performance first** — virtual scrolling, async everything, isolates for CPU work
2. **Clean architecture** — strict layer separation; UI never touches DB driver directly  
3. **Demand-based loading** — nothing loads until the user needs it (tree nodes, schema metadata, result pages)
4. **Security by default** — credentials in OS keychain, SSL on by default, no telemetry
5. **Plugin-based drivers** — adding a new DB type requires zero changes to core code

---

## Milestones

### Milestone 0 — Foundation (Week 1)
**Goal:** Working Flutter shell on all 3 platforms  
**Deliverables:**
- Project scaffolded with all dependencies
- All data models defined and code-generated
- App launches with three-pane layout (empty)
- Driver registry wired up
- Local DB (Drift) schema migrated

**Done when:** `flutter build windows && flutter build macos && flutter build linux` all succeed with zero errors.

---

### Milestone 1 — Connect & Explore (Week 2–3)
**Goal:** User can connect to PostgreSQL and browse the schema tree  
**Deliverables:**
- PostgreSQL driver fully implemented (connect, query, metadata)
- SSH tunnel service working
- Connection dialog: all fields, test connection, save to keychain
- Object tree: schemas → tables → columns (lazy loaded)
- Context menus on tree nodes

**Done when:** Tester can connect to a real PostgreSQL server, browse tables, and see columns in the tree.

---

### Milestone 2 — SQL Editor & Results (Week 4–5)
**Goal:** User can write and execute SQL and see results  
**Deliverables:**
- SQL editor with syntax highlighting and autocomplete
- Query execution with streaming results
- Virtual-scroll data grid (500-row pages)
- Query history panel
- SQL formatter

**Done when:** Tester runs `SELECT * FROM large_table` (1M rows) and scrolls at 60fps without lag.

---

### Milestone 3 — Data Editing (Week 6)
**Goal:** User can edit data inline  
**Deliverables:**
- Inline cell editing for all types (text, number, date, bool, JSON, BLOB)
- Pending edit indicators (yellow row highlight)
- Commit / Rollback workflow
- Row add / delete
- Export results to CSV, JSON, Excel

**Done when:** Tester can edit a cell, add a row, delete a row, commit changes, and verify in DB.

---

### Milestone 4 — MySQL + SQLite Drivers (Week 7)
**Goal:** Multi-database support  
**Deliverables:**
- MySQL/MariaDB driver (connect, query, metadata, DDL)
- SQLite driver (file-based + in-memory)
- Driver switcher in connection dialog
- Dialect-aware SQL highlighting

**Done when:** All three drivers pass integration tests against real DB instances.

---

### Milestone 5 — Schema Tools & ER Diagram (Week 8–9)
**Goal:** Schema visualization and comparison  
**Deliverables:**
- DDL viewer for all object types
- ER diagram with force-directed layout
- Table cards, FK arrows, drag/zoom
- PNG/SVG export from ER diagram
- Schema compare + diff viewer

**Done when:** Tester opens ER diagram for a 50-table schema and sees correct FK relationships, can drag tables, and export as PNG.

---

### Milestone 6 — Data Import & Settings (Week 10)
**Goal:** Complete user experience  
**Deliverables:**
- CSV/Excel import with column mapping UI
- App settings (theme, font, shortcuts)
- Dark/light theme
- Session restore after crash
- Snippet library

**Done when:** Full app walkthrough completes without placeholder/TODO UI.

---

### Milestone 7 — MSSQL Driver + Quality (Week 11)
**Goal:** Enterprise DB support + quality bar  
**Deliverables:**
- MSSQL driver (via ODBC bridge or FFI)
- 80%+ test coverage on services + state
- Performance profiling + optimization pass
- Memory leak audit
- All keyboard shortcuts functional

---

### Milestone 8 — Packaging & Release (Week 12)
**Goal:** Distributable app  
**Deliverables:**
- Windows .exe installer (NSIS)
- macOS .dmg with notarization
- Linux .deb + .AppImage
- GitHub Actions CI
- README with screenshots
- v1.0.0 release

---

## Risk Register

| Risk | Impact | Mitigation |
|------|--------|-----------|
| MSSQL pure-Dart driver doesn't exist | High | Use ODBC sidecar binary; or defer to v2 |
| `re_editor` performance issues at scale | Medium | Evaluate `flutter_code_editor` as fallback |
| Force layout slow for 100+ tables | Medium | Switch to Barnes-Hut tree if n>50 |
| OS keychain API differences break on Linux | Medium | `flutter_secure_storage` handles this; test on all 3 OS early |
| Flutter rendering performance on Windows | Low | Impeller not default on Windows yet; use Skia + profile |

---

## Velocity Assumptions
- Single senior Flutter developer: 12 weeks
- With 15 specialized agents (parallel): 3–4 weeks for v1 feature-complete
- Testing + packaging adds 1 week regardless

---

## Definition of Done (Full App)
- [ ] All FR-01 through FR-10 requirements met
- [ ] All NFR-01 through NFR-06 requirements met
- [ ] Zero `dart analyze` warnings in CI
- [ ] 80% test coverage on `lib/services/` and `lib/state/`
- [ ] App cold start < 2s on reference hardware (M1 Mac / Ryzen 5 + 16GB RAM)
- [ ] Grid scrolls 1M rows at 60fps
- [ ] No credentials stored in plaintext (automated security scan)
- [ ] Installers built and tested on all 3 platforms
- [ ] CHANGELOG.md updated
