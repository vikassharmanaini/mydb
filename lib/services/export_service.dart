import 'dart:isolate';

import 'package:csv/csv.dart';
import 'package:mydb/models/result_page.dart';

/// CSV export: all row stringification and encoding run in a background isolate
/// so the UI thread is not blocked.
final class ExportService {
  const ExportService();

  Future<String> resultPagesToCsv(List<ResultPage> pages) async {
    return Isolate.run(() => _resultPagesToCsvSync(pages));
  }
}

String _resultPagesToCsvSync(List<ResultPage> pages) {
  final List<String> columns =
      pages.isEmpty ? <String>[] : pages.first.columns;
  final List<List<String?>> rows = <List<String?>>[];
  for (final ResultPage p in pages) {
    for (final List<dynamic> r in p.rows) {
      rows.add(
        List<String?>.generate(
          columns.length,
          (int i) => i < r.length ? _cellToStringForExport(r[i]) : null,
        ),
      );
    }
  }
  final List<List<String>> asStrings = <List<String>>[
    columns,
    ...rows.map(
      (List<String?> r) => r.map((String? e) => e ?? '').toList(),
    ),
  ];
  return const ListToCsvConverter().convert(asStrings);
}

String _cellToStringForExport(Object? v) {
  if (v == null) {
    return '';
  }
  return v.toString();
}
