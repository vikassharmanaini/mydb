# TASKS.md
# DevBrowser Pro — Task Board

> AI agents: pick ONE task at a time. Complete it fully. Update this file.
> Never start a task from a later phase while the current phase has open tasks.
> Status: [ ] = todo, [►] = in progress (with agent name), [✓] = done, [✗] = blocked

---

## HOW TO USE THIS FILE

1. Find the first `[ ]` task in the current active phase.
2. Change `[ ]` to `[►]` with your identifier: `[► Claude]`
3. Implement the task following SPEC.md requirements.
4. Change `[►]` to `[✓]` when done. Add a one-line note of what you did.
5. If blocked: change to `[✗]` and add a BLOCKED note below the task.

---

## ► PHASE 1 — FOUNDATION & MVP BROWSER

### Setup & Scaffolding

- [ ] **TASK-001** — Initialize the VS Code extension project structure
  - Run `yo code` or manually create package.json with correct VS Code extension fields
  - Set `"publisher"`, `"name"`, `"displayName"`, `"description"`, `"version"`, `"engines.vscode"`
  - Set `"activationEvents": ["onStartupFinished"]`
  - Add `"main": "./dist/extension.js"` 
  - Create empty `src/extension/index.ts` with `activate()` and `deactivate()`
  - Verify: `vsce package` runs without errors

- [ ] **TASK-002** — Create the full directory structure
  - Create all directories defined in ARCHITECTURE.md section 2
  - Create placeholder index files in each directory
  - Create `src/shared/messages.ts` with empty type definitions
  - Create `src/shared/types.ts` with empty type definitions
  - Verify: TypeScript compiles with zero errors

- [ ] **TASK-003** — Set up build system (esbuild for extension, Vite for webview)
  - `esbuild.config.js`: bundles `src/extension/index.ts` → `dist/extension.js`
  - `vite.config.ts`: bundles `src/webview/main.tsx` → `dist/webview/`
  - `package.json` scripts: `build`, `watch`, `package`, `test`
  - Verify: both build commands run to completion

- [ ] **TASK-004** — Create the Activity Bar icon SVG
  - File: `media/icons/activity-bar.svg`
  - Requirements from SPEC.md Module 6: 24×24 viewBox, monochrome, recognizable at small size
  - Concept: browser window outline with a lightning bolt / sparkle indicator
  - Must be valid SVG. Test by opening in browser.
  - Verify: VS Code shows the icon in the Activity Bar when extension is loaded

- [ ] **TASK-005** — Register Activity Bar sidebar in package.json
  - Add `contributes.viewsContainers.activitybar` entry
  - Add `contributes.views.devbrowser-pro` entry
  - Add placeholder `SidebarProvider.ts` that returns an empty TreeView
  - Verify: Activity Bar icon appears and clicking it opens an empty sidebar panel

- [ ] **TASK-006** — Add Status Bar item
  - Create a `vscode.StatusBarItem` on activation
  - Text: `$(browser) DevBrowser`
  - Position: Right side, priority 100
  - Command: `devbrowser.openPanel`
  - Verify: Status bar shows the item at VS Code bottom bar

### Chrome Process Management

- [ ] **TASK-007** — Implement `chromeLocator.ts`
  - Detect Chrome/Edge path on Windows, macOS, Linux
  - Return the first found path, in priority order (see RD.md section 8)
  - Export: `async function findChrome(): Promise<string | null>`
  - Write unit tests for each OS path pattern (mock filesystem)
  - Verify: returns a valid path on the development machine

- [ ] **TASK-008** — Implement `BrowserManager.ts` — Chrome spawn + connect
  - Spawn Chrome with flags from ARCHITECTURE.md section 10
  - Parse assigned CDP debugging port from Chrome's stderr
  - Connect puppeteer-core to `ws://127.0.0.1:{port}`
  - Expose: `getBrowser()`, `close()`
  - Handle: Chrome crash (restart attempts), connection timeout
  - Write unit tests (mock child_process, mock puppeteer)
  - Verify: headless Chrome spawns and can be connected to

- [ ] **TASK-009** — Implement `ProxyServer.ts` — local HTTP proxy
  - Start Express.js server on random available port
  - Log all passing traffic to a NetworkLog array
  - Expose: `start(): Promise<number>` (returns port), `stop()`, `getPort()`
  - Verify: HTTP requests routed through Chrome via proxy are captured

### Webview Panel

- [ ] **TASK-010** — Implement `BrowserPanel.ts` — WebviewPanel lifecycle
  - Create `vscode.WebviewPanel` with correct options (see SPEC.md 1.3)
  - Load webview HTML from build output
  - Set up message handler (`panel.webview.onDidReceiveMessage`)
  - Handle panel dispose (kill Chrome if no panels remain)
  - Expose: `create()`, `reveal()`, `dispose()`

- [ ] **TASK-011** — Create basic Webview React app (`src/webview/`)
  - Set up React 18 with Vite
  - Create `App.tsx` with placeholder layout:
    - Tab bar at top
    - URL bar below tab bar
    - Viewport area (gray placeholder)
    - DevTools area at bottom (gray placeholder)
  - Set up `src/webview/bridge/vscode.ts` typed wrapper
  - Verify: webview renders in VS Code panel without errors

- [ ] **TASK-012** — Implement `PanelMessageHandler.ts`
  - Route incoming Webview messages to the correct handler
  - Handle: `USER_NAVIGATE`, `NEW_TAB`, `CLOSE_TAB`, `USER_CLICK`, `USER_KEYDOWN`
  - Add to `src/shared/messages.ts` as messages are needed
  - Write unit tests for message routing

### Screencast & Navigation

- [ ] **TASK-013** — Implement `TabManager.ts` — multi-tab management
  - Create/close/switch tabs (see SPEC.md 2.2)
  - Store TabState for each tab
  - Manage CDP Page objects per tab
  - Expose: `createTab()`, `closeTab()`, `switchTab()`, `getActiveTab()`
  - Handle: new tab from `window.open()` / `target="_blank"`
  - Write unit tests (mock puppeteer Page)

- [ ] **TASK-014** — Implement `ScreencastManager.ts` — frame streaming
  - Enable CDP screencast on active tab
  - Relay frames to Webview via postMessage
  - Implement frame rate control (24fps active, 5fps idle)
  - Implement panel resize → restart screencast with new dimensions
  - IMPORTANT: Verify the exact puppeteer-core API for CDP screencast before coding
    (use `page.createCDPSession()` and direct CDP domain calls)
  - Write unit tests (mock CDP session)

- [ ] **TASK-015** — Implement Webview Viewport component (`src/webview/components/Viewport/`)
  - `<canvas>` element that fills the viewport area
  - Draw incoming JPEG frame data on canvas: decode base64 → ImageData → drawImage
  - Capture mouse events and keyboard events
  - Send events to Extension Host via `vscode.postMessage`
  - Handle canvas resize (report new size to Extension Host)

- [ ] **TASK-016** — Implement URL bar + navigation buttons (`src/webview/components/URLBar/`)
  - Input field with current URL
  - Back/Forward/Reload buttons
  - Loading spinner during navigation
  - Smart URL handling (see SPEC.md 2.1)
  - Sends `USER_NAVIGATE` on Enter or Go button click
  - Updates when Extension Host sends `PAGE_LOADED`

- [ ] **TASK-017** — Implement Tab Bar (`src/webview/components/TabBar/`)
  - Row of tab items, each with: favicon, title, close button
  - "New Tab" button at end
  - Active tab highlighted
  - Sends `NEW_TAB` and `CLOSE_TAB` and `SWITCH_TAB` messages
  - Updates from `TAB_CREATED`, `TAB_CLOSED`, `TAB_UPDATED` messages

- [ ] **TASK-018** — End-to-end navigation test
  - Open VS Code extension development host
  - Open DevBrowser Pro panel
  - Type `https://example.com` in URL bar
  - Verify: example.com renders in the viewport
  - This is the MVP smoke test. If this passes, Phase 1 is progressing.

- [ ] **TASK-019** — Handle "Chrome not found" gracefully
  - If `chromeLocator` returns null: show VS Code notification (see RD.md section 8)
  - Render "lite mode" placeholder in the webview with install instructions
  - Verify: extension does not crash when Chrome is missing

- [ ] **TASK-020** — Clean deactivation
  - `deactivate()` kills Chrome process, stops proxy server, stops MCP server
  - Verify: no orphan Chrome processes after VS Code closes
  - Test: kill Chrome mid-session → extension handles gracefully

- [ ] **TASK-021** — Package and local install test
  - Run `vsce package` → generates `.vsix` file
  - Install locally: `code --install-extension devbrowser-pro.vsix`
  - Verify all Phase 1 features work in installed (not dev) mode
  - Write README.md with installation instructions

---

## PHASE 2 — FULL DEVTOOLS INSPECTOR
*(Do not start until all Phase 1 tasks are ✓)*

- [ ] **TASK-022** — DevTools panel layout (resizable split)
- [ ] **TASK-023** — Elements panel: DOM tree viewer
- [ ] **TASK-024** — Elements panel: CSS styles viewer
- [ ] **TASK-025** — Elements panel: live CSS editing
- [ ] **TASK-026** — Console panel: log display
- [ ] **TASK-027** — Console panel: JS evaluation input
- [ ] **TASK-028** — Network panel: request list
- [ ] **TASK-029** — Network panel: request detail view
- [ ] **TASK-030** — Network panel: copy as cURL
- [ ] **TASK-031** — Performance panel: Core Web Vitals
- [ ] **TASK-032** — Storage panel: cookies viewer/editor
- [ ] **TASK-033** — Storage panel: localStorage viewer/editor
- [ ] **TASK-034** — Responsive preview: device switcher
- [ ] **TASK-035** — "Jump to Source": CSS rule → VS Code file

---

## PHASE 3 — AI INTEGRATION
*(Do not start until all Phase 2 tasks are ✓)*

- [ ] **TASK-036** — AI panel: sidebar with chat UI
- [ ] **TASK-037** — ContextBuilder: assembles browser state for AI
- [ ] **TASK-038** — AIClient: calls Claude/GPT API
- [ ] **TASK-039** — "Explain this error" on console error click
- [ ] **TASK-040** — "Fix this CSS" on element selection
- [ ] **TASK-041** — AI model selector in settings

---

## PHASE 4 — BACKEND DEVELOPER TOOLS
*(Do not start until all Phase 3 tasks are ✓)*

- [ ] **TASK-042** — API Tester panel UI
- [ ] **TASK-043** — RequestRunner: execute HTTP requests
- [ ] **TASK-044** — CollectionManager: save/load collections
- [ ] **TASK-045** — Environment variables system
- [ ] **TASK-046** — MockEngine: intercept + return mock responses
- [ ] **TASK-047** — "Send to API Tester" from Network panel

---

## PHASE 5 — LIVE PAGE EDITOR
*(Do not start until all Phase 4 tasks are ✓)*

- [ ] **TASK-048** — Edit mode toggle in toolbar
- [ ] **TASK-049** — Element selection with visual handles
- [ ] **TASK-050** — CSS visual editor panel
- [ ] **TASK-051** — Code-sync: write CSS changes to source files
- [ ] **TASK-052** — Tailwind class picker
- [ ] **TASK-053** — Undo/redo stack for visual edits

---

## PHASE 6 — SECURITY / PENTEST SUITE
*(Do not start until all Phase 5 tasks are ✓)*

- [ ] **TASK-054** — PassiveScanner: all 15 passive checks
- [ ] **TASK-055** — SecretDetector: all pattern types
- [ ] **TASK-056** — HeadersGrader: A-F scoring
- [ ] **TASK-057** — DepScanner: OSV.dev API integration
- [ ] **TASK-058** — InterceptEngine: hold/forward/drop
- [ ] **TASK-059** — Security panel UI
- [ ] **TASK-060** — AI Security Advisor: read source + generate fix
- [ ] **TASK-061** — Security report PDF export

---

## PHASE 7 — MCP AI BRIDGE
*(Do not start until all Phase 6 tasks are ✓)*

- [ ] **TASK-062** — MCP server scaffold (stdio transport)
- [ ] **TASK-063** — Core navigation tools (navigate, back, forward, reload)
- [ ] **TASK-064** — Inspection tools (get_dom, get_console_logs, get_network_log)
- [ ] **TASK-065** — Interaction tools (click, type, scroll, eval)
- [ ] **TASK-066** — Screenshot tool (returns base64 JPEG)
- [ ] **TASK-067** — Security tools via MCP
- [ ] **TASK-068** — MCPAutoConfig: auto-write configs for Cursor/Windsurf/Copilot

---

## PHASE 8 — CUSTOMIZATION PLATFORM
*(Do not start until all Phase 7 tasks are ✓)*

- [ ] **TASK-069** — ConfigManager: read/write .devbrowser/config.json
- [ ] **TASK-070** — User scripts: ScriptRunner + ScriptSandbox
- [ ] **TASK-071** — Plugin system: PluginHost + PluginSandbox
- [ ] **TASK-072** — Theme engine: CSS variable overrides
- [ ] **TASK-073** — Command palette inside DevBrowser Pro panel
- [ ] **TASK-074** — React DevTools official plugin

---

## BLOCKED TASKS

*(Move tasks here if they hit a blocker)*

No blocked tasks currently.

---

## COMPLETED TASKS

*(Move tasks here when done, with completion note)*

No completed tasks yet.
