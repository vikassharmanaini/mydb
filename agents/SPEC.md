# SPEC.md
# DevBrowser Pro — Feature Specification

> Exact requirements for every feature. Written to be unambiguous.
> If a requirement is ambiguous — it is a bug in this document. Fix it here.

---

## SPEC FORMAT

Each feature has:
- **What:** What the user sees/does
- **How:** How it works technically (enough for an agent to implement it)
- **Edge cases:** Specific situations that must be handled
- **Out of scope:** What this feature does NOT do

---

## MODULE 1: EXTENSION FOUNDATION

### 1.1 Extension Activation

**What:** Extension activates when VS Code opens. Activity Bar icon appears immediately.

**How:**
- `activate()` in `src/extension/index.ts` is called by VS Code
- On activate:
  1. Read `.devbrowser/config.json` if it exists (workspace config)
  2. Fall back to VS Code settings (`devbrowserPro.*`) if no workspace config
  3. Find Chrome/Edge binary via `chromeLocator.ts`
  4. If Chrome found: spawn headless Chrome process
  5. If Chrome not found: set extension to "lite mode", show notification
  6. Start local proxy server on random available port
  7. Start MCP server as child process
  8. Register TreeView for Activity Bar sidebar
  9. Register all VS Code commands

**Edge cases:**
- VS Code opens multiple workspaces: extension activates once per window
- Chrome crashes during operation: detect via process exit, attempt restart, notify user
- Proxy port is taken: try up to 10 random ports before failing

**Out of scope:** Bundling Chrome with the extension.

---

### 1.2 Activity Bar Icon & Sidebar

**What:** Icon always visible in Activity Bar. Clicking opens a sidebar panel.

**How:**
```json
// package.json
"contributes": {
  "viewsContainers": {
    "activitybar": [{
      "id": "devbrowser-pro",
      "title": "DevBrowser Pro",
      "icon": "media/icons/activity-bar.svg"
    }]
  },
  "views": {
    "devbrowser-pro": [{
      "id": "devbrowser.sidebar",
      "name": "DevBrowser Pro",
      "type": "tree"
    }]
  }
}
```

Sidebar tree structure (implemented as `vscode.TreeDataProvider`):
```
DevBrowser Pro
├── [Button] Open Browser Panel
├── Open Tabs (section)
│   └── [each open tab: favicon + title + close button]
├── Pinned Tabs (section)
│   └── [each pinned tab]
├── Bookmarks (section, collapsible)
├── History (section, collapsible, last 20)
└── Security (section, with badge count)
    └── [each finding: severity icon + short description]
```

Badge on Activity Bar icon = count of Critical + High security findings.
Badge updates live as passive scanner runs.

**Edge cases:**
- No tabs open: "Open Tabs" section shows "No open tabs" placeholder
- 0 security findings: Security section shows "No issues found ✓" in green
- Badge count > 99: show "99+"

---

### 1.3 Browser Panel (WebviewPanel)

**What:** Main browser window opens as an editor tab (or side panel).

**How:**
- Command `devbrowser.openPanel` creates a `vscode.WebviewPanel`
- Column: `vscode.ViewColumn.Beside` by default (opens next to current editor)
- Panel title: "DevBrowser Pro" (updates to current page title when page loads)
- `retainContextWhenHidden: true` — panel state preserved when not visible
- Panel HTML loads from `src/webview/` build output
- Panel CSP allows: scripts from extension, images from any origin (for screenshots)

---

## MODULE 2: BROWSER CORE

### 2.1 URL Navigation

**What:** User types a URL in the address bar and the browser navigates to it.

**How:**
1. User types in URL bar input field (in Webview)
2. On Enter or "Go" click: Webview sends `{ type: 'USER_NAVIGATE', payload: { tabId, url } }`
3. Extension Host validates URL:
   - If has protocol (http:// or https://): use as-is
   - If looks like domain (contains `.`): prepend `https://`
   - If no dots: treat as search query, use configured search engine URL
4. Extension Host calls `page.goto(url, { waitUntil: 'domcontentloaded', timeout: 30000 })`
5. On navigation start: send `{ type: 'NAVIGATION_STARTED', payload: { tabId, url } }`
6. On DOM ready: send `{ type: 'PAGE_LOADED', payload: { tabId, url, title, favicon } }`

**Edge cases:**
- `net::ERR_CONNECTION_REFUSED`: page is down or port not running → show friendly error page
- `net::ERR_NAME_NOT_RESOLVED`: DNS failure → show error page with suggestion
- `TimeoutError` after 30s: show timeout error page
- `ERR_CERT_AUTHORITY_INVALID`: self-signed cert (common for local dev) → show "Proceed anyway" option
- Empty URL: do nothing, keep current page

---

### 2.2 Tab Management

**What:** Multiple tabs with a tab bar, creating, closing, switching.

**How:**
- Max tabs: configurable, default 10
- Each tab: `{ id, pageId, url, title, favicon, isLoading, isPinned, isPrivate }`
- New tab: `browser.newPage()` → creates new CDP Page → assign UUID as tabId
- Close tab: `page.close()` → if this was the active tab, activate the adjacent tab
- Switch tab: stop sending screencast from old page, start from new page
- Pin tab: set `isPinned: true`, persists to `.devbrowser/session.json`
- Tab ordering: array order = visual order; drag-and-drop reorders the array

**Edge cases:**
- Closing the last tab: open a new blank tab (don't close the panel)
- Tab crashes (TargetCloseError): show "Oops" tab, offer reload
- Opening a link in a new tab (`target="_blank"`): intercept CDP `Page.windowOpen` event, create new tab

---

### 2.3 Screencast Rendering

**What:** The browser viewport shows the real rendered page as a live video feed.

**How:**
- On tab activate: call `page.screencast.start({ format: 'jpeg', quality: 80 })`
  (Note: this is the CDP `Page.startScreencast` domain method via puppeteer's CDP session)
- Each frame: `page.on('screenshotFrame', (frame) => {...})` — VERIFY the exact
  puppeteer-core API for screencast events before implementing
- Frame → Extension Host → postMessage to Webview → Webview draws on `<canvas>`
- Frame rate: 24fps when tab is active and user is interacting, 5fps when idle
- On tab switch: stop screencast on old tab, start on new tab
- On panel resize: restart screencast with new width/height

**Edge cases:**
- Panel is hidden (user switches editor): reduce to 1fps to save CPU
- Page is a blank new tab: render a "new tab" placeholder HTML page locally

---

### 2.4 User Input Forwarding

**What:** Mouse clicks and keyboard input in the browser viewport control the page.

**How:**
- Canvas captures `mousedown`, `mousemove`, `mouseup`, `wheel` events
- Convert canvas coordinates to page coordinates (account for viewport scale)
- Send to Extension Host: `{ type: 'USER_CLICK', payload: { x, y, button, modifiers } }`
- Extension Host calls CDP `Input.dispatchMouseEvent`
- Keyboard events on the canvas: capture `keydown`, `keyup`, `keypress`
- Send to Extension Host: `{ type: 'USER_KEYDOWN', payload: { key, code, modifiers } }`
- Extension Host calls CDP `Input.dispatchKeyEvent`

**Edge cases:**
- Right-click: send to CDP AND show our custom context menu (not browser's native one)
- Text input fields: user types in canvas focus → forwarded to CDP → Chrome handles caret
- Scroll: `wheel` event → CDP `Input.dispatchMouseEvent` with type `mouseWheel`

---

## MODULE 3: DEVTOOLS PANELS

### 3.1 Elements Panel

**What:** DOM tree viewer with live CSS editing.

**How:**
- On panel open: call `DOM.getDocument({ depth: -1 })` — gets full DOM tree
- Render as collapsible tree in React (virtualized list for performance)
- On hover over DOM node: send `DOM.highlightNode` → browser shows blue overlay
- On click of node: send `CSS.getMatchedStylesForNode` → shows applied styles panel
- Inline editing: double-click attribute value → input field → on change: `DOM.setAttributeValue`
- CSS editing: click property value → inline editor → on change: `CSS.setStyleTexts`

### 3.2 Console Panel

**What:** Browser console output + JS evaluation.

**How:**
- Subscribe to `Runtime.consoleAPICalled` and `Runtime.exceptionThrown` CDP events
- Each message stored in console log (in-memory, last 1000 entries)
- Display with level icons: 🔵 log, 🟡 warn, 🔴 error, ⚪ info
- Eval input at bottom: on Enter → `Runtime.evaluate({ expression, awaitPromise: true })`
- Result rendered inline below the input

### 3.3 Network Panel

**What:** All HTTP requests with full request/response detail.

**How:**
- Subscribe to `Network.requestWillBeSent`, `Network.responseReceived`,
  `Network.loadingFinished`, `Network.loadingFailed` CDP events
- Each request object: `{ id, url, method, status, type, size, timing, requestHeaders, responseHeaders, requestBody, responseBody }`
- Response body: `Network.getResponseBody(requestId)` — called on demand (not eagerly)
- "Copy as cURL": generate cURL command string from request object
- "Replay request": send identical request via Node.js `fetch()` in extension host
- HAR export: serialize all requests to HAR 1.2 format, write to file

### 3.4 Performance Panel

**What:** Core Web Vitals on each page load.

**How:**
- Subscribe to `Performance.metrics` CDP domain
- On page load complete: call `Performance.getMetrics()`
- Parse: FCP, LCP, CLS, INP, TTFB from metrics array
- Display as colored indicators: Green (good) / Orange (needs improvement) / Red (poor)
- Thresholds per Google's Core Web Vitals spec:
  - LCP: <2.5s good, <4s needs improvement, >4s poor
  - INP: <200ms good, <500ms needs improvement, >500ms poor
  - CLS: <0.1 good, <0.25 needs improvement, >0.25 poor

### 3.5 Storage Panel

**What:** View and edit cookies, localStorage, sessionStorage.

**How:**
- Cookies: `Network.getAllCookies()` → show table with name/value/domain/path/secure/httpOnly/sameSite
- localStorage: `Runtime.evaluate({ expression: 'JSON.stringify(Object.entries(localStorage))' })`
- Edit cell → write back via `Runtime.evaluate` or `Network.setCookies`
- Delete: `Network.deleteCookies`

---

## MODULE 4: SECURITY SCANNER

### 4.1 Passive Scanner

**What:** Always-on scanner that analyzes traffic as the user browses.
No attack payloads. Safe to run on any site.

**Checks performed on EVERY page load:**

| Check ID | Name | How detected |
|----------|------|-------------|
| SEC-H01 | Missing Content-Security-Policy | Response header absent |
| SEC-H02 | Missing Strict-Transport-Security | Response header absent (HTTPS only) |
| SEC-H03 | Missing X-Frame-Options | Response header absent |
| SEC-H04 | Missing X-Content-Type-Options | Header value != "nosniff" |
| SEC-H05 | Missing Referrer-Policy | Response header absent |
| SEC-H06 | Permissive CORS | Access-Control-Allow-Origin: * on non-public API |
| SEC-C01 | Cookie missing Secure flag | Cookie without Secure on HTTPS |
| SEC-C02 | Cookie missing HttpOnly flag | Cookie without HttpOnly |
| SEC-C03 | Cookie missing SameSite | Cookie without SameSite attribute |
| SEC-D01 | Sensitive data in URL | Regex: password=, token=, secret= in URL |
| SEC-D02 | Stack trace in response | Regex: "at " + file paths in response body |
| SEC-S01 | Secrets in JS bundle | See SecretDetector patterns |
| SEC-V01 | Vulnerable dependency | Cross-ref loaded lib versions vs OSV.dev |
| SEC-T01 | Expired/invalid cert | TLS certificate check via CDP |
| SEC-T02 | Mixed content | HTTP resource on HTTPS page |

**Severity ratings:**
- Critical: SEC-S01 (exposed secret), SEC-T01 (invalid cert)
- High: SEC-H01 (missing CSP), SEC-V01 (known CVE in dep)
- Medium: SEC-C01, SEC-C02, SEC-C03, SEC-H02, SEC-H03
- Low: SEC-D01, SEC-D02, SEC-H04, SEC-H05, SEC-H06
- Info: SEC-T02

### 4.2 Secret Detector

**What:** Scans loaded JS bundle content for exposed credentials.

**Patterns (all case-insensitive, all tested with unit tests):**
```
AWS_ACCESS_KEY: /AKIA[0-9A-Z]{16}/
AWS_SECRET: /[0-9a-zA-Z/+]{40}/  (must appear near "aws_secret" keyword)
GOOGLE_API_KEY: /AIza[0-9A-Za-z-_]{35}/
GITHUB_TOKEN: /gh[pousr]_[0-9a-zA-Z]{36}/
STRIPE_LIVE_KEY: /sk_live_[0-9a-zA-Z]{24}/
OPENAI_KEY: /sk-[a-zA-Z0-9]{48}/
PRIVATE_KEY: /-----BEGIN (RSA |EC )?PRIVATE KEY-----/
JWT_SECRET: appears near keywords "jwt", "secret", "signing" — high false positive rate, confidence=low
DB_CONNECTION: /(postgres|mysql|mongodb(\+srv)?):\/\/.+:.+@/
```

**Implementation note:** Run patterns against `Network.getResponseBody()` of
all `type: "Script"` responses. Scan in worker thread to avoid blocking.

### 4.3 Security Headers Grader

**What:** Letter grade A+ through F for security headers.

**Scoring:**
```
Start: A+
Missing CSP:          → F immediately (CSP is foundational)
Missing HSTS:         → drop one grade
Missing X-Frame-Opts: → drop one grade
Missing X-Content-Type: → drop half grade
Missing Referrer-Policy: → drop half grade
Permissive CORS:      → drop one grade
Bad SameSite cookies: → drop half grade
```

Display: Colored grade badge in Security panel header.
Clicking the badge opens the headers detail view.

---

## MODULE 5: MCP SERVER

### 5.1 Tool Definitions

All tools must follow this schema pattern:
```typescript
server.tool(
  'browser_navigate',
  'Navigate the embedded browser to a URL',
  {
    url: z.string().describe('The URL to navigate to. Must be http:// or https://')
  },
  async ({ url }) => {
    // validate, execute, return result
    return { content: [{ type: 'text', text: `Navigated to ${url}` }] };
  }
);
```

**Required tools for Phase 7 (minimum viable MCP):**
- `browser_navigate(url)` → Navigate
- `browser_screenshot()` → Returns base64 JPEG image
- `browser_get_dom(selector?)` → Returns HTML string
- `browser_get_url()` → Returns current URL string
- `browser_click(selector)` → Click element
- `browser_type(selector, text)` → Type into input
- `browser_get_console_logs()` → Returns array of console messages
- `browser_get_network_log()` → Returns array of network requests
- `browser_eval(javascript)` → Execute JS, return result
- `security_passive_scan()` → Return current security findings array

---

## MODULE 6: ACTIVITY BAR — MAXIMUM VISIBILITY

### Icon Placement Strategy

The icon must be visible to the developer at ALL times without any action.

**Implementation layers (all must be present):**

1. **Activity Bar icon** (primary)
   - Always in the left sidebar strip
   - Badge shows security finding count
   - Keyboard shortcut: `Ctrl+Shift+B` (or `Cmd+Shift+B` on Mac) to open sidebar

2. **Status Bar item** (secondary)
   - Bottom status bar: `$(browser) DevBrowser Pro` icon + text
   - Click → opens browser panel
   - Shows: current tab URL (truncated) when panel is open
   - Shows: security badge count if findings > 0

3. **Editor title toolbar** (tertiary)
   - When editing HTML/CSS/JS/TSX files: show a small "Preview in DevBrowser" icon
     in the editor title bar (using `contributes.menus.editor/title`)
   - Clicking it opens the browser panel to localhost (configured dev server)

4. **Right-click context menu** (discovery)
   - In the editor: right-click → "Open in DevBrowser Pro"
   - In the Explorer panel: right-click on .html file → "Preview in DevBrowser Pro"

5. **Welcome walkthrough** (onboarding)
   - On first install: VS Code walkthrough (`contributes.walkthroughs`)
   - Shows where the icon is and what the extension does

```json
// package.json — all placement registrations
"contributes": {
  "viewsContainers": {
    "activitybar": [{ "id": "devbrowser-pro", "title": "DevBrowser Pro", "icon": "media/icons/activity-bar.svg" }]
  },
  "menus": {
    "editor/title": [{ "command": "devbrowser.openPanel", "group": "navigation" }],
    "explorer/context": [{ "command": "devbrowser.openFile", "when": "resourceExtname == .html" }]
  },
  "keybindings": [
    { "command": "devbrowser.openPanel", "key": "ctrl+shift+b", "mac": "cmd+shift+b" }
  ],
  "walkthroughs": [{
    "id": "devbrowser.gettingStarted",
    "title": "Getting Started with DevBrowser Pro",
    "steps": [ ... ]
  }]
}
```

---

## MODULE 7: CONFIG-AS-CODE

### .devbrowser/config.json Schema

```typescript
interface WorkspaceConfig {
  // Browser
  homepage?: string;                    // default: "about:blank"
  defaultViewport?: { width: number; height: number };
  autoReloadOnSave?: boolean;           // default: true
  autoReloadDebounce?: number;          // ms, default: 300

  // DevTools
  panels?: {
    visible?: string[];                  // which panel tabs to show
    defaultSize?: number;               // % of panel height, default: 40
  };

  // Security
  security?: {
    passiveScanEnabled?: boolean;       // default: true
    notifyOnSeverity?: 'critical' | 'high' | 'medium' | 'all';
    authorizedTargets?: string[];       // domains allowed for active scanning
  };

  // AI
  ai?: {
    model?: string;                     // default: "claude-sonnet"
    contextIncludes?: string[];         // what context to auto-include
  };

  // MCP
  mcp?: {
    enabled?: boolean;                  // default: true
    permissionLevel?: 'read' | 'read-write' | 'full';
  };

  // Plugins
  plugins?: {
    enabled?: string[];                 // plugin IDs to auto-enable
  };
}
```
