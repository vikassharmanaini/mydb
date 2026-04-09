/// True if [sql] likely changes schema objects (best-effort, for cache invalidation).
bool sqlLooksLikeDdl(String sql) {
  final String u = sql.toUpperCase();
  return u.contains('CREATE ') ||
      u.contains('ALTER ') ||
      u.contains('DROP ') ||
      u.contains('TRUNCATE ');
}
