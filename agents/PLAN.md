# PLAN.md
# DevBrowser Pro — Execution Plan

> This is the living plan. Update it as phases complete.
> Current active phase is always marked with ► 
> Do not work on tasks from a later phase until the current phase is DONE.

---

## CURRENT STATUS

```
► PHASE 1 — Foundation & MVP Browser       [ IN PROGRESS ]
  PHASE 2 — Full DevTools Inspector        [ NOT STARTED ]
  PHASE 3 — AI Integration Layer           [ NOT STARTED ]
  PHASE 4 — Backend Developer Tools        [ NOT STARTED ]
  PHASE 5 — Live Page Editor               [ NOT STARTED ]
  PHASE 6 — Security / PenTest Suite       [ NOT STARTED ]
  PHASE 7 — MCP AI Bridge                  [ NOT STARTED ]
  PHASE 8 — Customization Platform         [ NOT STARTED ]
```

---

## PHASE 1 — FOUNDATION & MVP BROWSER
**Goal:** A working VS Code extension that opens a real embedded browser panel
with multi-tab support. Publishable to the VS Code Marketplace.

**Exit criteria for Phase 1:**
- [ ] Extension activates without error in VS Code
- [ ] Activity Bar icon is visible and opens the sidebar
- [ ] Browser panel opens and renders a real page (not a placeholder)
- [ ] User can type a URL and navigate to it
- [ ] User can navigate back, forward, reload
- [ ] At least 2 tabs can be open simultaneously
- [ ] Closing VS Code kills the headless Chrome process (no orphan processes)
- [ ] Extension handles Chrome not being installed gracefully
- [ ] Extension listed in package.json with correct metadata
- [ ] README.md has installation and usage instructions

**Sub-tasks:** See TASKS.md Phase 1 section.

**Known risks:**
- Chrome binary path detection varies by OS. Must test Windows, macOS, Linux.
- Screencast performance must be acceptable on older hardware (target: 20fps on 4-year-old laptop)

---

## PHASE 2 — FULL DEVTOOLS INSPECTOR
**Goal:** DevTools parity with Chrome DevTools for the most-used panels.
Not every single Chrome DevTools feature — just the 20% that covers 80% of daily use.

**Exit criteria for Phase 2:**
- [ ] Elements panel: view DOM tree, select elements, see applied styles
- [ ] Console panel: see all console messages, run JS expressions
- [ ] Network panel: see all requests with method/status/size/time, click for details
- [ ] "Jump to Source" works: click a CSS rule → opens the file in VS Code editor
- [ ] Responsive preview: change viewport to predefined devices
- [ ] Performance: Core Web Vitals shown on each page load
- [ ] Storage panel: view/edit localStorage and cookies

**Sub-tasks:** See TASKS.md Phase 2 section.

---

## PHASE 3 — AI INTEGRATION LAYER
**Goal:** AI sidebar with full browser context. AI can explain errors, suggest fixes,
and generate code from what's visible in the browser.

**Exit criteria for Phase 3:**
- [ ] AI sidebar panel in DevTools tab bar
- [ ] AI receives page URL + console errors + network failures as context automatically
- [ ] "Explain this error" works on any console error
- [ ] "Fix this CSS" works on any selected element
- [ ] AI model is configurable (Claude, GPT-4o)
- [ ] @browser context variable works in AI chat

**Sub-tasks:** See TASKS.md Phase 3 section.

---

## PHASE 4 — BACKEND DEVELOPER TOOLS
**Goal:** Replace Postman for the common 90% of API testing use cases.

**Exit criteria for Phase 4:**
- [ ] Send any HTTP method with custom headers/body
- [ ] Save requests to named collections
- [ ] Environment variables (local/staging/production)
- [ ] Import from captured network requests ("Send to API Tester")
- [ ] Mock server: intercept URL pattern and return custom response
- [ ] GraphQL: send queries with introspection

**Sub-tasks:** See TASKS.md Phase 4 section.

---

## PHASE 5 — LIVE PAGE EDITOR
**Goal:** Click any element on the rendered page and edit it visually.
Changes write back to VS Code source files.

**Exit criteria for Phase 5:**
- [ ] Click to select element (shows visual handles)
- [ ] Edit text inline (double-click)
- [ ] Edit CSS properties in the visual panel
- [ ] Tailwind class picker (detects if project uses Tailwind)
- [ ] Changes write back to the correct source file via VS Code TextEdit API
- [ ] Diff preview before applying changes
- [ ] Undo/redo stack

**Sub-tasks:** See TASKS.md Phase 5 section.

---

## PHASE 6 — SECURITY / PENTEST SUITE
**Goal:** Passive scanner always on. Active scanner on opt-in.
AI generates specific code fixes for each finding.

**Exit criteria for Phase 6:**
- [ ] Passive scanner runs on every page load with zero user action
- [ ] Security headers graded with A-F score on every page
- [ ] Secret detector scans loaded JS bundles
- [ ] Dependency CVE checker via OSV.dev API
- [ ] Intercepting proxy: capture and display all traffic
- [ ] Active XSS scanner (localhost only by default)
- [ ] Security report exported as PDF/Markdown
- [ ] AI Security Advisor: reads source file + generates specific fix

**Sub-tasks:** See TASKS.md Phase 6 section.

---

## PHASE 7 — MCP AI BRIDGE
**Goal:** IDE's AI (Cursor, Copilot, Claude Code) can control the browser
through MCP tool calls. Auto-configures itself on install.

**Exit criteria for Phase 7:**
- [ ] MCP server starts alongside extension
- [ ] browser_navigate, browser_screenshot, browser_click, browser_type all work
- [ ] browser_get_dom, browser_get_console_logs, browser_get_network_log work
- [ ] security_passive_scan callable via MCP
- [ ] Auto-writes MCP config for Cursor (.cursor/mcp.json)
- [ ] Auto-writes MCP config for VS Code Copilot (settings.json)
- [ ] Cursor AI can complete the demo scenario: navigate → screenshot → analyze

**Sub-tasks:** See TASKS.md Phase 7 section.

---

## PHASE 8 — CUSTOMIZATION PLATFORM
**Goal:** Plugin API, user scripts, config-as-code, theme engine.

**Exit criteria for Phase 8:**
- [ ] User scripts: load/run/disable from .devbrowser/scripts/
- [ ] Plugin API: install plugin, shows new panel tab
- [ ] Config-as-code: .devbrowser/config.json applied on workspace open
- [ ] Theme engine: override CSS variables via theme JSON
- [ ] Command palette inside DevBrowser Pro panel
- [ ] Official React DevTools plugin ships and works

**Sub-tasks:** See TASKS.md Phase 8 section.

---

## DECISION LOG

Decisions made that affect architecture or approach. Date each entry.

| Date | Decision | Reason |
|------|----------|--------|
| — | Use puppeteer-core (not full puppeteer) so we don't bundle Chromium | Extension size limit; users have Chrome installed |
| — | Use screencast (JPEG frames) not iframe for rendering | Cannot iframe arbitrary URLs due to X-Frame-Options / CSP |
| — | MCP server runs as separate stdio process (not in extension host) | MCP spec requires stdio transport; extension host can't be stdio |
| — | Activity Bar icon always present (not just command palette) | Maximum visibility is a product requirement |
| — | .devbrowser/ directory committed to Git | Team sharing of config is a core feature |
