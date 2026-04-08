# RESEARCH.md
# DevBrowser Pro — Market Research & Competitive Analysis

> Ground truth for what exists, what works, what doesn't, and where the gap is.
> Agents: read this before designing any feature to avoid reinventing things
> that already exist OR building things that will conflict with existing tools.

---

## 1. EXISTING VS CODE BROWSER EXTENSIONS (Know Your Predecessors)

### Microsoft Live Preview
- **Status:** Active (Microsoft first-party)
- **What it does:** Previews LOCAL HTML files and local dev servers only
- **Mechanism:** Embedded iframe pointing to localhost
- **DevTools:** None — literally just an iframe
- **AI:** None
- **Multi-tab:** No
- **External URLs:** No — only localhost
- **Security tools:** None
- **Our overlap:** Very low — Live Preview is a file previewer. We're a browser.
- **Risk:** Microsoft could expand it, but hasn't in 3 years.

### Browser Preview (auchenberg)
- **Status:** ARCHIVED / UNMAINTAINED (last commit 2021)
- **What it does:** Embedded browser using headless Chrome + CDP screencast
- **Mechanism:** SAME as our approach (puppeteer-core + CDP)
- **DevTools:** Basic (just console + elements in early state)
- **AI:** None (2021 product — pre-AI tools era)
- **Multi-tab:** No
- **Our overlap:** High on core browser. This is our technical ancestor.
- **Key lesson from its failure:** It was abandoned because the author joined
  Microsoft and Live Preview became the "official" solution. Community demand
  for a proper browser extension never went away — it just went unserved.
- **What we take from it:** The CDP screencast approach is PROVEN. Its core
  architecture is sound. We build far beyond what it did.

### VS Code Web Browser (mfolarin)
- **Status:** Active but basic
- **What it does:** iframe-based browser with history/bookmarks
- **Mechanism:** iframe + some URL management
- **DevTools:** None
- **AI:** None
- **Multi-tab:** Minimal
- **Our overlap:** Low — we supersede this entirely
- **Risk:** Negligible — inactive development

### GitHub Copilot Vision (experimental, 2025)
- **Status:** Limited preview
- **What it does:** Copilot can take a screenshot of a locally running app
  and reason about visual layout
- **Mechanism:** Screenshot → multimodal model → text response
- **Our overlap:** Partial — we share the "AI sees the browser" concept
- **Key difference:** Copilot Vision is a screenshot tool. We have a LIVE
  interactive browser with full CDP access. They're different layers.
- **Risk:** If Copilot expands to full CDP access, this becomes competition.
  Mitigation: build the plugin ecosystem and community moat fast.

---

## 2. RELATED TOOLS OUTSIDE VS CODE (Context for Feature Design)

### Chrome DevTools
- The gold standard for browser debugging
- Our DevTools panels should feel FAMILIAR to Chrome DevTools users
- Do NOT reinvent naming — use the same panel names, same terminology
- Do NOT change keyboard shortcuts — use the same ones
- Chrome DevTools reference: https://developer.chrome.com/docs/devtools

### Burp Suite Pro
- Industry standard for security testing
- Our intercepting proxy is inspired by Burp's Proxy tab
- Our fuzzer is inspired by Burp's Intruder
- Key difference: Burp is external, requires Java, costs $449/year, has no AI fix gen
- We are: embedded, Node.js-based, has AI that reads source code and generates fixes

### OWASP ZAP
- Open source security scanner
- Feature-rich but complex UI
- Our security scanner scope: developers testing their OWN apps, not professional pentesters
- We aim to be simpler than ZAP, more integrated than ZAP, with AI ZAP lacks

### Postman
- API testing standard
- Our API Tester replaces Postman for the common 90% of use cases
- Key advantage: our collections live in .devbrowser/ alongside the code
- Postman's key advantage we don't have: Postman has team collaboration, cloud sync
- Phase 8 team features close this gap

### Playwright / Cypress
- E2E testing frameworks
- Our MCP bridge allows AI to DO what these frameworks automate
- We don't replace them — our AI can GENERATE Playwright/Cypress scripts
  from actions it observed in the browser

### Tampermonkey / Greasemonkey
- User script engines for Chrome/Firefox
- Our User Scripts (Phase 8) are directly inspired by their @metadata format
- Key difference: our scripts have IDE context (can call VS Code APIs, know open files)

---

## 3. THE ACTUAL GAP (Why This Product Must Exist)

No existing tool combines:
1. Real browser embedded in VS Code (any URL, not just localhost)
2. Full DevTools inspector (not just a console)
3. AI with browser context (not just code context)
4. Backend API testing (replaces Postman)
5. Security scanner (replaces Burp for dev use case)
6. Source code synchronization (DevTools → editor navigation)
7. MCP bridge (browser as tool for AI coding agents)

**The workflow tax today:**
Every web developer uses: VS Code + Chrome + Postman + ChatGPT/Claude + 
securityheaders.com + maybe Burp. These are 5+ separate applications.
Context switching between them costs ~2 hours/day of productivity.

**What this tells us about positioning:**
- Don't market as "a browser extension"
- Market as "the end of context switching for web developers"
- The demo that sells the product: fix a bug without leaving VS Code

---

## 4. MARKET SIZE & DEVELOPER LANDSCAPE

- VS Code: ~30 million monthly active users (Microsoft, 2025)
- VS Code market share: 75.9% of all developers (Stack Overflow 2025)
- Cursor: 17.9% of developers — fastest growing IDE ever recorded
- Web developers (frontend + backend): ~28 million globally
- Developer tools market: $7.57B (2025), projected $29B (2035)
- Average developer tooling spend: $150-400/year per developer
- Comparable VS Code extension revenues: Tabnine (~$100M ARR), Copilot ($200M+ ARR)

**Target initial segment:** Full-stack web developers using VS Code/Cursor.
These are developers who context-switch between browser and IDE constantly.
An estimated 8-12 million developers fit this profile exactly.

---

## 5. TECHNICAL REFERENCES (Verified Sources for Implementation)

These are verified, real APIs and documentation.
Agents: if you need to implement something in these areas, start here.

**VS Code Extension API:**
- https://code.visualstudio.com/api/references/vscode-api
- WebviewPanel: `vscode.window.createWebviewPanel()`
- TreeView: `vscode.window.createTreeView()`
- Activity Bar: `contributes.viewsContainers.activitybar` in package.json

**Chrome DevTools Protocol:**
- https://chromedevtools.github.io/devtools-protocol/
- Page domain: Navigation, screencast, lifecycle
- DOM domain: Document access, node manipulation
- CSS domain: Styles, rules, computed values
- Network domain: Request/response interception
- Runtime domain: Console, evaluation, heap

**Puppeteer-core:**
- https://pptr.dev/
- Use puppeteer-core (not puppeteer) — no bundled Chromium
- `puppeteer.connect({ browserURL: cdpEndpoint })` to connect to running Chrome

**MCP SDK:**
- https://github.com/modelcontextprotocol/typescript-sdk
- Package: `@modelcontextprotocol/sdk`
- Use `StdioServerTransport` for the server transport
- Tool definition: `server.tool(name, description, schema, handler)`

**OSV.dev API (CVE database, free):**
- https://osv.dev/docs/
- `POST https://api.osv.dev/v1/query` with package name + version
- Returns list of known vulnerabilities

**OWASP Top 10 (2025):**
- https://owasp.org/www-project-top-ten/
- Our security scanner covers all 10 categories
- Verified list (as of 2025): see SPEC.md Security Scanner section

---

## 6. WHAT DEVELOPERS ACTUALLY COMPLAIN ABOUT (User Research)

From developer forums, Reddit, Twitter/X, and Stack Overflow:
- "I wish I didn't have to switch to Chrome to see the network request"
- "Postman is too heavy. I want API testing in my editor"
- "I keep copy-pasting errors from Chrome DevTools into ChatGPT"
- "Our staging server gets hacked because nobody checks security headers"
- "Cursor writes the code but I still have to manually test it in Chrome"
- "I have 47 browser tabs open because I can't get context back once I close them"

These are real, recurring complaints. Every feature we build maps to one of these.
Build features that solve these exact complaints. Don't build features that sound
cool but nobody asked for.
