/// Very small SQL pretty-printer (inserts line breaks before major keywords).
String formatSqlNaive(String sql) {
  final String t = sql.trim();
  if (t.isEmpty) {
    return t;
  }
  final RegExp re = RegExp(
    r'\b(SELECT|FROM|WHERE|AND|OR|LEFT|RIGHT|INNER|OUTER|JOIN|'
    r'ON|GROUP\s+BY|ORDER\s+BY|HAVING|LIMIT|OFFSET|UNION|INSERT\s+INTO|'
    r'VALUES|UPDATE|SET|DELETE\s+FROM|CREATE\s+TABLE|ALTER\s+TABLE|'
    r'DROP\s+TABLE)\b',
    caseSensitive: false,
  );
  return t.replaceAllMapped(re, (Match m) => '\n${m[0]}').trim();
}
