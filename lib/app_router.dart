import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mydb/state/connection_providers.dart';
import 'package:mydb/ui/layout/app_shell.dart';
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
    final profiles = ref.watch(savedConnectionProfilesProvider);
    final live = ref.watch(liveConnectionsProvider);
    String? activeName;
    if (sel != null) {
      for (final p in profiles) {
        if (p.id == sel) {
          activeName = p.name;
          break;
        }
      }
    }
    final bool connected = sel != null && live.contains(sel);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'DBStudio',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          if (activeName != null)
            Text(
              connected
                  ? 'Active: $activeName'
                  : 'Selected: $activeName (not connected)',
              style: Theme.of(context).textTheme.titleMedium,
            )
          else
            Text(
              'Add a connection in the sidebar to get started.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
        ],
      ),
    );
  }
}
