# ARCHITECTURE.md
# DevBrowser Pro — System Architecture

> Ground truth for how every part of the system connects.
> If code contradicts this document — fix the code, not the document.
> If this document needs changing — update it here first, then change the code.

---

## 1. HIGH-LEVEL SYSTEM DIAGRAM

```
┌─────────────────────────────────────────────────────────────────────────┐
│  VS CODE / CURSOR / WINDSURF (Host Process)                             │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │  EXTENSION HOST (Node.js)                                       │   │
│  │                                                                 │   │
│  │  ┌────────────┐  ┌──────────────┐  ┌───────────────────────┐  │   │
│  │  │ Browser    │  │  Security    │  │  MCP Server           │  │   │
│  │  │ Manager    │  │  Engine      │  │  (stdio)              │  │   │
│  │  │ (CDP/Pptr) │  │  (scanner +  │  │                       │  │   │
│  │  │            │  │   proxy)     │  │  Tools exposed to:    │  │   │
│  │  └─────┬──────┘  └──────┬───────┘  │  - Cursor AI          │  │   │
│  │        │                │          │  - Copilot            │  │   │
│  │  ┌─────▼────────────────▼───────┐  │  - Claude Code        │  │   │
│  │  │  Message Bus                 │  │  - Windsurf Cascade   │  │   │
│  │  │  (postMessage protocol)      │  └───────────────────────┘  │   │
│  │  └─────────────┬────────────────┘                              │   │
│  │                │                                                │   │
│  └────────────────┼────────────────────────────────────────────── ┘   │
│                   │ postMessage (serialized JSON)                       │
│  ┌────────────────▼──────────────────────────────────────────────────┐ │
│  │  WEBVIEW PANEL (Sandboxed Browser Context)                        │ │
│  │                                                                   │ │
│  │  ┌─────────────┐  ┌──────────────┐  ┌──────────────────────────┐│ │
│  │  │ Tab Bar     │  │ URL Bar +    │  │  Toolbar                 ││ │
│  │  │ (multi-tab) │  │ Navigation   │  │  (screenshot, edit, AI)  ││ │
│  │  └─────────────┘  └──────────────┘  └──────────────────────────┘│ │
│  │                                                                   │ │
│  │  ┌───────────────────────────────────────────────────────────────┐│ │
│  │  │  BROWSER VIEWPORT (screencasted from headless Chrome)         ││ │
│  │  └───────────────────────────────────────────────────────────────┘│ │
│  │                                                                   │ │
│  │  ┌───────────────────────────────────────────────────────────────┐│ │
│  │  │  DEVTOOLS PANEL (resizable, draggable split)                  ││ │
│  │  │  [Elements][Console][Network][Performance][Security][AI][API] ││ │
│  │  └───────────────────────────────────────────────────────────────┘│ │
│  └───────────────────────────────────────────────────────────────────┘ │
│                                                                         │
│  ┌──────────────────────────────────────────────────────────────────┐  │
│  │  ACTIVITY BAR SIDEBAR                                            │  │
│  │  (DevBrowser Pro icon — always visible)                          │  │
│  │  - Quick access panel                                            │  │
│  │  - Bookmarks                                                     │  │
│  │  - History                                                       │  │
│  │  - Security findings summary                                     │  │
│  │  - Active scripts/plugins list                                   │  │
│  └──────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────┘
                    │
                    │ CDP (Chrome DevTools Protocol)
                    │ over WebSocket (ws://127.0.0.1:PORT)
                    ▼
┌──────────────────────────────────────────────────────────────────────────┐
│  HEADLESS CHROMIUM (child process, spawned by Extension Host)            │
│                                                                          │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐               │
│  │  Page 1  │  │  Page 2  │  │  Page 3  │  │  Page N  │  (one per tab) │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘               │
└──────────────────────────────────────────────────────────────────────────┘
                    ▲
                    │ HTTP/HTTPS traffic routed through
                    │
┌──────────────────────────────────────────────────────────────────────────┐
│  LOCAL PROXY SERVER (Express.js, port: dynamic, localhost only)          │
│  - Intercepts HTTP/HTTPS for the security scanner                        │
│  - Handles CORS bypass for dev servers                                   │
│  - Serves mock responses for mock rules                                  │
│  - Applies network intercept rules from user scripts                     │
└──────────────────────────────────────────────────────────────────────────┘
```

---

## 2. DIRECTORY STRUCTURE

```
devbrowser-pro/
├── package.json              ← Extension manifest (VS Code contribution points)
├── tsconfig.json             ← TypeScript config for extension host
├── tsconfig.webview.json     ← TypeScript config for webview (browser target)
├── esbuild.config.js         ← Build config for extension host bundle
├── vite.config.ts            ← Build config for webview bundle
├── .eslintrc.js
├── .devbrowser/              ← Workspace config (see SPEC.md section 9)
│
├── src/
│   ├── extension/            ← LAYER A: Node.js Extension Host
│   │   ├── index.ts          ← activate() / deactivate() entry point
│   │   ├── panel/
│   │   │   ├── BrowserPanel.ts        ← WebviewPanel lifecycle manager
│   │   │   └── PanelMessageHandler.ts ← Routes messages from Webview
│   │   ├── browser/
│   │   │   ├── BrowserManager.ts      ← Manages headless Chrome process
│   │   │   ├── TabManager.ts          ← Manages multiple CDP Page objects
│   │   │   ├── ScreencastManager.ts   ← Streams screenshots to Webview
│   │   │   └── CDPClient.ts           ← Raw CDP command wrapper
│   │   ├── proxy/
│   │   │   ├── ProxyServer.ts         ← Express.js proxy server
│   │   │   ├── InterceptEngine.ts     ← Request intercept + hold logic
│   │   │   └── MockEngine.ts          ← Mock response rules engine
│   │   ├── security/
│   │   │   ├── PassiveScanner.ts      ← Passive OWASP checks
│   │   │   ├── ActiveScanner.ts       ← Active attack simulation
│   │   │   ├── SecretDetector.ts      ← Scans JS bundles for secrets
│   │   │   ├── HeadersGrader.ts       ← Security headers analysis
│   │   │   ├── DepScanner.ts          ← CVE lookup for loaded deps
│   │   │   └── rules/                 ← Built-in + custom rule definitions
│   │   ├── mcp/
│   │   │   ├── MCPServer.ts           ← MCP server (stdio transport)
│   │   │   ├── tools/                 ← One file per MCP tool
│   │   │   └── MCPAutoConfig.ts       ← Auto-writes MCP config for Cursor/Windsurf
│   │   ├── scripts-engine/
│   │   │   ├── ScriptRunner.ts        ← Runs user scripts in worker threads
│   │   │   ├── ScriptSandbox.ts       ← Exposes devbrowser.* API to scripts
│   │   │   └── ScriptManager.ts       ← Loads/saves scripts from .devbrowser/
│   │   ├── plugins/
│   │   │   ├── PluginHost.ts          ← Plugin lifecycle manager
│   │   │   ├── PluginSandbox.ts       ← Sandboxed plugin execution
│   │   │   └── PluginManager.ts       ← Install/uninstall/list plugins
│   │   ├── api-tester/
│   │   │   ├── RequestRunner.ts       ← Executes API requests (Node fetch)
│   │   │   └── CollectionManager.ts   ← Saves/loads API collections
│   │   ├── config/
│   │   │   ├── ConfigManager.ts       ← Reads/writes .devbrowser/config.json
│   │   │   └── defaults.ts            ← Default config values
│   │   ├── ai/
│   │   │   ├── AIClient.ts            ← Calls AI API (Claude/GPT/Gemini)
│   │   │   └── ContextBuilder.ts      ← Assembles browser context for AI
│   │   ├── sidebar/
│   │   │   └── SidebarProvider.ts     ← Activity Bar sidebar tree view
│   │   └── utils/
│   │       ├── url.ts                 ← URL validation utilities
│   │       ├── logger.ts              ← Structured logging
│   │       └── chromeLocator.ts       ← Finds installed Chrome/Edge path
│   │
│   ├── webview/              ← LAYER B: React Browser Panel UI
│   │   ├── main.tsx           ← React entry point
│   │   ├── App.tsx            ← Root component
│   │   ├── store/             ← Zustand state management
│   │   │   ├── tabStore.ts
│   │   │   ├── devtoolsStore.ts
│   │   │   └── securityStore.ts
│   │   ├── components/
│   │   │   ├── TabBar/
│   │   │   ├── URLBar/
│   │   │   ├── Toolbar/
│   │   │   ├── Viewport/        ← Renders the screencasted page
│   │   │   └── DevTools/        ← All DevTools panel tabs
│   │   │       ├── ElementsPanel/
│   │   │       ├── ConsolePanel/
│   │   │       ├── NetworkPanel/
│   │   │       ├── PerformancePanel/
│   │   │       ├── SecurityPanel/
│   │   │       ├── AIPanel/
│   │   │       ├── APITesterPanel/
│   │   │       └── EditPanel/
│   │   └── bridge/
│   │       └── vscode.ts        ← Typed wrapper around acquireVsCodeApi()
│   │
│   ├── shared/               ← Types shared between Extension and Webview
│   │   ├── messages.ts        ← All postMessage type definitions
│   │   ├── types.ts           ← Shared domain types (Tab, Request, Finding...)
│   │   └── constants.ts       ← Shared constants
│   │
│   └── mcp/                  ← MCP server (also runnable as standalone)
│       ├── server.ts
│       └── tools/
│
├── test/
│   ├── extension/            ← Mocha tests for extension host
│   ├── webview/              ← Vitest tests for React components
│   └── e2e/                  ← Playwright tests (real VS Code instance)
│
└── media/
    ├── icons/
    │   ├── activity-bar.svg  ← 24×24 monochrome — Activity Bar icon
    │   ├── icon-128.png      ← Marketplace listing icon
    │   └── icon-512.png      ← High-res version
    └── webview/              ← Static assets for webview (fonts, etc.)
```

---

## 3. THE SCREENCAST LOOP (How the Browser Renders Inside VS Code)

This is the most critical technical mechanism. Understanding it prevents
the most common architecture mistakes.

```
1. Extension spawns headless Chrome with --remote-debugging-port=0
2. Extension connects to Chrome via puppeteer-core (CDP WebSocket)
3. Extension enables Page.screencastFrame CDP event on each Page
4. Chrome sends compressed JPEG frames to Extension Host (~10-30 fps)
5. Extension Host forwards each frame to Webview via postMessage
   (frame data is base64-encoded JPEG string)
6. Webview renders frame in a <canvas> element (not an <img> or <iframe>)
7. User mouse events on the canvas are captured and sent back to Extension Host
8. Extension Host translates canvas coordinates → CDP Input.dispatchMouseEvent
9. Chrome processes the click → triggers re-render → new frame sent → loop

KEY NUMBERS:
- Target frame rate: 24fps when user is active, 5fps when idle
- Frame size: scaled to panel size, 80% JPEG quality
- Max frame latency target: <100ms from Chrome render to canvas display
- Input latency target: <150ms from user click to visual feedback
```

---

## 4. MCP SERVER ARCHITECTURE

```
VS Code Extension (Extension Host)
    │
    ├── spawns
    ▼
MCP Server Process (Node.js, stdio transport)
    │
    ├── Registers tools: browser_navigate, browser_click, etc.
    │
    └── When AI calls a tool:
            │
            ├── Validates parameters
            ├── Sends command to Extension Host via IPC (unix socket or named pipe)
            │   (Extension Host is the one that actually talks to Chrome via CDP)
            ├── Extension Host executes the CDP command
            ├── Returns result back to MCP Server via IPC
            └── MCP Server returns result to AI caller

WHY NOT DIRECTLY FROM MCP SERVER TO CDP:
  The MCP server is a separate process. The CDP connection (puppeteer-core)
  is held by the Extension Host. Routing through the Extension Host ensures
  there is always exactly ONE controller of the browser state.
  Two simultaneous controllers would cause race conditions.
```

---

## 5. SECURITY SCANNER DATA FLOW

```
Network request made by browser
    │
    ├── Passes through Local Proxy Server
    │   ├── Request logged to NetworkLog
    │   └── Passive scanner analyzes request headers/body in real time
    │
    ▼
Target server responds
    │
    ├── Response passes through Local Proxy Server
    │   ├── Response logged to NetworkLog
    │   ├── Passive scanner analyzes response headers/body
    │   │   ├── CheckHeaders (CSP, HSTS, X-Frame-Options...)
    │   │   ├── CheckCookies (Secure, HttpOnly, SameSite flags)
    │   │   ├── CheckDataExposure (secrets, PII in responses)
    │   │   └── CheckDependencies (library version CVE lookup)
    │   └── Findings emitted to SecurityFindingStore
    │
    ▼
Extension Host
    │
    └── Sends findings to Webview via postMessage({type: 'SECURITY_FINDING', ...})
        └── SecurityPanel renders findings with severity badges
```

---

## 6. PLUGIN EXECUTION MODEL

```
Plugin Package (npm package in .devbrowser/plugins/ or marketplace)
    │
    ├── PART A: Plugin Logic (index.js)
    │   Runs in: Node.js vm.Script context (sandboxed)
    │   Has access to: PluginAPI object only (no require, no fs, no net)
    │   PluginAPI exposes:
    │     - browser.*   (read page data, navigate, etc.)
    │     - panel.*     (update plugin's own panel)
    │     - storage.*   (plugin-local key-value store)
    │     - on(event, handler) (subscribe to browser events)
    │
    └── PART B: Plugin UI (panel.html + bundled JS)
        Runs in: sandboxed <iframe> inside Webview
        Has access to: DOM only, plus pluginAPI via postMessage
        Cannot: access parent frame, VS Code API, or filesystem
```

---

## 7. USER SCRIPTS EXECUTION MODEL

```
User Script (.js file in .devbrowser/scripts/)
    │
    └── Runs in: Node.js worker_threads Worker
        Has access to: devbrowser.* API (via message passing to Extension Host)
        Cannot: require arbitrary modules, access filesystem directly,
                make outbound network requests directly
        Lifecycle:
          - Worker spawned when VS Code opens workspace
          - Script event listeners registered
          - Events dispatched from Extension Host → Worker → handler runs
          - Worker terminated when VS Code closes workspace
```

---

## 8. ACTIVITY BAR SIDEBAR

The Activity Bar icon is the extension's primary entry point.
It opens a TreeView sidebar (not the main browser panel).

```
Activity Bar Icon (always visible)
    │
    └── Opens: DevBrowser Pro Sidebar (TreeView)
        ├── 🌐 Open Browser Panel (button)
        ├── 📌 Pinned Tabs
        │   ├── localhost:3000
        │   └── localhost:3001/api
        ├── ⭐ Bookmarks
        ├── 🕐 History (last 20 entries)
        ├── 🔐 Security (count badge: 3 findings)
        │   ├── ⚠ Missing CSP header
        │   ├── ⚠ JWT expiry not set
        │   └── 🔴 AWS key in bundle (critical)
        ├── 🔌 Active Plugins (3 enabled)
        └── 📜 Active Scripts (2 running)
```

**The count badge on the Security section updates live as the passive
scanner finds new issues. This ensures security findings are ALWAYS
visible without the developer needing to open the DevTools panel.**

---

## 9. STATE MANAGEMENT (Extension Host)

All mutable state in the Extension Host is managed through a single
`ExtensionState` class. This prevents scattered global state.

```typescript
// src/extension/state/ExtensionState.ts
class ExtensionState {
  tabs: Map<string, TabState>       // tabId → TabState
  networkLog: NetworkRequest[]       // per-tab, capped at 1000
  securityFindings: Finding[]        // all findings, this session
  mockRules: MockRule[]              // active mock rules
  userScripts: UserScript[]          // loaded scripts
  activePlugins: Plugin[]            // running plugins
  config: WorkspaceConfig            // from .devbrowser/config.json
  proxyPort: number                  // assigned at startup
  cdpEndpoint: string                // assigned when Chrome starts
}
```

---

## 10. CHROME PROCESS LIFECYCLE

```
Extension activates
    │
    ├── chromeLocator.ts finds Chrome/Edge binary path
    │   Priority: Chrome Stable > Chrome Beta > Edge Stable > Edge Beta
    │   If not found: show error with install link, exit gracefully
    │
    ├── Spawn Chrome with flags:
    │   --headless=new
    │   --remote-debugging-port=0   (OS assigns port)
    │   --no-sandbox (required in some environments)
    │   --proxy-server=127.0.0.1:{proxyPort}  (routes through our proxy)
    │   --ignore-certificate-errors-spki-list (for self-signed dev certs)
    │
    ├── Read assigned debugging port from Chrome's stderr output
    ├── Connect puppeteer-core to ws://127.0.0.1:{debuggingPort}
    └── Chrome is ready — create first Page object (Tab 1)

Extension deactivates
    └── Kill Chrome process (SIGTERM → wait 2s → SIGKILL if still running)
```

---

## 11. WHAT THIS ARCHITECTURE DOES NOT DO

Being explicit about non-goals prevents over-engineering:

- **Does NOT bundle Chromium.** Uses the user's installed Chrome.
- **Does NOT implement a full HTTP proxy for all system traffic.** Only the
  headless Chrome instance routes through the proxy.
- **Does NOT store browser data between sessions by default.** Cookies,
  localStorage, and sessions are ephemeral unless user opts into persistence.
- **Does NOT support Chrome Extensions inside the embedded browser.** Chrome
  Extensions require a different Chrome profile setup that is out of scope.
- **Does NOT replace VS Code's built-in terminal or editor.** It complements them.
