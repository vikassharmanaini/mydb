# AGENTS.md — Agent Definitions: DBStudio

## Overview
DBStudio is built by a team of specialized AI agents. Each agent owns a slice of the codebase and has clear input/output contracts with other agents. Agents must read `CLAUDE.md` before writing any code. All agents communicate via the shared file system (no live calls between agents).

---

## Agent 1: Setup Agent
**Role:** Project scaffolding and configuration  
**Reads:** SPEC.md, ARCHITECTURE.md  
**Writes:** `pubspec.yaml`, `lib/main.dart`, `lib/app.dart`, all empty folder stubs, `analysis_options.yaml`, `build_runner` config  
**Output contract:** After this agent, `flutter pub get` and `flutter build` must succeed with zero errors.  
**Does NOT:** Write any feature code.

---

## Agent 2: Models Agent
**Role:** All Dart data models  
**Reads:** SPEC.md §4, RD.md §1  
**Writes:** Everything in `lib/models/`  
**Rules:**
- Use `freezed` + `json_serializable` for every model
- Run `build_runner` after creating models
- No Flutter imports in models — pure Dart only
- Every model has: equality, copyWith, toJson, fromJson
- Use sealed classes for polymorphic types (DatabaseObject hierarchy)

**Output contract:** All models compile; `flutter test test/models/` passes.

---

## Agent 3: Drivers Agent
**Role:** All database driver implementations  
**Reads:** ARCHITECTURE.md §2.4, SPEC.md §4.1, RESEARCH.md §2.2  
**Writes:** Everything in `lib/drivers/`  
**Rules:**
- `DatabaseDriver` interface must be faithfully implemented — no skipped methods
- Never throw raw exceptions — wrap in typed `DBStudioException` subclasses
- `executeQuery()` must return `Stream<ResultPage>` — never load full result set
- Connection pool logic lives in driver, not caller
- SSH tunnel: `SSHTunnelService` is injected, not created in driver
- All metadata queries must be tested with mock DB responses

**Output contract:** Unit tests in `test/drivers/` pass for all drivers using mock connections.

---

## Agent 4: Storage Agent
**Role:** Local data persistence  
**Reads:** ARCHITECTURE.md §8, SPEC.md §3  
**Writes:** `lib/local_db/`, `lib/services/credential_service.dart`, `lib/services/session_restore_service.dart`  
**Rules:**
- Drift schema must have proper migrations from version 1
- `flutter_secure_storage` must be used for all credentials — no exceptions
- Hive boxes must use AES encryption key stored in secure storage
- Session restore: save to file on every tab change, restore on startup

**Output contract:** `test/storage/` passes; `flutter_secure_storage` calls verified not plaintext.

---

## Agent 5: Services Agent
**Role:** Application-layer business logic  
**Reads:** ARCHITECTURE.md §3, SPEC.md §4, TASKS.md Phase 4  
**Writes:** `lib/services/` (excluding credential and session restore)  
**Rules:**
- Services have no Flutter imports
- All long-running work (export, import, format) runs in `Isolate.run()`
- Services receive drivers via constructor injection (from Riverpod providers)
- `AutocompleteService` uses trie for O(log n) prefix lookup — not linear scan
- `SchemaService` caches metadata; cache invalidation happens on DDL events from driver stream

**Output contract:** `test/services/` passes with mocked drivers.

---

## Agent 6: State Agent
**Role:** Riverpod state management  
**Reads:** ARCHITECTURE.md §7, SPEC.md §2  
**Writes:** `lib/state/`  
**Rules:**
- Use code-gen (`@riverpod`) for all providers
- `AsyncNotifier` for anything with loading/error states
- Providers are scoped correctly — tab-level providers use `family`
- Never store raw Dart futures in provider state — use `AsyncValue`
- No UI code in state files

**Output contract:** `test/state/` passes; no provider circular dependencies.

---

## Agent 7: UI Shell Agent
**Role:** Main application layout, navigation, window management  
**Reads:** SPEC.md §3, TASKS.md Phase 6  
**Writes:** `lib/ui/layout/`, `lib/app.dart`  
**Rules:**
- `AppShell` must use `SplitPane` for all resizable sections
- Tab bar supports: drag-to-reorder, close, pin, detach-to-window
- Use `window_manager` for window title updates
- All keyboard shortcuts wired in `KeyboardShortcuts` utility

**Output contract:** App launches, shows three-pane layout, tabs are functional.

---

## Agent 8: UI Connections Agent
**Role:** Connection management UI  
**Reads:** RD.md FR-01, SPEC.md models  
**Writes:** `lib/ui/connections/`  
**Rules:**
- Password field never shown in plain text (obscured, reveal on hold)
- Test connection must show clear success/failure with error message
- Color picker for connection color tag
- SSH form: file picker for private key (using `file_picker`)

---

## Agent 9: UI Explorer Agent
**Role:** Database object tree  
**Reads:** RD.md FR-02, ARCHITECTURE.md §4 (lazy loading flow)  
**Writes:** `lib/ui/explorer/`  
**Rules:**
- Nodes lazy-load — no pre-fetching of entire tree
- Loading spinner inside node, not full panel
- Context menus built with `ContextMenuRegion` or equivalent
- Search filters visible nodes; does NOT trigger new DB calls

---

## Agent 10: UI Editor Agent
**Role:** SQL editor tabs  
**Reads:** RD.md FR-03, SPEC.md §5, §9  
**Writes:** `lib/ui/editor/`  
**Rules:**
- Use `re_editor` — do NOT build custom text editor from scratch
- Autocomplete overlay appears after 300ms debounce on keystroke
- Error gutter: parse DB error line number from error message
- History panel: paginated, filterable, click-to-load

---

## Agent 11: UI Grid Agent
**Role:** Data grid and cell editors  
**Reads:** RD.md FR-04, ARCHITECTURE.md §6, SPEC.md §3  
**Writes:** `lib/ui/grid/`  
**Rules:**
- `DataGrid` MUST be virtual — only render visible rows + 1 overscan page
- Cell editor opens in an overlay (not inline replacement that causes reflow)
- Pending edits tracked in `GridState` — not written to DB until Commit pressed
- Filter bar inputs debounced 500ms before triggering re-query
- BLOB viewer: use hex grid layout for binary data
- Image BLOB: detect if bytes are a valid image, show thumbnail

---

## Agent 12: UI ER Diagram Agent
**Role:** Entity-relationship diagram canvas  
**Reads:** SPEC.md §6, RD.md FR-07  
**Writes:** `lib/ui/er_diagram/`  
**Rules:**
- Force layout computation MUST run in `Isolate.run()` — never on main thread
- `InteractiveViewer` for all pan/zoom — do not reinvent
- Table card: show PK columns with key icon, FK columns with link icon
- Export to PNG via `RenderRepaintBoundary.toImage()`

---

## Agent 13: UI Schema Tools Agent
**Role:** DDL viewer, schema compare, diff  
**Reads:** RD.md FR-06, SPEC.md  
**Writes:** `lib/ui/schema/`  
**Rules:**
- DDL viewer uses same code editor widget as SQL editor (read-only mode)
- Diff viewer: color-code additions (green), removals (red), unchanged (grey)
- Schema compare runs in isolate to diff large schemas

---

## Agent 14: UI Settings Agent
**Role:** Settings pages  
**Reads:** RD.md FR-09, SPEC.md §10  
**Writes:** `lib/ui/settings/`  
**Rules:**
- All settings immediately applied (reactive via `settingsProvider`)
- Shortcut editor: listen for key combo on focus, display as chips
- Theme change applies to app without restart

---

## Agent 15: QA Agent
**Role:** Tests only — no production code  
**Reads:** All other agents' output  
**Writes:** `test/`, `integration_test/`  
**Rules:**
- 80%+ line coverage on services and state layers
- Use `mocktail` for mocking
- Widget tests must not depend on real DB connections
- Performance test: scroll 1M-row grid at 60fps (use `WidgetTester.pump`)

---

## Agent Execution Order
```
1. Setup Agent
2. Models Agent
3. Drivers Agent + Storage Agent  (parallel)
4. Services Agent
5. State Agent
6. UI Shell Agent
7. UI Connections Agent + UI Explorer Agent + UI Grid Agent  (parallel)
8. UI Editor Agent
9. UI ER Diagram Agent + UI Schema Tools Agent + UI Settings Agent  (parallel)
10. QA Agent
```

Agents MUST NOT skip their phase or work on future phases. If blocked by a missing dependency from a previous agent, document the blocker in `BLOCKERS.md` and move to the next task within your phase.
