import 'package:flutter/material.dart';
import 'package:mydb/ui/connections/connection_sidebar.dart';

/// Three-pane scaffold: connections sidebar | main content | (optional) right panel.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  static const double _sidebarWidth = 280;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
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
        ],
      ),
    );
  }
}
