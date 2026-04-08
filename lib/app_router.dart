import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'DBStudio',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
