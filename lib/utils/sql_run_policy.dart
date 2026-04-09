/// Rules for how the SQL workspace executes a single user action.
library;

/// True if [sql] appears to contain more than one statement (split by `;` outside strings — heuristic).
bool sqlLooksLikeMultipleStatements(String sql) {
  final String t = sql.trim();
  if (t.isEmpty) {
    return false;
  }
  final int semi = t.indexOf(';');
  if (semi < 0) {
    return false;
  }
  final String after = t.substring(semi + 1).trim();
  return after.isNotEmpty;
}

/// Whether to use [DatabaseDriver.executeUpdate] instead of streaming [executeQuery].
bool sqlPrefersExecuteUpdate(String sql) {
  var t = sql.trim();
  if (t.isEmpty) {
    return false;
  }
  if (t.endsWith(';')) {
    t = t.substring(0, t.length - 1).trim();
  }
  final String u = t.toUpperCase();
  if ((u.startsWith('INSERT') ||
          u.startsWith('UPDATE') ||
          u.startsWith('DELETE')) &&
      u.contains('RETURNING')) {
    return false;
  }
  const List<String> prefixes = <String>[
    'INSERT',
    'UPDATE',
    'DELETE',
    'CREATE',
    'DROP',
    'ALTER',
    'TRUNCATE',
    'GRANT',
    'REVOKE',
    'BEGIN',
    'COMMIT',
    'ROLLBACK',
    'SAVEPOINT',
    'RELEASE',
    'VACUUM',
    'ANALYZE',
    'REINDEX',
    'ATTACH',
    'DETACH',
    'PRAGMA',
    'CALL',
  ];
  for (final String p in prefixes) {
    if (u == p || u.startsWith('$p ') || u.startsWith('$p\n') || u.startsWith('$p\t')) {
      return true;
    }
  }
  return false;
}
