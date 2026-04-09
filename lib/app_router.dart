import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mydb/models/connection_profile.dart';
import 'package:mydb/state/connection_providers.dart';
import 'package:mydb/ui/layout/app_shell.dart';
import 'package:mydb/ui/query/query_workspace.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return AppShell(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const _HomeBody();
            },
          ),
        ],
      ),
    ],
  );
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? sel = ref.watch(selectedConnectionIdProvider);
    final AsyncValue<List<ConnectionProfile>> profilesAsync =
        ref.watch(savedConnectionProfilesProvider);
    final Set<String> live = ref.watch(liveConnectionsProvider);
    final bool connected = sel != null && live.contains(sel);

    return profilesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object e, StackTrace _) => Center(
        child: Text(
          'Connection list error: $e',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ),
      data: (List<ConnectionProfile> profiles) {
        String? name;
        if (sel != null) {
          for (final ConnectionProfile p in profiles) {
            if (p.id == sel) {
              name = p.name;
              break;
            }
          }
        }
        if (sel == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'DBStudio',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  'Add or select a connection in the sidebar to get started.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        if (!connected) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'DBStudio',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  name != null
                      ? '"$name" is selected but not connected.\nConnect from the sidebar.'
                      : 'Connect from the sidebar to run queries.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        return QueryWorkspace(
          key: ValueKey<String>(sel),
          connectionId: sel,
        );
      },
    );
  }
}
