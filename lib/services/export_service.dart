import 'dart:isolate';

import 'package:csv/csv.dart';
import 'package:mydb/models/result_page.dart';

/// CSV export (heavy work off the UI isolate).
final class ExportService {
  const ExportService();

  Future<String> resultPagesToCsv(List<ResultPage> pages) async {
    final List<String> columns = pages.isEmpty ? <String>[] : pages.first.columns;
    final List<List<String?>> rows = <List<String?>>[];
    for (final ResultPage p in pages) {
      for (final List<dynamic> r in p.rows) {
        rows.add(
          List<String?>.generate(
            columns.length,
            (int i) =>
                i < r.length ? _cellToString(r[i]) : null,
          ),
        );
      }
    }
    final ExportPayload payload = ExportPayload(columns: columns, rows: rows);
    return Isolate.run(() => _encodeCsvIsolate(payload));
  }

  static String _cellToString(Object? v) {
    if (v == null) {
      return '';
    }
    return v.toString();
  }
}

final class ExportPayload {
  const ExportPayload({required this.columns, required this.rows});

  final List<String> columns;
  final List<List<String?>> rows;
}

String _encodeCsvIsolate(ExportPayload p) {
  final List<List<String>> asStrings = <List<String>>[
    p.columns,
    ...p.rows.map(
      (List<String?> r) =>
          r.map((String? e) => e ?? '').toList(),
    ),
  ];
  return const ListToCsvConverter().convert(asStrings);
}
