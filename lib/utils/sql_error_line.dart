/// Best-effort 1-based line number from common server error text.
int? parseSqlErrorLine(String message) {
  final RegExp pg = RegExp(r'(?:LINE|line)\s+(\d+)', caseSensitive: false);
  final Match? m = pg.firstMatch(message);
  if (m != null) {
    return int.tryParse(m.group(1)!);
  }
  final RegExp generic = RegExp(r'line\s*(\d+)', caseSensitive: false);
  final Match? m2 = generic.firstMatch(message);
  return m2 != null ? int.tryParse(m2.group(1)!) : null;
}
