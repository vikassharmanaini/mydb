# CLAUDE.md — Coding Standards & Agent Instructions: DBStudio

> **Every agent MUST read this file completely before writing a single line of code.**

---

## 1. Project Identity
- **App name:** DBStudio
- **Flutter SDK:** ≥3.22 | **Dart SDK:** ≥3.4
- **Platforms:** Windows, macOS, Linux (desktop only — no mobile)
- **State management:** Riverpod (code-gen only — no `.provider` manually)
- **Architecture:** Feature-first folders, clean layering (see ARCHITECTURE.md)

---

## 2. Non-Negotiable Rules

### 2.1 Never Block the UI Thread
```dart
// ❌ WRONG
final result = driver.executeHeavyQuery();

// ✅ RIGHT
final result = await driver.executeQuery(sql);                // async IO
final layout = await Isolate.run(() => computeForceLayout()); // CPU work
```
- DB calls: always `async/await`
- CPU-heavy work (force layout, export, schema diff): `Isolate.run()`
- Never use `sleep()` or blocking loops anywhere

### 2.2 Virtual Scrolling — Non-Negotiable
The data grid must NEVER render all rows at once.
```dart
// ✅ REQUIRED
TwoDimensionalScrollView(
  delegate: TwoDimensionalChildBuilderDelegate(
    builder: (context, vicinity) => _buildCell(vicinity),
    maxXIndex: columnCount - 1,
    maxYIndex: visibleRowCount - 1,  // only loaded window
  ),
)
```
Page size: 500 rows. Keep 3 pages in memory. Evict on scroll away.

### 2.3 Stream Results — Never Buffer Full Result Set
```dart
// ❌ WRONG
final allRows = await driver.fetchAll(sql);

// ✅ RIGHT
await for (final page in driver.executeQuery(sql)) {
  gridNotifier.appendPage(page);
}
```

### 2.4 No Plaintext Credentials — Ever
```dart
// ❌ WRONG
prefs.setString('password', password);
File('creds.json').writeAsString(jsonEncode({'pw': password}));

// ✅ RIGHT
await credentialService.store(connectionId, password);
// Uses flutter_secure_storage → OS keychain
```

### 2.5 No Business Logic in Widgets
```dart
// ❌ WRONG — logic in widget
class DataGridWidget extends StatefulWidget {
  void _executeQuery() async {
    final conn = await Postgres.connect(...);
    // ...
  }
}

// ✅ RIGHT — delegate to state/service
class DataGridWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(queryStateProvider(tabId));
    return results.when(data: ..., loading: ..., error: ...);
  }
}
```

### 2.6 Plugin-Based Drivers — Registration Only in main.dart
```dart
// ✅ CORRECT — main.dart only
void main() {
  DriverRegistry.register(DatabaseType.postgres, PostgresDriver.new);
  runApp(const ProviderScope(child: DBStudioApp()));
}
// Drivers never reference each other
```

---

## 3. Code Style

### 3.1 File Naming
- `snake_case.dart` for all files
- One public class per file (exception: small related classes may share)
- File name matches primary class name

### 3.2 Class Organization
```dart
class MyClass {
  // 1. Static fields & factory constructors
  // 2. Instance fields (final first)
  // 3. Constructor
  // 4. Lifecycle (initState, dispose)
  // 5. Public methods
  // 6. Private methods
  // 7. build() last (for widgets)
}
```

### 3.3 Prefer `const` Everywhere
```dart
// ✅
const SizedBox(height: 8)
const EdgeInsets.all(16)
const Text('Hello')
```

### 3.4 Error Handling — Always Typed
```dart
// ❌ WRONG
try { ... } catch (e) { print(e); }

// ✅ RIGHT
try { ... }
on SocketException catch (e) { throw ConnectionFailedException(e.message); }
on TimeoutException catch (_) { throw QueryTimeoutException(queryId); }
on Exception catch (e, st) { logger.e('Unexpected', error: e, stackTrace: st); rethrow; }
```

### 3.5 Logging
```dart
// Use the logger package — not print()
final _log = Logger('ClassName');
_log.d('Debug message');
_log.i('Info');
_log.w('Warning');
_log.e('Error', error: e, stackTrace: st);
```

### 3.6 No Magic Numbers — Use Constants
```dart
// ❌ const SizedBox(height: 8) scattered everywhere (ok for spacing)
// ❌ pageSize = 500 hardcoded in 5 places

// ✅
class AppConstants {
  static const int defaultPageSize = 500;
  static const int maxMemoryPages = 3;
  static const Duration queryTimeout = Duration(seconds: 30);
  static const Duration keepalivePing = Duration(seconds: 30);
}
```

---

## 4. Riverpod Patterns

### 4.1 Always Use Code-Gen
```dart
// ✅ REQUIRED
@riverpod
class QueryState extends _$QueryState {
  @override
  AsyncValue<QueryResult?> build(String tabId) => const AsyncValue.data(null);

  Future<void> execute(String sql) async {
    state = const AsyncValue.loading();
    // ...
  }
}
```

### 4.2 Family Providers for Per-Tab / Per-Connection State
```dart
@riverpod
class GridState extends _$GridState {
  @override
  GridModel build(String tabId) => GridModel.empty();
}
// Usage: ref.watch(gridStateProvider('tab-123'))
```

### 4.3 Avoid ref.read in build() — Use ref.watch
```dart
// ❌ ref.read in build causes stale data
// ✅ ref.watch in build, ref.read only in event handlers
```

---

## 5. Performance Mandates

| Requirement | Implementation |
|------------|---------------|
| 60fps grid scroll | Virtual scroll only, RepaintBoundary per row |
| <16ms keystroke latency | `re_editor` handles this; don't rebuild parent on keypress |
| <2s cold start | Lazy-load all drivers, defer metadata fetch |
| <300MB memory | Evict grid pages, dispose unused connections |
| ER layout non-blocking | `Isolate.run()` mandatory |
| Export non-blocking | `Isolate.run()` mandatory |

---

## 6. Testing Standards

### Every Service Method Gets a Unit Test
```dart
test('executeQuery streams pages', () async {
  final driver = MockDatabaseDriver();
  when(() => driver.executeQuery(any())).thenAnswer(
    (_) => Stream.fromIterable([page1, page2]),
  );
  final service = QueryService(driver: driver);
  final pages = await service.execute('SELECT 1').toList();
  expect(pages.length, 2);
});
```

### Widget Tests Must Not Hit Real DB
Use `ProviderScope` with overrides:
```dart
await tester.pumpWidget(
  ProviderScope(
    overrides: [
      queryStateProvider('tab1').overrideWith(() => FakeQueryState()),
    ],
    child: const SQLEditorTab(tabId: 'tab1'),
  ),
);
```

---

## 7. Folder Creation Rule
If a folder doesn't exist in `lib/`, create `lib/folder/.gitkeep` before adding files. Never create files in the root `lib/` except `main.dart` and `app.dart`.

---

## 8. Import Rules
```dart
// Order: dart → flutter → packages → relative (with blank line between groups)
import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:postgres/postgres.dart';

import '../models/query_result.dart';
import 'query_service.dart';
```

---

## 9. Before Submitting Any File — Checklist
- [ ] `dart analyze` shows zero errors and zero warnings
- [ ] `dart format` applied
- [ ] No `print()` statements — use `logger`
- [ ] No hardcoded credentials or test passwords
- [ ] No `TODO` left without a corresponding TASKS.md task ID
- [ ] All async functions have error handling
- [ ] New classes/widgets have a one-line dartdoc comment
- [ ] `build_runner` re-run if any freezed/riverpod file was added or changed

---

## 10. Git Commit Convention
```
feat(drivers): add PostgreSQL connection pool
fix(grid): virtual scroll resets on filter change
test(services): add export service unit tests
refactor(state): simplify query notifier lifecycle
docs: update ARCHITECTURE.md with SSH tunnel flow
```
Scope must be one of: `drivers`, `services`, `state`, `grid`, `editor`, `explorer`, `er`, `schema`, `settings`, `layout`, `models`, `storage`, `tests`.
