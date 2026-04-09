import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydb/models/connection_profile.dart';
import 'package:mydb/models/result_page.dart';
import 'package:mydb/services/query_service.dart';
import 'package:mydb/state/connection_providers.dart';
import 'package:mydb/state/query_providers.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/sql.dart';
import 'package:re_highlight/styles/atom-one-dark.dart';
import 'package:re_highlight/styles/atom-one-light.dart';

/// SQL editor, run/cancel, and tabular results for the active connection.
class QueryWorkspace extends ConsumerStatefulWidget {
  const QueryWorkspace({super.key, required this.connectionId});

  final String connectionId;

  @override
  ConsumerState<QueryWorkspace> createState() => _QueryWorkspaceState();
}

class _QueryWorkspaceState extends ConsumerState<QueryWorkspace> {
  static const int _kMaxDisplayRows = 500;

  late final CodeLineEditingController _editorController;

  bool _running = false;
  String? _error;
  List<ResultPage> _pages = <ResultPage>[];
  Duration? _lastDuration;

  @override
  void initState() {
    super.initState();
    _editorController = CodeLineEditingController.fromText(
      '-- Press Run or ⌘↵ / Ctrl+↵ to execute\n'
      'SELECT 1 AS one;',
    );
  }

  @override
  void dispose() {
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

  Future<void> _run(QueryService svc) async {
    final String sql = _editorController.text.trim();
    if (sql.isEmpty) {
      return;
    }
    setState(() {
      _running = true;
      _error = null;
      _pages = <ResultPage>[];
      _lastDuration = null;
    });
    try {
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
        });
      }
      debugPrint('Query error: $e\n$st');
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
      unawaited(_run(svc));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AsyncValue<List<ConnectionProfile>> profilesAsync =
        ref.watch(savedConnectionProfilesProvider);
    final AsyncValue<QueryService?> svcAsync =
        ref.watch(queryServiceForProvider(widget.connectionId));

    final String title = profilesAsync.maybeWhen(
      data: _profileName,
      orElse: () => '…',
    );

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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
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
                    ),
                    FilledButton.tonalIcon(
                      onPressed: _running ? null : _triggerRun,
                      icon: const Icon(Icons.play_arrow, size: 20),
                      label: const Text('Run'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
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
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(12),
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
                      wordWrap: true,
                      style: _editorStyle(context),
                      indicatorBuilder:
                          (BuildContext context, CodeLineEditingController ed,
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
            ),
            const Divider(height: 1),
            Expanded(
              flex: 4,
              child: svcAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  CodeEditorStyle _editorStyle(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool dark = theme.brightness == Brightness.dark;
    return CodeEditorStyle(
      fontSize: 14,
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

class _ResultPanel extends StatelessWidget {
  const _ResultPanel({
    required this.pages,
    required this.error,
    required this.lastDuration,
    required this.maxRows,
  });

  final List<ResultPage> pages;
  final String? error;
  final Duration? lastDuration;
  final int maxRows;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (error != null) {
      return ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          SelectableText(
            error!,
            style: TextStyle(
              color: theme.colorScheme.error,
              fontFamily: 'monospace',
              fontSize: 13,
            ),
          ),
        ],
      );
    }

    if (pages.isEmpty) {
      return Center(
        child: Text(
          'Run a query to see results here.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    final List<String> columns = pages.first.columns;
    final List<List<dynamic>> rows = <List<dynamic>>[];
    for (final ResultPage p in pages) {
      rows.addAll(p.rows);
    }

    final int total = rows.length;
    final int shown = total > maxRows ? maxRows : total;
    final List<List<dynamic>> slice = rows.sublist(0, shown);

    String cellText(Object? v) {
      if (v == null) {
        return 'NULL';
      }
      return v.toString();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
          child: Row(
            children: <Widget>[
              Text(
                '$total row${total == 1 ? '' : 's'}'
                '${total > maxRows ? ' (showing first $maxRows)' : ''}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              if (lastDuration != null) ...<Widget>[
                const Text(' · '),
                Text(
                  '${lastDuration!.inMilliseconds} ms',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        Expanded(
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStatePropertyAll<Color>(
                    theme.colorScheme.surfaceContainerHigh,
                  ),
                  columns: <DataColumn>[
                    for (final String c in columns)
                      DataColumn(
                        label: Text(
                          c,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                  rows: <DataRow>[
                    for (final List<dynamic> r in slice)
                      DataRow(
                        cells: <DataCell>[
                          for (int i = 0; i < columns.length; i++)
                            DataCell(
                              SelectableText(
                                i < r.length ? cellText(r[i]) : '',
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                  color: i < r.length && r[i] == null
                                      ? theme.colorScheme.onSurfaceVariant
                                      : null,
                                  fontStyle: i < r.length && r[i] == null
                                      ? FontStyle.italic
                                      : null,
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
