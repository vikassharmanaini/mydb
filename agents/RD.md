# RD.md
# DevBrowser Pro — Technical R&D Decisions

> Every technical decision we considered, what we chose, and why.
> Before changing a technical approach — read the relevant section here first.

---

## 1. HOW DO WE RENDER A REAL BROWSER INSIDE VS CODE?

**The problem:** VS Code's Webview is a sandboxed HTML panel. It cannot
directly render arbitrary external URLs in an iframe because:
- Sites send `X-Frame-Options: DENY` or `SAMEORIGIN`
- Content Security Policy blocks cross-origin iframes
- VS Code's Webview itself has CSP that blocks most embeds

**Options considered:**

| Option | Mechanism | Pros | Cons | Decision |
|--------|-----------|------|------|----------|
| A: Simple iframe | `<iframe src="url">` | Trivial to implement | Blocked by X-Frame-Options on most sites | ❌ Rejected |
| B: iframe + local proxy | Proxy strips X-Frame-Options headers | Works for many sites | Still fails on CSP; can't access DevTools CDP | ⚠️ Use as fallback only |
| C: Headless Chrome + screencast | Spawn Chrome, CDP, stream JPEG frames | Works for ANY site, full CDP access | RAM overhead; Chrome must be installed | ✅ CHOSEN |
| D: Electron webview | Electron's `<webview>` tag | Deep access | VS Code is Electron but doesn't expose webview tag to extensions | ❌ Not available to extensions |

**Chosen: Option C** — Headless Chrome via puppeteer-core + CDP screencast.
This is how the original `vscode-browser-preview` by @auchenberg worked (2018-2021).
It is a proven, validated approach. We build on it.

**Screencast implementation:**
- CDP `Page.startScreencast` with format=jpeg, quality=80, maxWidth=panel width
- Each frame arrives as base64 JPEG via `Page.screencastFrame` event
- Extension host relays frame to Webview via postMessage
- Webview renders to `<canvas>` using `drawImage()`
- User input on canvas → `Input.dispatchMouseEvent` / `Input.dispatchKeyEvent` via CDP

---

## 2. HOW DO WE HANDLE MULTI-TAB?

**The problem:** Each browser tab needs to be independent — separate URL,
history, cookies (optionally), console, network log.

**Solution:** Each "tab" in our UI maps 1:1 to a CDP `Page` object (not a
full Browser context). All tabs share the same Chrome process and the same
Browser context by default (so they share cookies, just like Chrome does).

**Incognito tabs:** Create a new `BrowserContext` via
`browser.createIncognitoBrowserContext()`. Pages inside have isolated cookies.

**Tab state:** Managed in `TabManager.ts`. Each tab has:
```typescript
interface TabState {
  id: string;              // our internal UUID
  pageId: string;          // CDP Page target ID
  url: string;
  title: string;
  favicon: string | null;
  isLoading: boolean;
  canGoBack: boolean;
  canGoForward: boolean;
  isSuspended: boolean;    // true if screencast paused to save RAM
}
```

**Tab suspension:** When a tab hasn't been active for >5 minutes:
- Stop its screencast (`Page.stopScreencast`)
- Freeze: call `Page.disable` — not `page.close()` (page still exists in Chrome)
- Resume on tab switch: `Page.enable` + `Page.startScreencast` again
- This saves ~30-50MB RAM per suspended tab

---

## 3. HOW DO WE BUILD THE DEVTOOLS INSPECTOR?

**The problem:** Chrome DevTools is itself a massive web application. We're
not replicating it entirely. We're building the 20% that covers 80% of daily use.

**What we DON'T do:** We do NOT embed Chrome DevTools Frontend HTML directly.
That would be licensing-problematic and hard to theme with VS Code's design language.

**What we DO:** Build custom React panels that use CDP data directly.

**CDP APIs used per panel:**

| Panel | Key CDP Domains |
|-------|----------------|
| Elements | DOM.getDocument, DOM.getOuterHTML, CSS.getMatchedStylesForNode, DOM.setAttributeValue |
| Console | Runtime.consoleAPICalled, Runtime.evaluate |
| Network | Network.requestWillBeSent, Network.responseReceived, Network.loadingFinished, Network.getResponseBody |
| Performance | Performance.getMetrics, Page.loadEventFired timing, Runtime heap |
| Storage | Storage.getCookies, DOMStorage.enable, DOMStorage.domStorageItemAdded |

**The "Jump to Source" feature:**
When user clicks a CSS rule's source location (e.g., `styles.module.css:42`):
1. CSS panel shows the source URL (which may be a sourcemap-resolved path)
2. We resolve the URL to a workspace file path using VS Code's workspace API
3. We call `vscode.window.showTextDocument(uri, { selection: new vscode.Range(line, 0, line, 0) })`
This opens the file in the editor and scrolls to the exact line.

---

## 4. HOW DOES THE MCP SERVER WORK?

**The problem:** MCP servers communicate via stdio. VS Code extensions run
in a process managed by VS Code — not as a stdio server.

**Solution:** The MCP server runs as a SEPARATE child process spawned by
the extension. The extension and MCP server communicate via an IPC channel.

```
VS Code Extension Host
    │
    ├── spawns → MCP Server Process (node mcp/server.js)
    │            │ (stdio transport for AI callers)
    │            │
    ├── ← IPC → MCP Server
    │    (unix socket or named pipe)
    │
    └── holds CDP connection to Chrome
```

When an AI (Cursor) calls `browser_navigate`:
1. Cursor → MCP Server via stdio (JSON-RPC)
2. MCP Server → Extension Host via IPC (serialized command)
3. Extension Host → Chrome via CDP (`page.goto(url)`)
4. Chrome navigates → new screencast frame sent to Webview
5. Extension Host → MCP Server via IPC (success/error result)
6. MCP Server → Cursor via stdio (JSON-RPC result)

**MCP auto-configuration:**
On `activate()`, the extension:
1. Detects if `.cursor/` directory exists → writes `.cursor/mcp.json`
2. Detects if `codeium` config directory exists → writes Windsurf MCP config
3. Writes/updates VS Code `settings.json` `mcp.servers` entry
All writes are idempotent (check before write, don't overwrite user changes).

---

## 5. HOW DOES THE SECURITY SCANNER WORK WITHOUT A SEPARATE PROXY APP?

**The problem:** Tools like Burp Suite are standalone applications. We're
building this into a VS Code extension. How do we intercept HTTPS traffic?

**Solution:** The Local Proxy approach:
1. On extension activate: spawn an Express.js HTTP proxy server on a random localhost port.
2. Launch headless Chrome with `--proxy-server=127.0.0.1:{proxyPort}`.
3. ALL Chrome traffic flows through our proxy first.
4. Proxy logs each request/response → feeds passive scanner.
5. When intercept mode is ON: proxy holds the request until user forwards/drops.

**HTTPS interception:** HTTPS normally prevents proxy inspection. To inspect:
- Chrome must trust our proxy's self-signed certificate.
- We generate a self-signed root CA on first install (stored in extension globalState).
- We launch Chrome with `--ignore-certificate-errors-spki-list={ourCACertHash}`.
- Our proxy uses `node-http-proxy` with `https-proxy-agent` and our CA to
  decrypt/re-encrypt HTTPS traffic for inspection.
- This is exactly what Burp Suite and Charles Proxy do.
- **Scope:** Only applies to our headless Chrome instance, not the user's system.

---

## 6. HOW DO USER SCRIPTS RUN SAFELY?

**The problem:** User scripts are arbitrary JavaScript. Running them in the
extension host directly would let them do anything (read files, make requests, etc.)

**Solution:** Node.js `worker_threads` + `vm.Script` with a frozen sandbox.

```typescript
// The sandbox object exposed to user scripts
const sandbox = {
  devbrowser: createDevBrowserAPI(tabManager, extensionHost),
  console: createSafeConsole(scriptId, outputChannel),
  setTimeout,
  clearTimeout,
  setInterval,
  clearInterval,
  // Explicitly NOT included: require, process, __dirname, fetch, XMLHttpRequest
};
Object.freeze(sandbox);

// Script runs inside vm.Script context — cannot escape sandbox
const script = new vm.Script(userCode);
const context = vm.createContext(sandbox);
script.runInContext(context);
```

Worker thread adds another isolation layer: even if vm sandbox is escaped,
the worker process is isolated from the extension host process.

---

## 7. HOW DO WE HANDLE THE ACTIVITY BAR ICON?

**The problem:** We need the extension icon visible at ALL times, not just
when the user knows to type a command.

**VS Code's Activity Bar** is the leftmost vertical strip of icons (Explorer,
Search, Git, Extensions...). Extensions can add their own icon here.

**Implementation:**
- `package.json` `contributes.viewsContainers.activitybar` registers the icon.
- The icon opens a TreeView panel (sidebar), NOT the main browser panel.
- The sidebar has: "Open Browser" button, bookmarks, history, security badge.
- The main browser panel is a `WebviewPanel` in the editor area.

**Icon design requirements:**
- Must be SVG, monochrome (VS Code applies theme color automatically)
- Must be visually recognizable at 24px × 24px
- Our icon concept: a browser window outline with a small lightning bolt / AI sparkle
  indicating the AI-powered nature. Simple, clean, recognizable.
- Icon lives at `media/icons/activity-bar.svg`

**Badge on Activity Bar icon:**
VS Code allows a badge (number) on Activity Bar icons via `TreeView.badge`.
We use this to show the count of unresolved critical/high security findings.
This means security issues are ALWAYS visible to the developer even when
DevBrowser Pro is not the active panel.

```typescript
this.treeView.badge = {
  value: criticalAndHighCount,
  tooltip: `${criticalAndHighCount} security findings require attention`
};
```

---

## 8. HOW DO WE HANDLE "CHROME NOT INSTALLED"?

**Detection order (chromeLocator.ts):**
```
Windows: HKLM\SOFTWARE\Google\Chrome\BLBeacon\version (registry)
         %PROGRAMFILES%\Google\Chrome\Application\chrome.exe
         %PROGRAMFILES(X86)%\Google\Chrome\Application\chrome.exe
         Microsoft Edge: %PROGRAMFILES(X86)%\Microsoft\Edge\Application\msedge.exe

macOS:   /Applications/Google Chrome.app/Contents/MacOS/Google Chrome
         /Applications/Google Chrome Beta.app/...
         /Applications/Microsoft Edge.app/...
         puppeteer-core's executablePath() as last resort

Linux:   which google-chrome, which google-chrome-stable, which chromium-browser
         /usr/bin/google-chrome, /usr/bin/chromium
```

**If not found:**
- Show VS Code notification: "DevBrowser Pro needs Google Chrome or Microsoft Edge.
  [Download Chrome] [Download Edge] [Dismiss]"
- Buttons open the download URL in the system browser.
- Fall back to "lite mode" (iframe + proxy, no DevTools, no security scanner)
  for localhost URLs until Chrome is installed.

---

## 9. KNOWN TECHNICAL LIMITATIONS (Do Not Try to Solve These)

These are ACKNOWLEDGED limitations. They are documented so agents don't
waste time trying to "fix" them.

1. **Sites with aggressive bot detection (Cloudflare, etc.)** may show CAPTCHA
   or block access to the headless browser. This is intentional by the site owner.
   We cannot and should not bypass this. Use the real Chrome for those sites.

2. **Chrome Extensions** (like uBlock Origin, React DevTools) cannot run inside
   our headless Chrome instance. Chrome Extensions require a different launch
   profile setup that would add complexity with minimal benefit for our use case.

3. **Video with DRM** (Netflix, Disney+) will not play in headless Chrome.
   Headless Chrome does not support Widevine CDM. This is by design.

4. **WebRTC** features may behave differently in headless mode.
   Camera/microphone access will not work (no real hardware in headless).

5. **Memory:** Each active (non-suspended) tab uses ~80-150MB RAM in headless
   Chrome. This is unavoidable — it's how Chrome works. Tab suspension mitigates it.
