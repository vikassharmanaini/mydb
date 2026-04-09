import 'package:csv/csv.dart';

/// Parses CSV text into rows (first row may be headers).
final class ImportService {
  const ImportService();

  List<List<String>> parseCsv(String text, {bool hasHeader = true}) {
    final List<List<dynamic>> raw =
        const CsvToListConverter().convert(text);
    final List<List<String>> out = <List<String>>[];
    for (final List<dynamic> row in raw) {
      out.add(row.map((dynamic e) => e?.toString() ?? '').toList());
    }
    if (hasHeader && out.isNotEmpty) {
      return out.sublist(1);
    }
    return out;
  }
}
