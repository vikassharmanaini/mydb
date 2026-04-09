import 'package:mydb/models/schema_metadata.dart';

/// Lightweight schema diff (table name sets) for explorer tooling.
final class SchemaCompareService {
  const SchemaCompareService();

  /// Returns lines describing tables only in [a], only in [b], and in both.
  String diffTableNames(List<TableInfo> a, List<TableInfo> b) {
    final Set<String> sa = a.map((TableInfo t) => t.name).toSet();
    final Set<String> sb = b.map((TableInfo t) => t.name).toSet();
    final Set<String> onlyA = sa.difference(sb);
    final Set<String> onlyB = sb.difference(sa);
    final Set<String> both = sa.intersection(sb);
    final StringBuffer buf = StringBuffer();
    buf.writeln('Only in first: ${onlyA.length}');
    for (final String n in onlyA) {
      buf.writeln('  - $n');
    }
    buf.writeln('Only in second: ${onlyB.length}');
    for (final String n in onlyB) {
      buf.writeln('  + $n');
    }
    buf.writeln('In both: ${both.length}');
    return buf.toString();
  }
}
