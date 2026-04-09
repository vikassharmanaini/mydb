import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mydb/models/result_page.dart';
import 'package:mydb/services/export_service.dart';

/// Confirms export, shows progress, then opens the system save dialog.
///
/// On macOS, [FilePicker.saveFile] requires the **User Selected File (read-write)**
/// entitlement (`com.apple.security.files.user-selected.read-write`) when the app
/// uses the sandbox — see `macos/Runner/*.entitlements`.
Future<void> showExportResultDialog(
  BuildContext context, {
  required List<ResultPage> pages,
}) async {
  final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(context);
  final Color errorColor = Theme.of(context).colorScheme.error;

  await showDialog<void>(
    context: context,
    useRootNavigator: true,
    builder: (BuildContext dialogContext) => _ExportCsvDialog(
      pages: pages,
      scaffoldMessenger: messenger,
      errorColor: errorColor,
    ),
  );
}

class _ExportCsvDialog extends StatefulWidget {
  const _ExportCsvDialog({
    required this.pages,
    required this.scaffoldMessenger,
    required this.errorColor,
  });

  final List<ResultPage> pages;
  final ScaffoldMessengerState? scaffoldMessenger;
  final Color errorColor;

  @override
  State<_ExportCsvDialog> createState() => _ExportCsvDialogState();
}

class _ExportCsvDialogState extends State<_ExportCsvDialog> {
  bool _busy = false;
  String? _error;

  void _toast(String message, {Color? backgroundColor}) {
    final ScaffoldMessengerState? m = widget.scaffoldMessenger;
    if (m != null) {
      m.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
        ),
      );
    } else if (kDebugMode) {
      debugPrint('Export: $message');
    }
  }

  Future<void> _export() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    const ExportService svc = ExportService();
    try {
      final String csv = await svc.resultPagesToCsv(widget.pages);
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
      await Future<void>.delayed(Duration.zero);

      final String? path = await FilePicker.platform.saveFile(
        dialogTitle: 'Save CSV',
        fileName: 'dbstudio_export.csv',
        type: FileType.custom,
        allowedExtensions: <String>['csv'],
        lockParentWindow: true,
      );
      if (path == null) {
        _toast('Export cancelled.');
        return;
      }
      final String outPath =
          path.toLowerCase().endsWith('.csv') ? path : '$path.csv';
      await File(outPath).writeAsString(csv, flush: true);
      _toast('Saved to $outPath');
    } catch (e, st) {
      debugPrintStack(stackTrace: st, label: 'export');
      if (mounted) {
        setState(() {
          _busy = false;
          _error = e.toString();
        });
      } else {
        widget.scaffoldMessenger?.showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: widget.errorColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_busy,
      child: AlertDialog(
        title: const Text('Export results'),
        content: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.pages.isEmpty
                    ? 'No rows are loaded. The file will contain headers only.'
                    : 'Export ${widget.pages.fold<int>(0, (int sum, ResultPage p) => sum + p.rows.length)} row(s) as CSV (UTF-8).',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (_busy) ...<Widget>[
                const SizedBox(height: 20),
                const Center(
                  child: SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Building CSV…',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              if (_error != null) ...<Widget>[
                const SizedBox(height: 12),
                Text(
                  _error!,
                  style: TextStyle(
                    color: widget.errorColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: _busy ? null : () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: _busy ? null : _export,
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }
}
