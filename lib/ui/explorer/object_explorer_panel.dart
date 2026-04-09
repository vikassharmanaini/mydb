import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydb/drivers/driver_interface.dart';
import 'package:mydb/models/database_object.dart';
import 'package:mydb/models/database_type.dart';
import 'package:mydb/models/schema_metadata.dart';
import 'package:mydb/state/connection_providers.dart';
import 'package:mydb/state/schema_providers.dart';
import 'package:mydb/ui/schema/ddl_viewer_sheet.dart';

/// Right-hand schema browser for the active connection.
class ObjectExplorerPanel extends ConsumerStatefulWidget {
  const ObjectExplorerPanel({super.key, required this.connectionId});

  final String connectionId;

  @override
  ConsumerState<ObjectExplorerPanel> createState() =>
      _ObjectExplorerPanelState();
}

class _ObjectExplorerPanelState extends ConsumerState<ObjectExplorerPanel> {
  String _filter = '';

  String _tablesKey(String schema) => '${widget.connectionId}|$schema';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AsyncValue<List<SchemaInfo>> schemasAsync =
        ref.watch(explorerSchemasProvider(widget.connectionId));

    return Material(
      color: theme.colorScheme.surfaceContainerHigh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
            child: Text(
              'Objects',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Filter schemas / tables…',
                isDense: true,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.filter_list, size: 20),
              ),
              onChanged: (String v) => setState(() => _filter = v),
            ),
          ),
          const SizedBox(height: 6),
          TextButton.icon(
            onPressed: () {
              ref.read(schemaMetaCacheProvider).clear(widget.connectionId);
              ref.invalidate(explorerSchemasProvider(widget.connectionId));
            },
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Refresh'),
          ),
          Expanded(
            child: schemasAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (Object e, _) => Padding(
                padding: const EdgeInsets.all(8),
                child: Text('$e', style: TextStyle(color: theme.colorScheme.error)),
              ),
              data: (List<SchemaInfo> schemas) {
                final String q = _filter.trim().toLowerCase();
                final List<SchemaInfo> filtered = q.isEmpty
                    ? schemas
                    : schemas
                        .where(
                          (SchemaInfo s) =>
                              s.name.toLowerCase().contains(q),
                        )
                        .toList();
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (BuildContext context, int i) {
                    final SchemaInfo s = filtered[i];
                    return _SchemaTile(
                      connectionId: widget.connectionId,
                      schema: s.name,
                      cacheKey: _tablesKey(s.name),
                      tableFilter: _filter,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SchemaTile extends ConsumerStatefulWidget {
  const _SchemaTile({
    required this.connectionId,
    required this.schema,
    required this.cacheKey,
    required this.tableFilter,
  });

  final String connectionId;
  final String schema;
  final String cacheKey;
  final String tableFilter;

  @override
  ConsumerState<_SchemaTile> createState() => _SchemaTileState();
}

class _SchemaTileState extends ConsumerState<_SchemaTile> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ListTile(
          dense: true,
          leading: Icon(
            _open ? Icons.folder_open : Icons.folder,
            size: 20,
          ),
          title: Text(widget.schema),
          onTap: () => setState(() => _open = !_open),
        ),
        if (_open)
          Consumer(
            builder: (BuildContext context, WidgetRef ref, _) {
              final AsyncValue<List<TableInfo>> tablesAsync =
                  ref.watch(explorerTablesProvider(widget.cacheKey));
              return tablesAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: LinearProgressIndicator(minHeight: 2),
                ),
                error: (Object e, _) => Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text('$e', maxLines: 2),
                ),
                data: (List<TableInfo> tables) {
                  final String q = widget.tableFilter.trim().toLowerCase();
                  final List<TableInfo> shown = q.isEmpty
                      ? tables
                      : tables
                          .where(
                            (TableInfo t) =>
                                t.name.toLowerCase().contains(q) ||
                                widget.schema.toLowerCase().contains(q),
                          )
                          .toList();
                  return Column(
                    children: shown
                        .map(
                          (TableInfo t) => ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.only(left: 36),
                            leading: const Icon(Icons.table_chart, size: 18),
                            title: Text(t.name),
                            onTap: () => _tableMenu(
                              context,
                              ref,
                              t.schema,
                              t.name,
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              );
            },
          ),
      ],
    );
  }

  Future<void> _tableMenu(
    BuildContext context,
    WidgetRef ref,
    String schema,
    String table,
  ) async {
    final DatabaseDriver? driver = ref
        .read(liveConnectionsProvider.notifier)
        .driver(widget.connectionId);
    if (driver == null || !context.mounted) {
      return;
    }
    final String? choice = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copy name'),
              onTap: () => Navigator.pop(ctx, 'copy'),
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('Generate SELECT'),
              onTap: () => Navigator.pop(ctx, 'select'),
            ),
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: const Text('View DDL'),
              onTap: () => Navigator.pop(ctx, 'ddl'),
            ),
          ],
        ),
      ),
    );
    if (!context.mounted || choice == null) {
      return;
    }
    if (choice == 'copy') {
      await Clipboard.setData(ClipboardData(text: table));
    } else if (choice == 'select') {
      final String from = switch (driver.type) {
        DatabaseType.postgres => '"$schema"."$table"',
        DatabaseType.mysql => '`$schema`.`$table`',
        _ => '$schema.$table',
      };
      await Clipboard.setData(
        ClipboardData(text: 'SELECT *\nFROM $from\nLIMIT 500;'),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SELECT copied to clipboard')),
        );
      }
    } else if (choice == 'ddl') {
      final String ddl = await driver.generateDDL(
        DatabaseObject.table(schema: schema, name: table),
      );
      if (context.mounted) {
        await showDdlViewerSheet(context, ddl);
      }
    }
  }
}
