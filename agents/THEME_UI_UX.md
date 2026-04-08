# THEME_UI_UX.md — Premium Design System: DBStudio
### "The database tool that looks like it was designed in Cupertino"

---

## 0. Design Philosophy

DBStudio's visual language is inspired by Apple's pro applications — **Final Cut Pro, Xcode, Instruments** — not consumer iOS apps. This means:

- **Refined density**: Developers need information. Don't waste space. But every element breathes just enough.
- **Material recedes, content leads**: The chrome is invisible. The data is the hero.
- **Systematic consistency**: Every spacing, every radius, every shadow follows the same 4px grid. No exceptions.
- **Motion is communication**: Animations tell the user *what happened*, not just that *something happened*.
- **Dark is the default**: Developers live in dark mode. Design dark first, light as an equally polished variant.

> **The test**: Every screen should look like it belongs in an Apple keynote slide. If it doesn't, keep refining.

---

## 1. Color System

### 1.1 Design Tokens (Dark Mode — Primary)

```dart
// lib/ui/theme/color_tokens.dart

class DBColors {
  // ── Backgrounds ──────────────────────────────────────────────
  static const bg100 = Color(0xFF0A0A0F);   // App background (near black, slightly blue-tinted)
  static const bg200 = Color(0xFF111118);   // Sidebar background
  static const bg300 = Color(0xFF18181F);   // Card / panel surface
  static const bg400 = Color(0xFF1E1E28);   // Elevated card (hover state bg)
  static const bg500 = Color(0xFF252532);   // Input field background
  static const bg600 = Color(0xFF2C2C3A);   // Selected row / active item

  // ── Borders & Dividers ────────────────────────────────────────
  static const border100 = Color(0xFF1F1F2E);  // Subtle dividers
  static const border200 = Color(0xFF2A2A3C);  // Card borders
  static const border300 = Color(0xFF363650);  // Active/focused borders

  // ── Text ──────────────────────────────────────────────────────
  static const text100 = Color(0xFFFFFFFF);    // Primary text (headings, values)
  static const text200 = Color(0xFFE2E2EC);    // Secondary text (labels)
  static const text300 = Color(0xFF9898B0);    // Tertiary text (placeholders, hints)
  static const text400 = Color(0xFF5A5A72);    // Disabled text
  static const textLink = Color(0xFF5B8AF5);   // Clickable text links

  // ── Accent — Electric Blue (primary action) ───────────────────
  static const accentBlue    = Color(0xFF4F87F5);   // Primary CTA, active states
  static const accentBlueSoft = Color(0x194F87F5);  // Blue tint backgrounds (12% opacity)
  static const accentBlueMid  = Color(0x404F87F5);  // Blue mid tint (25% opacity)

  // ── Semantic Colors ───────────────────────────────────────────
  static const success    = Color(0xFF30D158);  // Committed, connected, success
  static const successSoft = Color(0x1930D158);
  static const warning    = Color(0xFFFF9F0A);  // Pending changes, caution
  static const warningSoft = Color(0x19FF9F0A);
  static const danger     = Color(0xFFFF453A);  // Errors, destructive actions
  static const dangerSoft  = Color(0x19FF453A);
  static const info       = Color(0xFF64D2FF);  // Info, PostgreSQL highlight

  // ── Syntax Highlighting (SQL Editor — Dark) ───────────────────
  static const syntaxKeyword  = Color(0xFFFF7AB2);  // SELECT, FROM, WHERE — pink
  static const syntaxFunction = Color(0xFF6BDFFF);  // COUNT(), NOW() — cyan
  static const syntaxString   = Color(0xFFFC6A5D);  // 'string literals' — orange-red
  static const syntaxNumber   = Color(0xFFD9C97C);  // 42, 3.14 — gold
  static const syntaxComment  = Color(0xFF7F8C98);  // -- comments — muted
  static const syntaxOperator = Color(0xFFCDA1FF);  // =, <, >, AND — purple
  static const syntaxTable    = Color(0xFF6BDFFF);  // table names — cyan
  static const syntaxColumn   = Color(0xFFACE1AF);  // column names — mint green

  // ── Database Type Colors (connection tags) ────────────────────
  static const dbPostgres  = Color(0xFF336791);
  static const dbMySQL     = Color(0xFF4479A1);
  static const dbSQLite    = Color(0xFF003B57);
  static const dbMSSQL     = Color(0xFFCC2927);
  static const dbMongo     = Color(0xFF47A248);
  static const dbRedis     = Color(0xFFDC382D);
}
```

### 1.2 Design Tokens (Light Mode)

```dart
class DBColorsLight {
  // ── Backgrounds ──────────────────────────────────────────────
  static const bg100 = Color(0xFFF2F2F7);   // App background (iOS system gray6)
  static const bg200 = Color(0xFFFFFFFF);   // Sidebar / primary surface
  static const bg300 = Color(0xFFFFFFFF);   // Cards — pure white
  static const bg400 = Color(0xFFF8F8FC);   // Hover state
  static const bg500 = Color(0xFFF2F2F7);   // Input background
  static const bg600 = Color(0xFFE8EEFF);   // Selected row — blue tint

  // ── Borders ───────────────────────────────────────────────────
  static const border100 = Color(0xFFE8E8EE);  // Subtle
  static const border200 = Color(0xFFD8D8E0);  // Cards
  static const border300 = Color(0xFF4F87F5);  // Focused

  // ── Text ──────────────────────────────────────────────────────
  static const text100 = Color(0xFF0A0A0F);    // Primary
  static const text200 = Color(0xFF3A3A4A);    // Secondary
  static const text300 = Color(0xFF8E8EA0);    // Tertiary
  static const text400 = Color(0xFFBBBBCC);    // Disabled

  // ── Syntax (Light) ────────────────────────────────────────────
  static const syntaxKeyword  = Color(0xFFAD3DA4);  // magenta
  static const syntaxFunction = Color(0xFF326D74);  // teal
  static const syntaxString   = Color(0xFFD12F1B);  // red
  static const syntaxNumber   = Color(0xFF272AD8);  // blue
  static const syntaxComment  = Color(0xFF707080);  // grey
  static const syntaxOperator = Color(0xFF6E44A4);  // purple
  static const syntaxTable    = Color(0xFF326D74);
  static const syntaxColumn   = Color(0xFF2C7E54);
}
```

---

## 2. Typography

### 2.1 Font Stack

```dart
// lib/ui/theme/typography.dart

// PRIMARY: SF Pro (Apple platforms) → falls back to 'Inter Display' (Windows/Linux)
// Load Inter Display via google_fonts package as fallback

class DBTypography {
  static const String fontFamily = '.SF Pro Display';  // macOS/iOS native
  static const String fontFamilyFallback = 'Inter';    // Windows / Linux

  // ── Scale ─────────────────────────────────────────────────────

  // Display — Hero numbers, stat cards
  static const display = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.2,
    height: 1.1,
  );

  // Title Large — Panel headers, dialog titles
  static const titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 1.2,
  );

  // Title Medium — Section headings, tab labels (active)
  static const titleMedium = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.3,
  );

  // Title Small — Tree node labels, sidebar section headers
  static const titleSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.6,     // slight tracking — uppercase labels
    height: 1.4,
  );

  // Body — Regular content text
  static const body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.1,
    height: 1.5,
  );

  // Body Medium — Table cell text, form values
  static const bodyMedium = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.5,
  );

  // Caption — Metadata, timestamps, row counts
  static const caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // Mono — SQL editor, cell values, DDL
  static const mono = TextStyle(
    fontFamily: 'JetBrains Mono',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.6,
  );

  // Mono Bold — SQL keywords (applied via span)
  static const monoBold = TextStyle(
    fontFamily: 'JetBrains Mono',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.6,
  );

  // Number Display — Stats in dashboard cards
  static const numberDisplay = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.0,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  // Number — Data grid cells (aligned numbers)
  static const numberMono = TextStyle(
    fontFamily: 'JetBrains Mono',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    fontFeatures: [FontFeature.tabularFigures()],
  );
}
```

### 2.2 Typography Rules
- **Never** mix weights within the same visual hierarchy level
- Numbers in data grids: always `tabularFigures` so columns align perfectly
- Uppercase labels: `titleSmall` + `letterSpacing: 0.6` — used for sidebar section headers like "CONNECTIONS", "SCHEMAS"
- Bold accents: use `FontWeight.w700` only for primary numbers (row counts, stat cards, execution time)
- Line lengths: cap prose at 72 characters; data cells uncapped

---

## 3. Spacing & Grid

### 3.1 Base Grid: 4px
Every spacing value is a multiple of 4. No exceptions.

```dart
class DBSpacing {
  static const double px2  = 2;
  static const double px4  = 4;
  static const double px6  = 6;
  static const double px8  = 8;
  static const double px12 = 12;
  static const double px16 = 16;
  static const double px20 = 20;
  static const double px24 = 24;
  static const double px32 = 32;
  static const double px40 = 40;
  static const double px48 = 48;
  static const double px64 = 64;
}
```

### 3.2 Component Spacing Rules
| Component | Internal padding | Between siblings |
|-----------|-----------------|-----------------|
| Sidebar tree node | `8px V × 10px H` | `2px` gap |
| Card | `20px all` | `12px` gap |
| Dialog | `24px all` | `16px` section gap |
| Table cell | `10px V × 12px H` | `0` (border divides) |
| Toolbar button | `8px V × 12px H` | `4px` gap |
| Form field | `12px V × 14px H` | `8px` gap between fields |
| Tab | `10px V × 16px H` | `0` (continuous) |
| Context menu item | `8px V × 14px H` | `1px` divider |

---

## 4. Border Radius System

```dart
class DBRadius {
  static const double none   = 0;
  static const double xs     = 4;   // Tags, badges, chips
  static const double sm     = 6;   // Buttons, inputs
  static const double md     = 10;  // Cards, panels, dialogs
  static const double lg     = 14;  // Modal sheets, large cards
  static const double xl     = 20;  // Full-bleed panels
  static const double full   = 999; // Pills, avatars, toggles
}
```

**Rules:**
- Cards: `md (10px)` — never less, never more
- Buttons: `sm (6px)` — consistent across all button sizes
- Inputs: `sm (6px)` — matches buttons for visual harmony
- Context menus: `md (10px)` — matches macOS native menus
- Sidebar: no radius on left edge (touches window edge); `md` on right side internal cards

---

## 5. Shadow System

Shadows define elevation. Use precisely — not everywhere.

```dart
class DBShadows {

  // Level 0 — No shadow (flat, embedded elements)
  static const none = <BoxShadow>[];

  // Level 1 — Subtle card lift (default card state)
  static const card = [
    BoxShadow(
      color: Color(0x14000000),   // 8% black
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color(0x08000000),   // 3% black — ambient
      blurRadius: 1,
      offset: Offset(0, 0),
      spreadRadius: 0.5,
    ),
  ];

  // Level 2 — Hover card / elevated panel
  static const cardHover = [
    BoxShadow(
      color: Color(0x20000000),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  // Level 3 — Dropdown / context menu
  static const menu = [
    BoxShadow(
      color: Color(0x30000000),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color(0x10000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color(0x08000000),
      blurRadius: 0,
      offset: Offset(0, 0),
      spreadRadius: 0.5,
    ),
  ];

  // Level 4 — Modal dialog
  static const modal = [
    BoxShadow(
      color: Color(0x50000000),
      blurRadius: 48,
      offset: Offset(0, 16),
    ),
    BoxShadow(
      color: Color(0x18000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  // Glow — Blue accent (focused input, active connection)
  static const glowBlue = [
    BoxShadow(
      color: Color(0x354F87F5),
      blurRadius: 12,
      offset: Offset(0, 0),
      spreadRadius: 0,
    ),
  ];

  // Glow — Green (success, connected)
  static const glowGreen = [
    BoxShadow(
      color: Color(0x2830D158),
      blurRadius: 8,
      offset: Offset(0, 0),
    ),
  ];
}
```

**Light mode:** Reduce all shadow opacities by 50%. Add `border: 1px solid border100` to all cards.

---

## 6. Layout: App Shell

### 6.1 Three-Pane Layout

```
┌─────────────────────────────────────────────────────────────────┐
│  Title Bar (custom — borderless, draggable)           [─][□][×]  │
│  H: 40px | bg: bg200 | blur backdrop on macOS                    │
├──────────┬──────────────────────────────────┬───────────────────┤
│          │  Tab Bar                          │                   │
│ Sidebar  │  H: 40px | bg: bg200             │  Right Panel      │
│ W: 260px │──────────────────────────────────│  (optional)       │
│ bg: bg200│                                  │  W: 280px         │
│          │  Content Area                    │  bg: bg200        │
│          │  bg: bg100                       │                   │
│          │                                  │                   │
│          │                                  │                   │
├──────────┴──────────────────────────────────┴───────────────────┤
│  Status Bar  H: 28px | bg: bg200 | borderTop: border100         │
└─────────────────────────────────────────────────────────────────┘
```

### 6.2 Title Bar (macOS Style)
```
- Height: 40px
- Background: bg200 with vibrancy blur on macOS (NSVisualEffectView)
- Window controls (red/yellow/green): left side, 8px from left, vertically centered
- App name "DBStudio" — center, titleSmall weight 600, text300 color
- Active connection indicator — right of app name, 6px dot (success color)
- Toolbar icons — right side (settings, new connection)
- Draggable entire area except interactive controls
- Bottom border: 1px border100
```

### 6.3 Sidebar
```
Width: 260px (resizable 160–400px via drag handle)
Background: bg200

Structure (top to bottom):
  ┌─────────────────────────────────────────────┐
  │ [+] New Connection    [↑] Sort   [🔍]        │  ← Sidebar toolbar, 40px, bg200
  ├─────────────────────────────────────────────┤
  │ CONNECTIONS                                 │  ← Section label: titleSmall, text300, 8px H pad, 4px T pad
  │ ● prod-postgres        192.168.1.1    PG    │  ← Connection tile (see §7.1)
  │ ● staging-mysql        10.0.0.5       MY    │
  ├─────────────────────────────────────────────┤
  │  [expanded tree under active connection]     │
  │  ▾ public                                   │
  │    ▾ Tables (42)                            │
  │      ▸ users                                │
  │      ▸ orders                               │
  └─────────────────────────────────────────────┘
  
Sidebar Section Headers:
  - Text: "CONNECTIONS" | font: titleSmall | color: text400 | tracking: 0.8px
  - Padding: 16px left, 6px top, 4px bottom
  - No background, no border

Sidebar Scroll:
  - Custom thin scrollbar (4px wide, bg: border200, thumb: border300)
  - Fade out at top/bottom edges (gradient mask)
```

### 6.4 Tab Bar
```
Height: 40px
Background: bg200
Bottom border: 1px border100
Left padding: 12px

Tab (inactive):
  Background: transparent
  Text: bodyMedium, text300
  Padding: 10px V × 16px H
  Border radius: 0 (full-width bar style)
  Close button: × appears on hover, text300 color, 16px size

Tab (active):
  Background: bg100 (matches content area — "appears to lift")
  Text: bodyMedium, text100, weight 500
  Top border: 1.5px solid accentBlue — ONLY on active tab
  No bottom border (merges with content)

Tab hover:
  Background: bg300
  Transition: 120ms ease

New tab button (+):
  Right of tabs
  Icon: 18px, text300
  Hover: text200, bg300, 6px radius
```

---

## 7. Component Library

### 7.1 Connection Tile (Sidebar)

```
┌────────────────────────────────────────────────┐
│  ●  prod-postgres             PG  ●connected   │
│     192.168.1.1:5432                           │
└────────────────────────────────────────────────┘

Anatomy:
  - Status dot: 8px circle | success=green, error=red, idle=text400
  - Name: bodyMedium weight 500, text100
  - Host: caption, text300
  - DB badge: "PG" | 20px × 20px | bg: dbPostgres/20% | text: dbPostgres | xs radius | caption bold
  - Connected label: caption, success color — only shown when connected
  - Padding: 10px V × 12px H
  - Border radius: sm (6px)
  - Hover: bg400, transition 100ms
  - Active/selected: bg600, left border 2px accentBlue
  - Right-click → context menu (see §7.8)
```

### 7.2 Tree Node

```
Indent per level: 16px
Connector lines: 1px dashed border200, only between siblings

Node types and icons:
  Schema/Database: folder icon, 16px, text300
  Table:           table-grid icon, text300 
  View:            layers icon, accentBlue/60%
  Column (PK):     key icon, warning color
  Column (FK):     link icon, info color
  Column:          field icon, text400
  Index:           lightning icon, text300
  Trigger:         zap icon, text300
  Procedure/Func:  code icon, syntaxFunction color
  Sequence:        hash icon, text300

Node layout:
  [indent][expand arrow][icon][name][(count badge)]
  
Expand arrow: 10px, rotates 90° when expanded (200ms ease)
Count badge: "(42)" — caption, text400 — shown for Tables, Views, etc.
Row height: 28px
Hover: bg400
Selected: bg600 + text100 (name goes bold)
```

### 7.3 Primary Button

```dart
// Size variants:
//   sm: height 30px, padding 8×12, font 13
//   md: height 36px, padding 10×16, font 14  ← default
//   lg: height 44px, padding 12×20, font 15

// Default (filled)
decoration: BoxDecoration(
  color: accentBlue,
  borderRadius: BorderRadius.circular(DBRadius.sm),
  boxShadow: [
    BoxShadow(color: Color(0x354F87F5), blurRadius: 8, offset: Offset(0, 2)),
  ],
)
// Text: white, weight 600

// Hover: brightness +5%, scale 1.01, shadow grows
// Pressed: brightness -5%, scale 0.99
// Disabled: opacity 0.35, no shadow, no hover

// Secondary (outlined)
decoration: BoxDecoration(
  color: Colors.transparent,
  border: Border.all(color: border300, width: 1),
  borderRadius: BorderRadius.circular(DBRadius.sm),
)
// Text: text200, weight 500
// Hover: bg400

// Ghost (text only)
// Text: text200, weight 500
// Hover: bg400, 6px radius

// Danger
decoration: BoxDecoration(color: danger, ...)
// Hover: danger brightness +5%

// Transitions: all 120ms ease
```

### 7.4 Input Field

```dart
// Normal state
decoration: BoxDecoration(
  color: bg500,
  borderRadius: BorderRadius.circular(DBRadius.sm),
  border: Border.all(color: border200, width: 1),
)
// Label: caption, text300, 4px above field
// Value: body, text100
// Placeholder: body, text400
// Padding: 12px V × 14px H

// Focus state
border: Border.all(color: accentBlue, width: 1.5)
boxShadow: DBShadows.glowBlue
// Transition: 150ms ease

// Error state
border: Border.all(color: danger, width: 1.5)
boxShadow: [BoxShadow(color: Color(0x35FF453A), blurRadius: 8)]
// Error text: caption, danger color, 4px below field

// Password field
// Suffix: eye icon toggle — text300, tap to reveal
// Reveal animation: chars appear with 80ms stagger

// Prefix icons: 16px, text300, 10px right margin
```

### 7.5 Data Grid

```
Column Header Row:
  Height: 36px
  Background: bg300
  Text: caption, weight 600, text300, UPPERCASE, tracking 0.4px
  Sort arrow: appears on hover (14px, text400), rotates on sort
  Resize handle: 4px wide, transparent, cursor: col-resize, bg: accentBlue on drag
  Bottom border: 1.5px border200
  Right border between headers: 1px border100

Data Row (default):
  Height: 36px (dense: 28px / comfortable: 44px — user setting)
  Background: bg100 (odd) / transparent (even) — subtle alternating
  Cell text: mono, text200
  Border bottom: 1px border100

Data Row (hover):
  Background: bg400
  Transition: 60ms (must feel instant)

Data Row (selected):
  Background: accentBlueSoft (12% blue)
  Left border: 2px accentBlue

Data Row (pending edit):
  Background: warningSoft
  Left border: 2px warning
  Dot indicator: 6px warning dot in leftmost column

Cell (NULL value):
  Text: "NULL" — caption, text400, italic, bg: transparent
  Different from empty string: empty string shows nothing

Cell (focused/editing):
  Border: 1.5px accentBlue on all 4 sides
  Background: bg500
  No border radius (maintains grid alignment)
  Text input appears inline

Cell (BLOB):
  Shows "[BLOB 4.2KB]" — caption, info color, with expand icon
  Click → opens viewer panel

Number cells: right-aligned, numberMono font
Text cells: left-aligned, mono font
Boolean cells: checkmark icon (success) / dash icon (text400)
Date cells: formatted per locale, right-aligned

Scrollbar (horizontal and vertical):
  Thin: 6px
  Track: transparent
  Thumb: border300, 4px radius
  Thumb hover: border300 + opacity 100%
  Only visible on hover/scroll

Filter Bar (above header when active):
  Height: 32px per column
  Background: bg300
  Input: compact, no border, bg500, 4px radius
  Clear button: × — appears when filter active
```

### 7.6 SQL Editor

```
Background: bg100 (dark) / white (light) — editor has its OWN bg, distinct from panels
Font: JetBrains Mono, 13px, 1.6 line-height
Padding: 16px left (after gutter), 16px top

Gutter (line numbers):
  Width: 48px
  Background: bg200 — slightly different from editor bg
  Text: caption, text400, right-aligned
  Error indicator: red dot 6px replaces line number
  Breakpoint area: hover shows grey dot → click to add breakpoint

Current line highlight:
  Background: bg400 (subtle stripe on cursor line)
  Left border: 2px accentBlue

Selection highlight:
  Background: accentBlueMid (25% blue)

Autocomplete popup:
  ┌─────────────────────────────────────┐
  │ 🔵 SELECT        keyword            │  ← selected
  │ 📋 users         table              │
  │ 🔑 user_id       column (users)     │
  │ ⚡ COUNT()        function           │
  └─────────────────────────────────────┘
  Background: bg300
  Border: 1px border300
  Border radius: md (10px)
  Shadow: DBShadows.menu
  Width: 280px
  Max height: 240px (scrollable)
  Item height: 32px
  Selected item: bg600, accentBlue left border 2px
  Item icon: 14px, left
  Item type label: caption, text400, right-aligned
  Transition: 100ms fade + 4px slide up

Error squiggle:
  Red wavy underline under error token
  Hover → shows error tooltip (bg300, border danger, 8px radius, caption)

Matching bracket highlight:
  bg600 background, 2px radius

Find/Replace bar:
  Slides in from top of editor panel
  Height: 44px
  Background: bg300
  Border bottom: 1px border200
  Inputs: compact, 6px radius
  Buttons: ghost style
```

### 7.7 Cards (Stat Cards, Dashboard)

```
Anatomy:
  ┌─────────────────────────────────┐
  │  Active Connections      [icon] │  ← header: bodyMedium weight 500, text200
  │                                 │
  │  24                             │  ← value: numberDisplay, text100
  │  ▲ 3 from yesterday             │  ← trend: caption, success (up) / danger (down)
  └─────────────────────────────────┘

Styling:
  Background: bg300
  Border: 1px border200
  Border radius: md (10px)
  Shadow: DBShadows.card
  Padding: 20px
  
  Icon container: 36px × 36px, border radius sm (6px)
    - background: accentBlueSoft
    - icon: 18px, accentBlue

Hover:
  Shadow: DBShadows.cardHover
  Transform: translateY(-1px)
  Transition: 180ms ease

Metric number animation:
  On load: count up from 0 over 600ms (ease-out curve)
  Font: numberDisplay, text100, tabularFigures
```

### 7.8 Context Menu

```
┌──────────────────────────────────────┐
│  📋  Open Data                        │
│  📝  Open SQL Editor                  │
│  ——————————————————————————————————  │  ← 1px border100, 6px V margin
│  🔍  View DDL                         │
│  ✏️  Alter Table...                   │
│  ——————————————————————————————————  │
│  📊  Generate SELECT                  │
│  📊  Generate INSERT                  │
│  ——————————————————————————————————  │
│  🗑️  Drop Table...          ⌦        │  ← destructive: danger color
└──────────────────────────────────────┘

Background: bg300 (dark) / white (light)
Border: 1px border200
Border radius: md (10px)
Shadow: DBShadows.menu
Min width: 220px
Padding: 6px (top + bottom insets)

Item:
  Height: 32px
  Padding: 8px V × 14px H
  Icon: 14px, left, text300
  Label: bodyMedium, text200
  Shortcut: caption, text400, right
  Hover: bg600, icon+label → text100
  Transition: 80ms

Destructive item: danger color text + icon
Divider: 1px border100, 6px V margin, full width

Submenu arrow: › 12px, right side, text300
Submenu: opens 4px to the right

Entry animation: 100ms ease-out, 6px slide from source point
```

### 7.9 Modal Dialog

```
Backdrop: Color(0x80000000) — 50% black blur (if supported: blur 20px)
Dialog:
  Background: bg300
  Border: 1px border200 (subtle, required in dark mode)
  Border radius: lg (14px)
  Shadow: DBShadows.modal
  Width: 480px (small) / 640px (medium) / 800px (large)
  Max height: 80vh
  Padding: 24px

Header:
  Title: titleLarge, text100
  Subtitle (optional): body, text300, 4px below title
  Close button (×): top-right, 24px, text300, hover bg400 full-radius

Body:
  Overflow: scroll (custom thin scrollbar)
  Section gap: 20px

Footer:
  Border top: 1px border100
  Padding top: 16px
  Buttons: right-aligned, gap 8px
  [Cancel] secondary, [Confirm] primary

Entry animation:
  Backdrop: fade 200ms
  Dialog: scale(0.95) → scale(1.0) + fade, 220ms spring(damping: 0.8)

Exit animation:
  Reversed, 160ms
```

### 7.10 Toggle / Switch

```
Width: 44px, Height: 24px (macOS-style)
Track (off): border200 background
Track (on): accentBlue
Thumb: white circle, 20px, 2px inset
Shadow on thumb: BoxShadow(0, 1px, 3px, 0.3 black)
Transition: 200ms spring
```

### 7.11 Badge / Tag

```
Types:
  DB Type badge: "PG" / "MY" / "SQ" / "MS"
    - Size: 24px height, variable width
    - Background: dbColor at 15% opacity
    - Text: caption, weight 700, dbColor
    - Radius: xs (4px)

  Status badge:
    - "Connected": success soft bg, success text
    - "Error": danger soft bg, danger text
    - "Idle": bg500, text300
    - Radius: full (pill)
    - Height: 20px
    - Padding: 0 8px

  Count badge (tree node):
    - "(42)" — caption, text400
    - Plain text, no background
```

---

## 8. ER Diagram Visual Design

```
Canvas background: bg100 (dark) / F5F5FA (light)
Grid dots: border100 color, 20px spacing — subtle dot grid

Table Card:
  ┌─────────────────────────────────────┐
  │  users                    PG        │  ← Header: bg: accentBlue, radius top only
  ├─────────────────────────────────────┤
  │  🔑 id          bigint  NOT NULL    │  ← PK row: slightly highlighted
  │  📧 email       varchar(255)        │
  │  🔗 role_id     integer  FK         │  ← FK row: info color
  │  ···  created_at  timestamp         │
  └─────────────────────────────────────┘
  
  Card background: bg300
  Border: 1px border200
  Border radius: md (10px)
  Shadow: DBShadows.card
  Min width: 200px
  
  Header: 
    Background: accentBlue
    Text: white, titleMedium, weight 600
    DB badge: right side, white/30% bg
    Padding: 10px 12px
    Radius: 10px top-left, 10px top-right, 0 bottom

  Row:
    Height: 28px
    Padding: 0 12px
    Icon: 12px, left
    Column name: caption mono, text200
    Type: caption mono, text400, right-aligned
    Alternating bg: subtle bg200/transparent alternation
    
  Hover card: shadow → cardHover, translateY(-2px), 180ms

FK Relationship Lines:
  Style: curved bezier (cubic)
  Color: border300 (inactive) / accentBlue (hover either endpoint)
  Width: 1.5px
  Animated dashes when connection is being used (optional)
  Arrow head: 6px chevron at target end
  Label: tiny caption on midpoint of curve, bg: bg100 padding 2px 4px

Selected card:
  border: 1.5px accentBlue
  shadow: glowBlue

Mini-map (bottom right corner):
  Size: 160px × 100px
  Background: bg300, 80% opacity
  Border: 1px border200
  Border radius: md
  Shows viewport rectangle as accentBlueSoft fill
```

---

## 9. Status Bar

```
Height: 28px
Background: bg200
Top border: 1px border100
Font: caption (11px)
Padding: 0 12px

Left section:
  ● Connection name — dot (success/danger/idle) + name, bodyMedium, text200
  | divider (1px border200, 14px height, vertical)
  Schema: public — text300

Center section (SQL Editor context):
  Ln 24, Col 8 — text300
  | CRLF — text400
  | UTF-8 — text400
  | SQL (PostgreSQL) — text300

Right section:
  Execution time: "127ms" — caption, success color — fades after 5s
  | Rows: "1,024 / 50,000" — text300
  | [Commit] [Rollback] — only visible when pending edits exist
    Commit: 22px height, success color, outline style
    Rollback: 22px height, danger color, outline style
```

---

## 10. Notification & Toast System

```
Position: top-right, 12px from edge, 52px from top
Stack: newest on top, max 4 visible
Width: 320px

Toast anatomy:
  ┌────────────────────────────────────────┐
  │  ✓  Query executed in 234ms            │  ← success
  │     50,000 rows returned               │
  └────────────────────────────────────────┘

  Background: bg300 (dark) / white (light)
  Border: 1px border200
  Border-left: 3px semantic color (success/warning/danger/info)
  Border radius: md (10px)
  Shadow: DBShadows.menu
  Padding: 12px 14px
  Icon: 16px, semantic color, left
  Title: bodyMedium, weight 500, text100
  Body: caption, text300, 2px below title

Entry animation: slide from right (16px) + fade, 220ms spring
Exit animation: slide to right + fade, 180ms ease-in
Auto-dismiss: 4s (success/info) | 0 (error — user must dismiss)
Progress bar: thin 2px bottom bar, depletes over dismiss time, semantic color

Hover: pauses auto-dismiss timer, shows ×
```

---

## 11. Loading States

### 11.1 Skeleton Loading (tree nodes, cards)
```dart
// Shimmer effect — NOT a spinner
// Color: border100 → border200 gradient sweeping left to right
// Duration: 1.4s infinite
// Use for: tree children loading, card content, metadata fetching

ShimmerBlock(
  width: double.infinity,
  height: 14,         // text line height
  borderRadius: 4,
)
// Stack multiple with varying widths for realistic skeleton
```

### 11.2 Query Execution Loading
```
Results panel shows:
  - Animated pulsing blue top border (2px, sweeps left to right, 1.2s)
  - "Executing..." text, caption, text300
  - Cancel button: ghost style, danger color, appears after 500ms
  - Row count updates live as pages stream in: "↓ 500 rows..." "↓ 1,000 rows..."
```

### 11.3 Connection Loading
```
Connection tile: spinner replaces status dot (14px, accentBlue, 800ms)
Progress text below: "Connecting to prod-postgres..." caption, text300
On SSH: "Opening SSH tunnel..." → "Forwarding port..." → "Connecting..."
```

### 11.4 Inline Spinners
```
Size: 16px (inline) / 20px (button) / 32px (panel center)
Color: accentBlue
Style: circular, 2px stroke, 240° arc, 700ms rotation
Never use: Flutter's default CircularProgressIndicator with full stroke
```

---

## 12. Micro-Interactions & Animations

### Principles
- **Instant feedback**: hover states < 100ms. Anything slower feels broken.
- **Natural motion**: use spring physics for entrances, ease-in for exits
- **Never decorative**: every animation communicates something

### Specific Interactions

```
Tree node expand:
  Arrow: 0° → 90° rotation, 200ms ease
  Children: fade in + 4px slide down, 150ms staggered 20ms per child

Tab open:
  New tab slides in from right, 180ms spring
  Content fades in 120ms after tab settles

Row hover:
  Background: instant (< 16ms) — no transition on bg for performance
  
Row selection click:
  Left border: grows from 0 → 2px, 120ms ease
  Background: fades in, 120ms

Cell edit activation (double-click):
  Cell border appears: 80ms
  Cursor blinks in

Commit success:
  Status bar: "Committed" in success color, 400ms fade in
  Affected rows: brief green flash on committed rows, 300ms → fade out 500ms
  Toast: slides in from right

Connection established:
  Status dot: grey → green with scale(1.4) → scale(1.0) pulse, 300ms
  Sidebar tile: subtle success glow, 400ms fade out

Error state:
  Input field border: shakes horizontally (3 oscillations, ±4px, 300ms)
  Error text: fades in below, 150ms

Query cancel:
  Results panel: red flash on top border, 200ms
  "Cancelled" badge appears briefly

Modal entry:
  Backdrop: 200ms fade
  Dialog: scale(0.94)+opacity(0) → scale(1.0)+opacity(1), 240ms spring

Drag (table in ER diagram):
  Shadow grows immediately: card → cardHover
  Slight tilt: rotate(1.5deg) while dragging
  Drop: settles with spring(damping 0.7, stiffness 400)

Theme switch (light/dark):
  Crossfade all backgrounds: 300ms ease
  No jarring flash
```

---

## 13. Empty States

```
Empty state anatomy:
  ┌──────────────────────────────────────────┐
  │                                          │
  │         [Icon — 48px, text400]           │
  │                                          │
  │      No tables in this schema            │  ← titleMedium, text200
  │                                          │
  │   Create your first table to get started │  ← body, text300
  │                                          │
  │         [+ Create Table]                 │  ← primary button (only if action available)
  │                                          │
  └──────────────────────────────────────────┘

Icon: outline style, 48px, text400 (never filled)
Spacing: 16px between elements
Container: centered in parent, max-width 360px
```

Specific empty states:
- **No connections**: Database icon + "Connect to a database" + [+ New Connection]
- **No results**: magnifier icon + "No rows returned" + "Query ran in Xms" (caption)
- **No query history**: clock icon + "Your query history will appear here"
- **ER diagram loading** (no tables): "This schema has no tables"

---

## 14. Theming in Flutter Code

```dart
// lib/ui/theme/app_theme.dart

ThemeData buildDarkTheme() => ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: '.SF Pro Display',
  colorScheme: ColorScheme.dark(
    primary: DBColors.accentBlue,
    surface: DBColors.bg300,
    background: DBColors.bg100,
    error: DBColors.danger,
    onPrimary: Colors.white,
    onSurface: DBColors.text100,
    onBackground: DBColors.text100,
    outline: DBColors.border200,
  ),
  scaffoldBackgroundColor: DBColors.bg100,
  cardColor: DBColors.bg300,
  dividerColor: DBColors.border100,
  
  // Remove all Material ink splash (replace with instant bg change)
  splashFactory: NoSplash.splashFactory,
  highlightColor: Colors.transparent,

  // Scrollbar always thin
  scrollbarTheme: ScrollbarThemeData(
    thickness: MaterialStateProperty.all(4),
    thumbColor: MaterialStateProperty.all(DBColors.border300),
    trackColor: MaterialStateProperty.all(Colors.transparent),
    radius: const Radius.circular(2),
  ),

  // Tooltip
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: DBColors.bg400,
      borderRadius: BorderRadius.circular(DBRadius.xs),
      border: Border.all(color: DBColors.border200),
      boxShadow: DBShadows.menu,
    ),
    textStyle: DBTypography.caption.copyWith(color: DBColors.text200),
    waitDuration: const Duration(milliseconds: 600),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  ),

  extensions: const [DBStudioTheme.dark],
);

// DBStudioTheme extension — all custom tokens
@immutable
class DBStudioTheme extends ThemeExtension<DBStudioTheme> {
  const DBStudioTheme({
    required this.bg100, required this.bg200, required this.bg300,
    required this.border100, required this.border200,
    required this.text300, required this.text400,
    required this.syntaxKeyword, required this.syntaxString,
    // ... all tokens
  });

  static const dark = DBStudioTheme(
    bg100: DBColors.bg100,
    // ...
  );

  static const light = DBStudioTheme(
    bg100: DBColorsLight.bg100,
    // ...
  );
}
```

---

## 15. Responsiveness & Adaptive Layout

```
Window size breakpoints:
  Compact  < 900px  wide: Sidebar collapses to icon rail (48px)
  Regular  900–1400px:    Normal three-pane
  Wide     > 1400px:      Right panel shows by default (properties/history)

Sidebar collapse:
  Icons only mode:
    - DB type icon replaces full connection tile
    - Tooltip on hover shows full name
    - Collapse button: chevron-left at sidebar bottom
  Animation: 220ms spring, sidebar slides left to icon-only width

Minimum window size: 800px × 600px
  Below this: show "Please resize window" overlay (blurred bg, centered message)
```

---

## 16. Accessibility

```
Color contrast:
  text100 on bg100 (dark): 15:1 ✓
  text200 on bg300 (dark): 8:1 ✓
  text300 on bg200 (dark): 4.5:1 ✓ (WCAG AA minimum)
  accentBlue on bg100:     4.6:1 ✓

Focus indicators:
  All interactive elements: 2px accentBlue outline + 2px offset
  Never remove focus ring — only style it

Semantic labels:
  All icon buttons: Semantics(label: 'Close connection')
  Tree nodes: announce type: 'Table: users, 42 columns'
  Data grid: announce sort: 'Sorted by name ascending'

Keyboard navigation:
  Tab order follows visual left-to-right, top-to-bottom
  Tree: arrow keys navigate, Enter expands, Space selects
  Data grid: arrow keys move between cells, Enter edits, Escape cancels
  Context menus: arrow keys, Enter selects, Escape closes
```

---

## 17. Design Checklist for Every Screen

Before a screen is considered done:
- [ ] Consistent with 4px grid (no arbitrary margins)
- [ ] Dark and light mode both tested — no hardcoded colors
- [ ] Loading state designed (skeleton or spinner)
- [ ] Empty state designed
- [ ] Error state designed
- [ ] Hover, focus, active states on all interactive elements
- [ ] Text never clips — ellipsis (`TextOverflow.ellipsis`) on all constrained text
- [ ] No layout overflow (run in debug mode — no yellow stripes)
- [ ] `dart analyze` zero warnings
- [ ] Scrollbar visible when content overflows
- [ ] Right-click (context menu) where appropriate
- [ ] Keyboard shortcut tooltip in context where actions exist
