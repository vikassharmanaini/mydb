# CLAUDE.md
# DevBrowser Pro — Coding Conventions & AI Instructions

> This file is read by Claude and other AI assistants working in this repo.
> It defines the code style, patterns, and hard rules for this specific project.

---

## LANGUAGE & RUNTIME

- **TypeScript everywhere.** No plain JavaScript files except config files.
- **Strict TypeScript.** `"strict": true` in tsconfig. No `any` types unless
  explicitly justified with a comment explaining why.
- **Node.js 20+** for extension host. Target: `"module": "commonjs"` for the
  extension host (VS Code requirement), `"module": "ESNext"` for webview.
- **React 18** for the webview UI. Functional components only. No class components.

---

## CODE STYLE

### Naming Conventions
```typescript
// Files: PascalCase for classes, camelCase for modules
BrowserManager.ts     ✅
browserManager.ts     ❌ (if it exports a class)

// Classes: PascalCase
class TabManager { }  ✅

// Functions: camelCase
function navigateTo() { }  ✅

// Constants: SCREAMING_SNAKE_CASE for true constants
const MAX_TABS = 20;  ✅
const maxTabs = 20;   ❌

// Types and Interfaces: PascalCase, Interfaces prefixed with I
interface ITab { }   ✅  (or just Tab { } — consistency within file)
type TabState = { }  ✅

// React components: PascalCase
function NetworkPanel() { }  ✅

// Zustand stores: camelCase with 'use' prefix
const useTabStore = create(...)  ✅
```

### Imports
```typescript
// Order: Node built-ins → VS Code API → third-party → internal
import * as path from 'path';
import * as vscode from 'vscode';
import puppeteer from 'puppeteer-core';
import { TabManager } from './TabManager';

// No default exports from utility/class files. Named exports only.
export class BrowserManager { }   ✅
export default BrowserManager;   ❌
```

### Error Handling
```typescript
// ALWAYS handle CDP errors explicitly
// CDP can throw: TimeoutError, TargetCloseError, ProtocolError
try {
  const result = await page.evaluate(() => document.title);
} catch (err) {
  if (err instanceof TimeoutError) {
    // Page took too long — notify webview, continue
  } else if (err.message.includes('Target closed')) {
    // Tab was closed while operation in flight — silently ignore
  } else {
    // Unexpected error — log and notify webview
    logger.error('Unexpected CDP error', err);
  }
}

// Never swallow errors silently without at least logging them
try {
  doSomething();
} catch (err) {
  // ❌ WRONG: empty catch
}

try {
  doSomething();
} catch (err) {
  logger.warn('doSomething failed', err); // ✅ at minimum, log it
}
```

### Async/Await
```typescript
// Always await Promises. Never fire-and-forget unless intentional.
// If intentional, add a comment:
void someOperation(); // intentional fire-and-forget: we don't need the result

// Never use .then() chains when await is available
// ❌
page.goto(url).then(() => { doSomething(); });
// ✅
await page.goto(url);
doSomething();
```

---

## REACT COMPONENT CONVENTIONS

```tsx
// Component file structure:
// 1. Imports
// 2. Types/interfaces local to this component
// 3. Component function
// 4. Sub-components (if small enough to co-locate)
// 5. Named exports at bottom

// Props type always explicitly defined
interface NetworkPanelProps {
  onRequestSelect: (request: NetworkRequest) => void;
}

// Component: arrow function or named function — be consistent per file
export function NetworkPanel({ onRequestSelect }: NetworkPanelProps) {
  // Hooks first
  const requests = useDevtoolsStore((s) => s.networkRequests);
  const [filter, setFilter] = useState('');

  // Derived values (no useMemo unless actually needed for performance)
  const filtered = requests.filter((r) => r.url.includes(filter));

  // Handlers
  const handleFilterChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFilter(e.target.value);
  };

  // Render
  return (
    <div className="network-panel">
      {/* ... */}
    </div>
  );
}
```

---

## ZUSTAND STORE CONVENTIONS

```typescript
// One store file per domain area
// Store shape: flat where possible
// Selectors: used in components, never access store.getState() in components

interface TabStore {
  tabs: Tab[];
  activeTabId: string | null;
  // Actions co-located with state
  addTab: (url: string) => void;
  closeTab: (id: string) => void;
  setActiveTab: (id: string) => void;
}

export const useTabStore = create<TabStore>((set, get) => ({
  tabs: [],
  activeTabId: null,
  addTab: (url) => set((state) => ({
    tabs: [...state.tabs, createTab(url)]
  })),
  // ...
}));
```

---

## MESSAGE PROTOCOL (THE MOST IMPORTANT CONVENTION)

Every message between Extension Host and Webview MUST be defined in
`src/shared/messages.ts` before use.

```typescript
// src/shared/messages.ts

// Extension → Webview messages
export type ExtensionToWebviewMessage =
  | { type: 'PAGE_LOADED'; payload: { tabId: string; url: string; title: string } }
  | { type: 'SCREENCAST_FRAME'; payload: { tabId: string; data: string; width: number; height: number } }
  | { type: 'CONSOLE_MESSAGE'; payload: { tabId: string; level: string; text: string; timestamp: number } }
  | { type: 'NETWORK_REQUEST'; payload: NetworkRequest }
  | { type: 'SECURITY_FINDING'; payload: SecurityFinding }
  | { type: 'NAVIGATION_ERROR'; payload: { tabId: string; error: string } }
  // ADD NEW TYPES HERE — never use inline string literals

// Webview → Extension messages
export type WebviewToExtensionMessage =
  | { type: 'USER_NAVIGATE'; payload: { tabId: string; url: string } }
  | { type: 'USER_CLICK'; payload: { tabId: string; x: number; y: number } }
  | { type: 'USER_KEYDOWN'; payload: { tabId: string; key: string; modifiers: string[] } }
  | { type: 'NEW_TAB'; payload: { url?: string } }
  | { type: 'CLOSE_TAB'; payload: { tabId: string } }
  | { type: 'AI_QUERY'; payload: { query: string; context: BrowserContext } }
  // ADD NEW TYPES HERE
```

**Rule:** If you find yourself writing a message type as a string literal
anywhere other than in this file — stop. Add it to this file first.

---

## SECURITY RULES (HARD STOPS)

These are not style suggestions. They are hard stops. Violating them will
cause the PR to be rejected.

```typescript
// ❌ NEVER: eval() anywhere
eval(userCode);                     // NEVER
new Function(userCode)();           // NEVER (same as eval)
vm.runInThisContext(userCode);       // NEVER (use vm.Script with sandbox)

// ❌ NEVER: unvalidated URLs passed to puppeteer
await page.goto(userInput);         // NEVER
// ✅ ALWAYS: validate first
const safeUrl = validateUrl(userInput); // throws if invalid
await page.goto(safeUrl);

// ❌ NEVER: hardcoded secrets
const apiKey = 'sk-abc123';         // NEVER

// ❌ NEVER: active scanner on unauthorized domain
await activeScanner.scan(anyUrl);  // NEVER without auth check
// ✅ ALWAYS:
if (!isAuthorizedTarget(url)) { throw new Error('Not authorized'); }
await activeScanner.scan(url);
```

---

## LOGGING

Use the project logger, never `console.log` in production paths.

```typescript
import { logger } from '../utils/logger';

logger.debug('Page navigated', { tabId, url }); // Only in dev builds
logger.info('Security finding added', { severity, type });
logger.warn('CDP operation timed out', { operation, timeout });
logger.error('Chrome process crashed', { exitCode, signal });
```

The logger writes to VS Code's Output channel "DevBrowser Pro".
`console.log()` is only acceptable in webview code during development.
Remove all `console.log` before marking a task as done.

---

## TESTING REQUIREMENTS

### Extension Host Tests (Mocha)
- Every public method on every class needs at least one test
- CDP calls must be mocked (never make real Chrome calls in unit tests)
- Use sinon for mocking/stubbing

### Webview Tests (Vitest + React Testing Library)
- Every React component needs a render test (does it render without crashing)
- Interactive components need interaction tests

### E2E Tests (Playwright + @vscode/test-electron)
- Core user flows must have E2E coverage:
  - Navigate to a URL
  - Open a new tab
  - See a console.log in the Console panel
  - See a network request in the Network panel
  - Run passive security scan

---

## VS CODE EXTENSION SPECIFIC

```typescript
// Always register disposables on extension context
context.subscriptions.push(
  vscode.commands.registerCommand('devbrowser.open', handler)
);
// Never register without pushing to subscriptions — memory leak

// Always handle extension deactivation cleanly
export function deactivate() {
  // Kill Chrome process
  // Stop proxy server
  // Close MCP server
  // Dispose all subscriptions (done automatically via context.subscriptions)
}

// Use vscode.workspace.getConfiguration for user settings
const config = vscode.workspace.getConfiguration('devbrowserPro');
const homePage = config.get<string>('homePage', 'about:blank');
// Never read settings from anywhere else
```

---

## PACKAGE.JSON CONTRIBUTION POINTS

The `package.json` is the source of truth for:
- Commands (`contributes.commands`)
- Keybindings (`contributes.keybindings`)
- Settings schema (`contributes.configuration`)
- Activity Bar sidebar (`contributes.viewsContainers.activitybar`)
- Views (`contributes.views`)

**Do not add VS Code contributions in TypeScript code.**
All contributions must be declared in `package.json`.
TypeScript code only implements the handlers.

---

## THE ACTIVITY BAR ICON

```json
// In package.json — this must always be present
"contributes": {
  "viewsContainers": {
    "activitybar": [
      {
        "id": "devbrowser-pro",
        "title": "DevBrowser Pro",
        "icon": "media/icons/activity-bar.svg"
      }
    ]
  },
  "views": {
    "devbrowser-pro": [
      {
        "id": "devbrowser.sidebar",
        "name": "DevBrowser Pro",
        "type": "tree"
      }
    ]
  }
}
```

The icon file at `media/icons/activity-bar.svg` must exist.
If it doesn't exist, VS Code will hide the Activity Bar entry silently.
**Always verify this file exists before running the extension.**

---

## WHAT TO DO WITH UNCLEAR REQUIREMENTS

If a task in TASKS.md is ambiguous, do NOT make assumptions.

1. Write what is clear and works.
2. Add `// UNCLEAR: [describe the ambiguity]` comment at the decision point.
3. Update TASKS.md with a note: "Needs clarification: [question]"
4. Stop at that point. Do not proceed past unclear requirements.
