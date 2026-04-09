import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydb/state/connection_providers.dart';
import 'package:mydb/ui/connections/connection_sidebar.dart';
import 'package:mydb/ui/explorer/object_explorer_panel.dart';

/// Three-pane scaffold: connections sidebar | main content | optional explorer.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  static const double _sidebarWidth = 280;
  static const double _explorerWidth = 240;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final String? sel = ref.watch(selectedConnectionIdProvider);
    final Set<String> live = ref.watch(liveConnectionsProvider);

    return Scaffold(
      body: Row(
        children: <Widget>[
          SizedBox(
            width: _sidebarWidth,
            child: Material(
              color: scheme.surfaceContainerHighest,
              child: const ConnectionSidebar(),
            ),
          ),
          Expanded(
            child: ColoredBox(
              color: scheme.surface,
              child: child,
            ),
          ),
          if (sel != null && live.contains(sel))
            SizedBox(
              width: _explorerWidth,
              child: ObjectExplorerPanel(connectionId: sel),
            ),
        ],
      ),
    );
  }
}
