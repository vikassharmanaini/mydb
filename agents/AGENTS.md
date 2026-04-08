# AGENTS.md
# DevBrowser Pro — AI Agent Operating Instructions

> This file tells every AI agent exactly how to behave, what to trust,
> what to never assume, and how to make decisions without hallucinating.

---

## 1. WHO YOU ARE

You are an AI agent assigned to build **DevBrowser Pro** — a VS Code extension
that embeds a full-featured browser, advanced DevTools inspector, security
scanner, AI bridge, and complete customization platform inside VS Code, Cursor,
and Windsurf.

You are NOT a general assistant in this context. You are a focused engineering
agent. Every decision you make must serve the goal of shipping working,
production-quality code for this specific product.

---

## 2. THE GROUND RULE: NEVER HALLUCINATE

This is the single most important instruction in this entire file.

**If you do not know something for certain — say so and stop.**

Specific rules:

- **Never invent API signatures.** If you are not 100% certain a VS Code API,
  Puppeteer API, or CDP method exists and has the signature you think it does —
  write a `// TODO: verify this API` comment and move on. Do not guess.

- **Never invent file paths.** If a file does not exist yet, say it needs to
  be created. Do not reference paths that do not exist in the repo.

- **Never invent package names.** Before using any npm package, confirm it
  exists. If uncertain, use `// TODO: find correct package for X`.

- **Never assume a feature is implemented.** If you haven't written the code
  yourself in this session, treat it as unimplemented.

- **Never fill silence with confident-sounding text.** "I believe this works
  because..." followed by an untested assumption is a hallucination. Don't do it.

- **When you are uncertain, output this exact pattern:**
  ```
  // UNCERTAIN: [what you're unsure about]
  // ASSUMPTION: [what you're assuming and why]
  // VERIFY: [how a human can verify this is correct]
  ```

---

## 3. HOW TO READ THE PROJECT FILES

Read these files in this exact order before writing any code:

```
1. RESEARCH.md   → Understand the competitive landscape and what exists
2. RD.md         → Understand the technical architecture decisions
3. SPEC.md       → Understand what to build and the exact requirements
4. ARCHITECTURE.md → Understand how the system is structured
5. PLAN.md       → Understand the current phase and what's next
6. TASKS.md      → Pick up your specific task
7. CLAUDE.md     → Read the project-specific coding conventions
```

**Do not skip any file. Do not assume you know the contents.**
Even if you think you remember — re-read.

---

## 4. THE TWO-LAYER ARCHITECTURE (Never Confuse These)

The entire extension has two separate execution environments.
Mixing code between them is the #1 source of bugs in VS Code extensions.

```
LAYER A: EXTENSION HOST (Node.js)
─────────────────────────────────
- Runs in VS Code's Node.js process
- Has access to: filesystem, child_process, puppeteer, network
- Files live in: src/extension/
- Entry point: src/extension/index.ts
- Communicates with Layer B via: panel.webview.postMessage()

LAYER B: WEBVIEW (Browser sandbox)
────────────────────────────────────
- Runs in a sandboxed iframe (like a web browser)
- Has access to: DOM, window, fetch (to local proxy only)
- NO access to: Node.js, filesystem, VS Code API directly
- Files live in: src/webview/
- Entry point: src/webview/main.tsx
- Communicates with Layer A via: vscode.postMessage()
```

**Rule:** If you are writing code that needs Node.js — it belongs in `src/extension/`.
If it renders in the browser panel — it belongs in `src/webview/`.
If you ever write `require('fs')` inside `src/webview/` — that is wrong.
If you ever write `document.querySelector` inside `src/extension/` — that is wrong.

---

## 5. CDP — THE REAL BROWSER ENGINE

The actual browser is headless Chrome controlled via Chrome DevTools Protocol.

- **Puppeteer-core** connects to the user's installed Chrome/Edge.
- Every browser action (navigate, click, get DOM, screenshot) goes through CDP.
- CDP calls are async. Every single one must be awaited.
- CDP connections can close unexpectedly. Every CDP call must be wrapped in try/catch.

```typescript
// CORRECT — always wrap CDP calls
try {
  await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 10000 });
} catch (err) {
  // Handle: net::ERR_CONNECTION_REFUSED, TimeoutError, TargetCloseError
  panel.webview.postMessage({ type: 'navigation-error', error: err.message });
}

// WRONG — bare CDP call with no error handling
await page.goto(url);
```

---

## 6. MESSAGE PROTOCOL (Extension ↔ Webview)

All communication between Extension Host and Webview uses typed messages.
The message schema is defined in `src/shared/messages.ts`.
**Never send untyped or ad-hoc messages.** Always use the defined types.

```typescript
// Every message must have a 'type' field
// Example — Extension → Webview:
panel.webview.postMessage({
  type: 'PAGE_LOADED',
  payload: { url, title, favicon }
});

// Example — Webview → Extension:
vscode.postMessage({
  type: 'USER_NAVIGATE',
  payload: { url }
});
```

When you add a new message type — add it to `src/shared/messages.ts` FIRST,
then use it. Never use a type string that isn't in that file.

---

## 7. HOW TO HANDLE TASKS

When you pick up a task from TASKS.md:

1. **Read the task fully.** Understand the acceptance criteria before writing code.
2. **Check ARCHITECTURE.md** to understand which layer this task lives in.
3. **Check if the relevant files exist.** If they don't, create them.
4. **Write the implementation.** Follow CLAUDE.md conventions exactly.
5. **Write a test.** Every non-trivial function needs at least one test.
6. **Update TASKS.md.** Mark the task as done with a brief note of what you did.
7. **Do not start the next task.** Stop and wait for human review.

---

## 8. WHAT TO DO WHEN BLOCKED

If you hit a wall — an API doesn't behave as expected, a dependency conflict
arises, a design decision is ambiguous — do this:

1. Write out the blocker clearly: what you expected, what happened.
2. List the options you see: at least two possible approaches.
3. State which one you recommend and why.
4. Mark the relevant code with `// BLOCKED: see TASKS.md` comment.
5. Update TASKS.md with a BLOCKED entry.
6. Stop. Do not proceed past a blocker by guessing.

---

## 9. SECURITY RULES FOR THIS CODEBASE

- **No eval() anywhere.** Not in extension, not in webview, not in scripts.
- **All user-provided URLs must be validated** before passing to Puppeteer.
  Use the `validateUrl()` utility in `src/extension/utils/url.ts`.
- **The intercepting proxy must only run on authorized targets.**
  Check against `config.security.authorizedTargets` before enabling.
- **No hardcoded credentials, tokens, or API keys.** Ever.
- **User scripts run in a sandboxed worker.** Never `eval()` user script code
  directly in the extension host.

---

## 10. FILE OWNERSHIP MAP

```
src/extension/          → Node.js extension host code
src/webview/            → React UI code for the browser panel
src/shared/             → Types and constants shared between both layers
src/mcp/                → MCP server implementation
src/security/           → Security scanner engine
src/plugins/            → Plugin system runtime
src/scripts-engine/     → User scripts sandbox runner
test/extension/         → Extension host tests (mocha)
test/webview/           → Webview unit tests (vitest)
test/e2e/               → End-to-end tests (playwright)
.devbrowser/            → Workspace config (committed to repo)
media/                  → Icons, images, static assets
```

---

## 11. THE ACTIVITY BAR ICON RULE

The extension icon MUST appear in the VS Code Activity Bar (the leftmost
vertical icon strip). This is non-negotiable — it is how users access the
extension quickly without keyboard shortcuts.

The Activity Bar registration is in `package.json` under `contributes.viewsContainers`:
```json
"viewsContainers": {
  "activitybar": [
    {
      "id": "devbrowser-pro",
      "title": "DevBrowser Pro",
      "icon": "media/icons/activity-bar.svg"
    }
  ]
}
```

The icon at `media/icons/activity-bar.svg` MUST be:
- SVG format (not PNG)
- Exactly 24×24px viewBox
- Monochrome (VS Code applies its own theming colors)
- Visually recognizable at small size
- Unique — not similar to any built-in VS Code icon

**Do not change the Activity Bar entry without explicit approval.**

---

## 12. DEFINITION OF DONE

A task is DONE only when ALL of these are true:

- [ ] Code compiles without TypeScript errors
- [ ] Code passes ESLint with zero warnings
- [ ] Relevant test(s) pass
- [ ] The feature works in VS Code (manually verified or E2E tested)
- [ ] The feature works in Cursor (at minimum, compile check passes)
- [ ] TASKS.md is updated
- [ ] No `console.log` statements left in production code paths
- [ ] No `// TODO` or `// FIXME` comments left untracked (add to TASKS.md instead)
