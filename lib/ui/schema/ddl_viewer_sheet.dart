import 'package:flutter/material.dart';

Future<void> showDdlViewerSheet(BuildContext context, String ddl) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext ctx) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (_, ScrollController sc) {
        final ThemeData theme = Theme.of(ctx);
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  Text('DDL', style: theme.textTheme.titleMedium),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Scrollbar(
                controller: sc,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: sc,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: SelectableText(
                    ddl,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      height: 1.4,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}
