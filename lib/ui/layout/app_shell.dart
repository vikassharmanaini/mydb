import 'package:flutter/material.dart';

/// Three-pane scaffold: connections sidebar | main content | (optional) right panel.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  static const double _sidebarWidth = 260;

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
              child: const _SidebarPlaceholder(),
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

class _SidebarPlaceholder extends StatelessWidget {
  const _SidebarPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Connections',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 12),
          Text(
            'No connections yet.\nUse File → New connection when wired.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}
