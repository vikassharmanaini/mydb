import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mydb/models/result_page.dart';
import 'package:mydb/services/export_service.dart';

Future<void> showExportResultDialog(
  BuildContext context, {
  required List<ResultPage> pages,
}) async {
  const ExportService svc = ExportService();
  await showDialog<void>(
    context: context,
    builder: (BuildContext ctx) => AlertDialog(
      title: const Text('Export results'),
      content: const Text(
        'Export all loaded result rows as CSV (UTF-8).',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            Navigator.pop(ctx);
            final ScaffoldMessengerState? ms =
                ScaffoldMessenger.maybeOf(context);
            final Color errorColor = Theme.of(context).colorScheme.error;
            ms?.showSnackBar(
              const SnackBar(content: Text('Preparing CSV…')),
            );
            try {
              final String csv = await svc.resultPagesToCsv(pages);
              if (!context.mounted) {
                return;
              }
              final String? path = await FilePicker.platform.saveFile(
                dialogTitle: 'Save CSV',
                fileName: 'dbstudio_export.csv',
                type: FileType.custom,
                allowedExtensions: <String>['csv'],
              );
              if (path == null) {
                return;
              }
              final String outPath =
                  path.toLowerCase().endsWith('.csv') ? path : '$path.csv';
              await File(outPath).writeAsString(csv);
              if (!context.mounted) {
                return;
              }
              ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                SnackBar(content: Text('Saved $outPath')),
              );
            } catch (e) {
              if (!context.mounted) {
                return;
              }
              ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                SnackBar(
                  content: Text('Export failed: $e'),
                  backgroundColor: errorColor,
                ),
              );
            }
          },
          child: const Text('Export'),
        ),
      ],
    ),
  );
}
