import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydb/models/connection_profile.dart';
import 'package:mydb/models/database_type.dart';
import 'package:mydb/state/connection_providers.dart';
import 'package:mydb/ui/connections/connection_dialogs.dart';

class ConnectionSidebar extends ConsumerWidget {
  const ConnectionSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ConnectionProfile> profiles =
        ref.watch(savedConnectionProfilesProvider);
    final Set<String> live = ref.watch(liveConnectionsProvider);
    final String? selected = ref.watch(selectedConnectionIdProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Connections',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              IconButton(
                tooltip: 'New connection',
                onPressed: () => showAddConnectionDialog(context, ref),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: FilledButton.tonalIcon(
            onPressed: () => showAddConnectionDialog(context, ref),
            icon: const Icon(Icons.lan_outlined, size: 18),
            label: const Text('Add connection'),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: profiles.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'No saved connections.\nTap Add connection to create one, then connect.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: profiles.length,
                  itemBuilder: (BuildContext context, int i) {
                    final ConnectionProfile p = profiles[i];
                    final bool on = live.contains(p.id);
                    final bool isSel = selected == p.id;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 6),
                      color: isSel
                          ? Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withValues(alpha: 0.35)
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(
                                _iconFor(p.type),
                                size: 22,
                                color: on ? Colors.green : null,
                              ),
                              title: Text(
                                p.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                '${p.type.displayName} · ${p.database}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              trailing: on
                                  ? IconButton(
                                      tooltip: 'Disconnect',
                                      icon: const Icon(Icons.link_off),
                                      onPressed: () async {
                                        await ref
                                            .read(
                                              liveConnectionsProvider.notifier,
                                            )
                                            .disconnect(p.id);
                                        if (selected == p.id) {
                                          ref
                                              .read(
                                                selectedConnectionIdProvider
                                                    .notifier,
                                              )
                                              .select(null);
                                        }
                                      },
                                    )
                                  : IconButton(
                                      tooltip: 'Connect',
                                      icon: const Icon(Icons.link),
                                      onPressed: () => showConnectDialog(
                                        context,
                                        ref,
                                        p,
                                      ),
                                    ),
                            ),
                            Row(
                              children: <Widget>[
                                if (on)
                                  TextButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                            selectedConnectionIdProvider
                                                .notifier,
                                          )
                                          .select(p.id);
                                    },
                                    child: const Text('Use'),
                                  ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () =>
                                      _confirmDelete(context, ref, p, on),
                                  child: Text(
                                    'Remove',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  IconData _iconFor(DatabaseType t) {
    return switch (t) {
      DatabaseType.postgres => Icons.storage,
      DatabaseType.mysql => Icons.dns,
      DatabaseType.sqlite => Icons.insert_drive_file_outlined,
      DatabaseType.mssql => Icons.business,
    };
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    ConnectionProfile p,
    bool wasLive,
  ) async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Remove connection?'),
        content: Text(
          wasLive
              ? 'This will disconnect and remove "${p.name}" from the saved list.'
              : 'Remove "${p.name}" from the saved list?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) {
      return;
    }
    if (wasLive) {
      await ref.read(liveConnectionsProvider.notifier).disconnect(p.id);
    }
    ref.read(savedConnectionProfilesProvider.notifier).remove(p.id);
    final String? sel = ref.read(selectedConnectionIdProvider);
    if (sel == p.id) {
      ref.read(selectedConnectionIdProvider.notifier).select(null);
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Removed "${p.name}"')),
      );
    }
  }
}
