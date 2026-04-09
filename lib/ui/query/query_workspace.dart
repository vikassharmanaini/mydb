import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydb/models/app_settings.dart';
import 'package:mydb/models/connection_profile.dart';
import 'package:mydb/models/query_history_entry.dart';
import 'package:mydb/models/result_page.dart';
import 'package:mydb/models/schema_metadata.dart';
import 'package:mydb/models/session_state.dart';
import 'package:mydb/models/snippet.dart';
import 'package:mydb/services/import_service.dart';
import 'package:mydb/services/query_service.dart';
import 'package:mydb/services/schema_compare_service.dart';
import 'package:mydb/services/schema_service.dart';
import 'package:mydb/state/connection_providers.dart';
import 'package:mydb/state/local_storage_providers.dart';
import 'package:mydb/state/query_providers.dart';
import 'package:mydb/state/schema_providers.dart';
import 'package:mydb/state/session_snapshot_controller.dart';
import 'package:mydb/state/settings_controller.dart';
import 'package:mydb/ui/layout/split_pane.dart';
import 'package:mydb/ui/query/export_dialog.dart';
import 'package:mydb/utils/sql_ddl_heuristic.dart';
import 'package:mydb/utils/sql_error_line.dart';
import 'package:mydb/utils/sql_format.dart';
import 'package:mydb/utils/sql_run_policy.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/sql.dart';
import 'package:re_highlight/styles/atom-one-dark.dart';
import 'package:re_highlight/styles/atom-one-light.dart';
import 'package:uuid/uuid.dart';

/// SQL editor, run/cancel, and tabular results for the active connection.
class QueryWorkspace extends ConsumerStatefulWidget {
  const QueryWorkspace({super.key, required this.connectionId});

  final String connectionId;

  @override
  ConsumerState<QueryWorkspace> createState() => _QueryWorkspaceState();
}

class _QueryWorkspaceState extends ConsumerState<QueryWorkspace> {
  static const int _kMaxDisplayRows = 500;
  static const Uuid _uuid = Uuid();

  late final CodeLineEditingController _editorController;
  Timer? _persistDebounce;
  bool _editorListenerAttached = false;

  List<EditorTabSnapshot> _tabs = <EditorTabSnapshot>[];
  int _activeTabIndex = 0;
  bool _tabsHydrated = false;

  bool _running = false;
  String? _error;
  int? _errorLine;
  List<ResultPage> _pages = <ResultPage>[];
  Duration? _lastDuration;

  @override
  void initState() {
    super.initState();
    _editorController = CodeLineEditingController.fromText(
      '-- Press Run or ⌘↵ / Ctrl+↵ to execute\n'
      'SELECT 1 AS one;',
    );
    _tabs = <EditorTabSnapshot>[
      EditorTabSnapshot(
        id: _uuid.v4(),
        connectionId: widget.connectionId,
        sql: _editorController.text,
      ),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_editorListenerAttached) {
      _editorListenerAttached = true;
      unawaited(_hydrateTabsFromSession());
      _editorController.addListener(_schedulePersist);
    }
  }

  Future<void> _hydrateTabsFromSession() async {
    if (!mounted || _tabsHydrated) {
      return;
    }
    try {
      final SessionState s =
          await ref.read(sessionSnapshotControllerProvider.future);
      if (!mounted) {
        return;
      }
      final List<EditorTabSnapshot> mine = s.tabs
          .where((EditorTabSnapshot t) => t.connectionId == widget.connectionId)
          .toList();
      setState(() {
        _tabsHydrated = true;
        if (mine.isNotEmpty) {
          _tabs = List<EditorTabSnapshot>.from(mine);
          int idx = 0;
          if (s.activeTabId != null) {
            final int i =
                _tabs.indexWhere((EditorTabSnapshot t) => t.id == s.activeTabId);
            if (i >= 0) {
              idx = i;
            }
          }
          _activeTabIndex = idx;
          _editorController.text = _tabs[_activeTabIndex].sql;
        } else if (s.scratchConnectionId == widget.connectionId &&
            s.scratchSql.trim().isNotEmpty) {
          _tabs = <EditorTabSnapshot>[
            EditorTabSnapshot(
              id: _uuid.v4(),
              connectionId: widget.connectionId,
              sql: s.scratchSql,
            ),
          ];
          _activeTabIndex = 0;
          _editorController.text = s.scratchSql;
        }
      });
    } catch (_) {
      if (mounted) {
        setState(() => _tabsHydrated = true);
      }
    }
  }

  void _flushActiveSqlIntoTabs() {
    if (_tabs.isEmpty) {
      return;
    }
    final EditorTabSnapshot cur = _tabs[_activeTabIndex];
    _tabs[_activeTabIndex] = EditorTabSnapshot(
      id: cur.id,
      connectionId: widget.connectionId,
      sql: _editorController.text,
    );
  }

  void _schedulePersist() {
    _flushActiveSqlIntoTabs();
    _persistDebounce?.cancel();
    _persistDebounce = Timer(const Duration(milliseconds: 700), () {
      if (!mounted || _tabs.isEmpty) {
        return;
      }
      unawaited(
        ref.read(sessionSnapshotControllerProvider.notifier).mergeConnectionEditorTabs(
              connectionId: widget.connectionId,
              tabs: List<EditorTabSnapshot>.from(_tabs),
              activeTabId: _tabs[_activeTabIndex].id,
              scratchSql: _editorController.text,
            ),
      );
    });
  }

  void _selectTab(int i) {
    if (i < 0 || i >= _tabs.length || i == _activeTabIndex) {
      return;
    }
    setState(() {
      _flushActiveSqlIntoTabs();
      _activeTabIndex = i;
      _editorController.text = _tabs[i].sql;
    });
  }

  void _addTab() {
    setState(() {
      _flushActiveSqlIntoTabs();
      _tabs.add(
        EditorTabSnapshot(
          id: _uuid.v4(),
          connectionId: widget.connectionId,
          sql: '',
        ),
      );
      _activeTabIndex = _tabs.length - 1;
      _editorController.text = '';
    });
    _schedulePersist();
  }

  void _removeTab(int i) {
    if (_tabs.length <= 1) {
      return;
    }
    setState(() {
      if (i == _activeTabIndex) {
        _flushActiveSqlIntoTabs();
      }
      _tabs.removeAt(i);
      if (_activeTabIndex >= _tabs.length) {
        _activeTabIndex = _tabs.length - 1;
      }
      _editorController.text = _tabs[_activeTabIndex].sql;
    });
    _schedulePersist();
  }

  void _insertKeyword(String w) {
    final String t = _editorController.text;
    final String spacer = t.isEmpty || t.endsWith('\n') || t.endsWith(' ') ? '' : ' ';
    _editorController.text = '$t$spacer$w ';
    _schedulePersist();
  }

  void _maybeInvalidateSchemaCache(String sql) {
    if (!sqlLooksLikeDdl(sql)) {
      return;
    }
    ref.read(schemaMetaCacheProvider).clear(widget.connectionId);
    ref.invalidate(explorerSchemasProvider(widget.connectionId));
  }

  Future<void> _run(QueryService svc, {required bool forceUpdate}) async {
    final String sql = _editorController.text.trim();
    if (sql.isEmpty) {
      return;
    }
    if (sqlLooksLikeMultipleStatements(sql)) {
      setState(() {
        _error =
            'Run one statement at a time. Remove extra semicolons or split into separate runs.';
        _errorLine = null;
      });
      return;
    }
    setState(() {
      _running = true;
      _error = null;
      _errorLine = null;
      _pages = <ResultPage>[];
      _lastDuration = null;
    });
    try {
      if (forceUpdate || sqlPrefersExecuteUpdate(sql)) {
        final Stopwatch sw = Stopwatch()..start();
        final int n = await svc.executeUpdate(sql);
        sw.stop();
        if (!mounted) {
          return;
        }
        _maybeInvalidateSchemaCache(sql);
        setState(() {
          _pages = <ResultPage>[
            ResultPage(
              pageIndex: 0,
              pageSize: 1,
              columns: <String>['status'],
              rows: <List<dynamic>>[
                <dynamic>['$n row(s) affected'],
              ],
              totalRows: 1,
              queryDuration: sw.elapsed,
            ),
          ];
          _lastDuration = sw.elapsed;
        });
        return;
      }
      final List<ResultPage> collected = <ResultPage>[];
      await for (final ResultPage page in svc.executeQuery(sql)) {
        collected.add(page);
        if (mounted) {
          setState(() {
            _pages = List<ResultPage>.from(collected);
            _lastDuration = page.queryDuration;
          });
        }
      }
    } catch (e, st) {
      if (mounted) {
        setState(() {
          _error = '$e';
          _errorLine = parseSqlErrorLine('$e');
        });
      }
      debugPrint('Query error: $e\n$st');
    } finally {
      if (mounted) {
        setState(() => _running = false);
      }
    }
  }

  Future<void> _runExplain(QueryService svc) async {
    final String sql = _editorController.text.trim();
    if (sql.isEmpty) {
      return;
    }
    if (sqlLooksLikeMultipleStatements(sql)) {
      setState(() => _error = 'Explain one statement at a time.');
      return;
    }
    final String upper = sql.toUpperCase();
    final String explainSql =
        upper.startsWith('EXPLAIN') ? sql : 'EXPLAIN $sql';
    setState(() {
      _running = true;
      _error = null;
      _errorLine = null;
      _pages = <ResultPage>[];
    });
    try {
      final List<ResultPage> collected = <ResultPage>[];
      await for (final ResultPage page in svc.executeQuery(explainSql)) {
        collected.add(page);
        if (mounted) {
          setState(() {
            _pages = List<ResultPage>.from(collected);
            _lastDuration = page.queryDuration;
          });
        }
      }
    } catch (e, st) {
      if (mounted) {
        setState(() {
          _error = '$e';
          _errorLine = parseSqlErrorLine('$e');
        });
      }
      debugPrint('Explain error: $e\n$st');
    } finally {
      if (mounted) {
        setState(() => _running = false);
      }
    }
  }

  Future<void> _cancel(QueryService svc) async {
    await svc.cancelCurrentQuery();
  }

  void _triggerRun() {
    if (_running) {
      return;
    }
    final QueryService? svc =
        ref.read(queryServiceForProvider(widget.connectionId)).valueOrNull;
    if (svc != null) {
      unawaited(_run(svc, forceUpdate: false));
    }
  }

  Future<void> _showHistoryPanel() async {
    final db = await ref.read(appDatabaseProvider.future);
    final List<QueryHistoryEntry> rows = await db.historyDao.listRecent(
      connectionId: widget.connectionId,
      limit: 80,
    );
    if (!mounted) {
      return;
    }
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55,
        minChildSize: 0.3,
        maxChildSize: 0.95,
        builder: (_, ScrollController sc) => Column(
          children: <Widget>[
            const ListTile(title: Text('Query history')),
            Expanded(
              child: ListView.builder(
                controller: sc,
                itemCount: rows.length,
                itemBuilder: (BuildContext c, int i) {
                  final QueryHistoryEntry e = rows[i];
                  return ListTile(
                    title: Text(
                      e.sql.length > 120 ? '${e.sql.substring(0, 120)}…' : e.sql,
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                    subtitle: Text(
                      '${e.executedAt.toLocal()} · ${e.durationMs ?? '?'} ms · ${e.success ? 'ok' : 'fail'}',
                    ),
                    onTap: () {
                      _editorController.text = e.sql;
                      Navigator.pop(ctx);
                      _schedulePersist();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSnippetsPanel() async {
    final db = await ref.read(appDatabaseProvider.future);
    final List<Snippet> rows = await db.snippetDao.listAll();
    if (!mounted) {
      return;
    }
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55,
        minChildSize: 0.3,
        maxChildSize: 0.95,
        builder: (_, ScrollController sc) => Column(
          children: <Widget>[
            const ListTile(title: Text('Snippets')),
            Expanded(
              child: ListView.builder(
                controller: sc,
                itemCount: rows.length,
                itemBuilder: (BuildContext c, int i) {
                  final Snippet s = rows[i];
                  return ListTile(
                    title: Text(s.title),
                    subtitle: Text(
                      s.sql.length > 100 ? '${s.sql.substring(0, 100)}…' : s.sql,
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                    ),
                    onTap: () {
                      _editorController.text = s.sql;
                      Navigator.pop(ctx);
                      _schedulePersist();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showImportWizard() async {
    final TextEditingController t = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Import CSV (preview)'),
        content: SizedBox(
          width: 480,
          height: 200,
          child: TextField(
            controller: t,
            maxLines: null,
            expands: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Paste CSV (first row = headers)',
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
          FilledButton(
            onPressed: () {
              final List<List<String>> data =
                  const ImportService().parseCsv(t.text, hasHeader: true);
              Navigator.pop(ctx);
              showDialog<void>(
                context: context,
                builder: (BuildContext c2) => AlertDialog(
                  title: Text('${data.length} data rows'),
                  content: SizedBox(
                    width: 400,
                    height: 200,
                    child: SingleChildScrollView(
                      child: Text(
                        data.take(12).map((List<String> r) => r.join(' | ')).join('\n'),
                        style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(onPressed: () => Navigator.pop(c2), child: const Text('OK')),
                  ],
                ),
              );
            },
            child: const Text('Parse'),
          ),
        ],
      ),
    );
    t.dispose();
  }

  Future<void> _showSchemaCompare() async {
    final BuildContext rootContext = context;
    final AsyncValue<List<SchemaInfo>> schemas =
        ref.read(explorerSchemasProvider(widget.connectionId));
    final List<SchemaInfo>? list = schemas.asData?.value;
    if (list == null || list.length < 2) {
      ScaffoldMessenger.of(rootContext).showSnackBar(
        const SnackBar(content: Text('Need at least two schemas (refresh explorer).')),
      );
      return;
    }
    String a = list.first.name;
    String b = list[1].name;
    if (!mounted) {
      return;
    }
    await showDialog<void>(
      context: rootContext,
      builder: (BuildContext ctx) => StatefulBuilder(
        builder: (BuildContext c, void Function(void Function()) setD) {
          return AlertDialog(
            title: const Text('Compare table names'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DropdownButtonFormField<String>(
                  value: a,
                  items: list
                      .map(
                        (SchemaInfo s) => DropdownMenuItem<String>(
                          value: s.name,
                          child: Text(s.name),
                        ),
                      )
                      .toList(),
                  onChanged: (String? v) => setD(() => a = v ?? a),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: b,
                  items: list
                      .map(
                        (SchemaInfo s) => DropdownMenuItem<String>(
                          value: s.name,
                          child: Text(s.name),
                        ),
                      )
                      .toList(),
                  onChanged: (String? v) => setD(() => b = v ?? b),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
              FilledButton(
                onPressed: () async {
                  final SchemaService svc = ref.read(schemaServiceProvider);
                  final List<TableInfo> ta =
                      await svc.listTables(widget.connectionId, a);
                  final List<TableInfo> tb =
                      await svc.listTables(widget.connectionId, b);
                  if (!rootContext.mounted) {
                    return;
                  }
                  final String diff =
                      const SchemaCompareService().diffTableNames(ta, tb);
                  Navigator.pop(ctx);
                  if (!rootContext.mounted) {
                    return;
                  }
                  await showDialog<void>(
                    context: rootContext,
                    builder: (BuildContext c2) => AlertDialog(
                      title: const Text('Schema diff'),
                      content: SizedBox(
                        width: 420,
                        height: 320,
                        child: SingleChildScrollView(child: SelectableText(diff)),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(c2),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Compare'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showErPlaceholder() {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('ER diagram'),
        content: const Text(
          'Entity–relationship canvas is a later milestone. '
          'Use the object explorer and schema compare for navigation.',
        ),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _persistDebounce?.cancel();
    if (_editorListenerAttached) {
      _editorController.removeListener(_schedulePersist);
    }
    _editorController.dispose();
    super.dispose();
  }

  String _profileName(List<ConnectionProfile> profiles) {
    for (final ConnectionProfile p in profiles) {
      if (p.id == widget.connectionId) {
        return p.name;
      }
    }
    return 'Connection';
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AsyncValue<List<ConnectionProfile>> profilesAsync =
        ref.watch(savedConnectionProfilesProvider);
    final AsyncValue<QueryService?> svcAsync =
        ref.watch(queryServiceForProvider(widget.connectionId));
    final AsyncValue<AppSettings> settingsAsync =
        ref.watch(appSettingsControllerProvider);

    final String title = profilesAsync.maybeWhen(
      data: _profileName,
      orElse: () => '…',
    );

    final double editorFont = settingsAsync.maybeWhen(
      data: (AppSettings s) => s.editorFontSize,
      orElse: () => 14.0,
    );
    final bool wordWrap = settingsAsync.maybeWhen(
      data: (AppSettings s) => s.editorLineWrap,
      orElse: () => false,
    );
    final String nullLabel = settingsAsync.maybeWhen(
      data: (AppSettings s) => s.gridNullDisplay,
      orElse: () => 'NULL',
    );
    final bool showHints = settingsAsync.maybeWhen(
      data: (AppSettings s) => s.showKeyboardShortcutHints,
      orElse: () => true,
    );
    final bool wantAutocomplete = settingsAsync.maybeWhen(
      data: (AppSettings s) => s.editorAutocomplete,
      orElse: () => true,
    );

    final AsyncValue<List<String>> keywordsAsync =
        ref.watch(schemaKeywordsProvider(widget.connectionId));

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.enter, meta: true): _triggerRun,
        const SingleActivator(LogicalKeyboardKey.enter, control: true): _triggerRun,
      },
      child: Focus(
        autofocus: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Material(
              color: theme.colorScheme.surfaceContainerHigh,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'SQL',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                title,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          FilledButton.tonalIcon(
                            onPressed: _running ? null : _triggerRun,
                            icon: const Icon(Icons.play_arrow, size: 20),
                            label: const Text('Run'),
                          ),
                          IconButton(
                            tooltip: showHints ? 'Execute as update (⌘ not bound)' : null,
                            onPressed: _running
                                ? null
                                : () {
                                    final QueryService? svc = ref
                                        .read(queryServiceForProvider(
                                            widget.connectionId))
                                        .valueOrNull;
                                    if (svc != null) {
                                      unawaited(_run(svc, forceUpdate: true));
                                    }
                                  },
                            icon: const Icon(Icons.edit_note_outlined),
                          ),
                          IconButton(
                            tooltip: 'Format SQL',
                            onPressed: () {
                              _editorController.text =
                                  formatSqlNaive(_editorController.text);
                              _schedulePersist();
                            },
                            icon: const Icon(Icons.auto_fix_high_outlined),
                          ),
                          IconButton(
                            tooltip: 'EXPLAIN',
                            onPressed: _running
                                ? null
                                : () {
                                    final QueryService? svc = ref
                                        .read(queryServiceForProvider(
                                            widget.connectionId))
                                        .valueOrNull;
                                    if (svc != null) {
                                      unawaited(_runExplain(svc));
                                    }
                                  },
                            icon: const Icon(Icons.account_tree_outlined),
                          ),
                          IconButton(
                            tooltip: 'History',
                            onPressed: () => unawaited(_showHistoryPanel()),
                            icon: const Icon(Icons.history),
                          ),
                          IconButton(
                            tooltip: 'Snippets',
                            onPressed: () => unawaited(_showSnippetsPanel()),
                            icon: const Icon(Icons.snippet_folder_outlined),
                          ),
                          IconButton(
                            tooltip: 'Import CSV',
                            onPressed: () => unawaited(_showImportWizard()),
                            icon: const Icon(Icons.upload_file_outlined),
                          ),
                          IconButton(
                            tooltip: 'Schema compare',
                            onPressed: () => unawaited(_showSchemaCompare()),
                            icon: const Icon(Icons.compare_arrows_outlined),
                          ),
                          IconButton(
                            tooltip: 'ER diagram (placeholder)',
                            onPressed: _showErPlaceholder,
                            icon: const Icon(Icons.hub_outlined),
                          ),
                          IconButton(
                            tooltip: 'Cancel query',
                            onPressed: !_running
                                ? null
                                : () {
                                    final QueryService? svc = ref
                                        .read(queryServiceForProvider(
                                            widget.connectionId))
                                        .valueOrNull;
                                    if (svc != null) {
                                      unawaited(_cancel(svc));
                                    }
                                  },
                            icon: const Icon(Icons.stop_outlined),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          for (int i = 0; i < _tabs.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: InputChip(
                                label: Text('Query ${i + 1}'),
                                selected: i == _activeTabIndex,
                                onPressed: () => _selectTab(i),
                                deleteIcon: _tabs.length > 1
                                    ? const Icon(Icons.close, size: 16)
                                    : null,
                                onDeleted: _tabs.length > 1
                                    ? () => _removeTab(i)
                                    : null,
                              ),
                            ),
                          IconButton(
                            tooltip: 'New tab',
                            icon: const Icon(Icons.add, size: 20),
                            onPressed: _addTab,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_errorLine != null)
              Material(
                color: theme.colorScheme.errorContainer,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    'Last error referenced line $_errorLine',
                    style: TextStyle(color: theme.colorScheme.onErrorContainer),
                  ),
                ),
              ),
            Expanded(
              child: VerticalSplitPane(
                top: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      if (wantAutocomplete)
                        SizedBox(
                          height: 36,
                          child: keywordsAsync.when(
                            data: (List<String> kws) {
                              if (kws.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: kws.length.clamp(0, 40),
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 4),
                                itemBuilder: (BuildContext c, int i) {
                                  return ActionChip(
                                    label: Text(
                                      kws[i],
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                    onPressed: () => _insertKeyword(kws[i]),
                                  );
                                },
                              );
                            },
                            loading: () => const SizedBox.shrink(),
                            error: (_, __) => const SizedBox.shrink(),
                          ),
                        ),
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.dividerColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CodeEditor(
                              controller: _editorController,
                              chunkAnalyzer: const NonCodeChunkAnalyzer(),
                              wordWrap: wordWrap,
                              style: _editorStyle(context, editorFont),
                              indicatorBuilder:
                                  (BuildContext context,
                                      CodeLineEditingController ed,
                                      CodeChunkController chunk,
                                      CodeIndicatorValueNotifier notifier) {
                                return DefaultCodeLineNumber(
                                  controller: ed,
                                  notifier: notifier,
                                );
                              },
                              sperator: Container(
                                width: 1,
                                color: theme.dividerColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                  child: svcAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (Object e, StackTrace _) => Center(
                      child: Text(
                        'Query service error: $e',
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    ),
                    data: (QueryService? svc) {
                      if (svc == null) {
                        return Center(
                          child: Text(
                            'Connection is not active.',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        );
                      }
                      return _ResultPanel(
                        pages: _pages,
                        error: _error,
                        lastDuration: _lastDuration,
                        maxRows: _kMaxDisplayRows,
                        nullLabel: nullLabel,
                        onExport: _pages.isEmpty
                            ? null
                            : () => showExportResultDialog(
                                  context,
                                  pages: _pages,
                                ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CodeEditorStyle _editorStyle(BuildContext context, double fontSize) {
    final ThemeData theme = Theme.of(context);
    final bool dark = theme.brightness == Brightness.dark;
    return CodeEditorStyle(
      fontSize: fontSize,
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      textColor: theme.colorScheme.onSurface,
      cursorColor: theme.colorScheme.primary,
      selectionColor:
          theme.colorScheme.primary.withValues(alpha: 0.25),
      codeTheme: CodeHighlightTheme(
        languages: <String, CodeHighlightThemeMode>{
          'sql': CodeHighlightThemeMode(mode: langSql),
        },
        theme: dark ? atomOneDarkTheme : atomOneLightTheme,
      ),
    );
  }
}

class _ResultPanel extends StatefulWidget {
  const _ResultPanel({
    required this.pages,
    required this.error,
    required this.lastDuration,
    required this.maxRows,
    required this.nullLabel,
    this.onExport,
  });

  final List<ResultPage> pages;
  final String? error;
  final Duration? lastDuration;
  final int maxRows;
  final String nullLabel;
  final VoidCallback? onExport;

  @override
  State<_ResultPanel> createState() => _ResultPanelState();
}

class _ResultPanelState extends State<_ResultPanel> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  static const double _cellWidth = 112;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (widget.error != null) {
      return ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          SelectableText(
            widget.error!,
            style: TextStyle(
              color: theme.colorScheme.error,
              fontFamily: 'monospace',
              fontSize: 13,
            ),
          ),
        ],
      );
    }

    if (widget.pages.isEmpty) {
      return Center(
        child: Text(
          'Run a query to see results here.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    final List<String> columns = widget.pages.first.columns;
    final List<List<dynamic>> rows = <List<dynamic>>[];
    for (final ResultPage p in widget.pages) {
      rows.addAll(p.rows);
    }

    final int total = rows.length;
    final int shown = total > widget.maxRows ? widget.maxRows : total;
    final List<List<dynamic>> slice = rows.sublist(0, shown);

    final List<int> order = List<int>.generate(slice.length, (int i) => i);
    final int? sc = _sortColumnIndex;
    if (sc != null && sc >= 0 && sc < columns.length) {
      order.sort((int ai, int bi) {
        final Object? av =
            ai < slice.length && sc < slice[ai].length ? slice[ai][sc] : null;
        final Object? bv =
            bi < slice.length && sc < slice[bi].length ? slice[bi][sc] : null;
        int cmp;
        if (av == null && bv == null) {
          cmp = 0;
        } else if (av == null) {
          cmp = 1;
        } else if (bv == null) {
          cmp = -1;
        } else {
          cmp = av.toString().compareTo(bv.toString());
        }
        return _sortAscending ? cmp : -cmp;
      });
    }

    String cellText(Object? v) {
      if (v == null) {
        return widget.nullLabel;
      }
      return v.toString();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '$total row${total == 1 ? '' : 's'}'
                  '${total > widget.maxRows ? ' (showing first ${widget.maxRows})' : ''}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              if (widget.lastDuration != null)
                Text(
                  '${widget.lastDuration!.inMilliseconds} ms',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              if (widget.onExport != null) ...<Widget>[
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Export CSV',
                  icon: const Icon(Icons.save_alt_outlined, size: 20),
                  onPressed: widget.onExport,
                ),
              ],
            ],
          ),
        ),
        Expanded(
          child: Scrollbar(
            thumbVisibility: true,
            child: ListView(
              primary: false,
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          for (int ci = 0; ci < columns.length; ci++)
                            SizedBox(
                              width: _cellWidth,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_sortColumnIndex == ci) {
                                      _sortAscending = !_sortAscending;
                                    } else {
                                      _sortColumnIndex = ci;
                                      _sortAscending = true;
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Text(
                                    columns[ci],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.primary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(width: 40),
                        ],
                      ),
                      const Divider(height: 1),
                      SizedBox(
                        height: (shown * 28.0).clamp(28, 4000),
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: shown,
                          itemBuilder: (BuildContext c, int ii) {
                            final int ri = order[ii];
                            final List<dynamic> r = slice[ri];
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                for (int ci = 0; ci < columns.length; ci++)
                                  SizedBox(
                                    width: _cellWidth,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 2,
                                      ),
                                      child: SelectableText(
                                        ci < r.length ? cellText(r[ci]) : '',
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 11,
                                          color: ci < r.length && r[ci] == null
                                              ? theme.colorScheme.onSurfaceVariant
                                              : null,
                                          fontStyle: ci < r.length &&
                                                  r[ci] == null
                                              ? FontStyle.italic
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  width: 36,
                                  child: PopupMenuButton<String>(
                                    icon: const Icon(Icons.more_vert, size: 18),
                                    onSelected: (String v) {
                                      if (v == 'update') {
                                        _showUpdateTemplate(
                                          context,
                                          columns,
                                          r,
                                        );
                                      }
                                    },
                                    itemBuilder: (BuildContext ctx) =>
                                        <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'update',
                                        child: Text('UPDATE template…'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showUpdateTemplate(
    BuildContext context,
    List<String> cols,
    List<dynamic> row,
  ) {
    final TextEditingController tableCtl =
        TextEditingController(text: 'my_table');
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('UPDATE template'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: tableCtl,
              decoration: const InputDecoration(
                labelText: 'Table name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Generated SQL uses string literals; adjust types and add a real WHERE clause.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final String t = tableCtl.text.trim();
              final StringBuffer sb = StringBuffer('UPDATE $t SET\n');
              final int n = cols.length < row.length ? cols.length : row.length;
              for (int i = 0; i < n; i++) {
                if (i > 0) {
                  sb.writeln(',');
                }
                final Object? v = row[i];
                final String lit = v == null
                    ? 'NULL'
                    : "'${v.toString().replaceAll("'", "''")}'";
                sb.write('  ${cols[i]} = $lit');
              }
              sb.writeln('\nWHERE /* primary key */ true;');
              Clipboard.setData(ClipboardData(text: sb.toString()));
              Navigator.pop(ctx);
              ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                const SnackBar(content: Text('UPDATE SQL copied to clipboard')),
              );
            },
            child: const Text('Copy SQL'),
          ),
        ],
      ),
    ).then((void _) => tableCtl.dispose());
  }
}
