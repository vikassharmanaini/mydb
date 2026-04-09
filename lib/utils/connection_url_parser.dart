import 'package:mydb/models/connection_profile.dart';
import 'package:mydb/models/database_type.dart';
import 'package:mydb/models/ssl_config.dart';

/// Builds a [ConnectionProfile] from a single connection URL.
///
/// Supported forms (after optional `jdbc:` prefix):
/// - **PostgreSQL:** `postgres://` or `postgresql://` — optional userinfo, host, port, path = database.
/// - **MySQL:** `mysql://` or `mariadb://`
/// - **SQLite:** `sqlite:` / `sqlite://` paths, `sqlite:///:memory:`, or `file:` URLs ([Uri.toFilePath]).
///
/// Query hints: `sslmode=disable|allow|require|verify-full`, `ssl=false`.
///
/// Throws [FormatException] when the string cannot be interpreted.
ConnectionProfile connectionProfileFromUrl(
  String rawInput, {
  required String id,
  required DateTime createdAt,
  String? displayName,
}) {
  String normalized = rawInput.trim();
  if (normalized.isEmpty) {
    throw const FormatException('Connection URL is empty');
  }

  final String lower = normalized.toLowerCase();
  if (lower.startsWith('jdbc:postgresql:')) {
    normalized =
        'postgres:${normalized.substring('jdbc:postgresql:'.length)}';
  } else if (lower.startsWith('jdbc:mysql:')) {
    normalized = 'mysql:${normalized.substring('jdbc:mysql:'.length)}';
  } else if (lower.startsWith('jdbc:mariadb:')) {
    normalized = 'mysql:${normalized.substring('jdbc:mariadb:'.length)}';
  }

  final Uri uri = Uri.parse(normalized);
  if (uri.scheme.isEmpty) {
    throw FormatException('Missing URL scheme in: $rawInput');
  }

  final DatabaseType type = _typeForScheme(uri.scheme.toLowerCase());

  if (type == DatabaseType.sqlite) {
    return _profileSqlite(uri, id: id, createdAt: createdAt, name: displayName);
  }

  return _profileNetwork(uri, type,
      id: id, createdAt: createdAt, name: displayName);
}

DatabaseType _typeForScheme(String scheme) {
  return switch (scheme) {
    'postgres' || 'postgresql' => DatabaseType.postgres,
    'mysql' || 'mariadb' => DatabaseType.mysql,
    'sqlite' || 'file' => DatabaseType.sqlite,
    _ => throw FormatException('Unsupported database URL scheme: $scheme'),
  };
}

ConnectionProfile _profileSqlite(
  Uri uri, {
  required String id,
  required DateTime createdAt,
  String? name,
}) {
  final String database;
  final String host;

  if (uri.scheme == 'file') {
    if (uri.path.isEmpty) {
      throw const FormatException('file: URL has no path');
    }
    database = uri.toFilePath();
    host = 'local';
  } else {
    database = _sqliteDatabasePath(uri);
    host = database == ':memory:' ? ':memory:' : 'local';
  }

  final String label = name ?? _defaultNameSqlite(database);

  return ConnectionProfile(
    id: id,
    name: label,
    type: DatabaseType.sqlite,
    host: host,
    port: 0,
    database: database,
    username: '',
    password: null,
    ssl: null,
    createdAt: createdAt,
  );
}

String _sqliteDatabasePath(Uri uri) {
  final String p = uri.path;
  if (uri.host == ':memory:' && (p.isEmpty || p == '/')) {
    return ':memory:';
  }
  if (p == '/:memory:' || p == ':memory:') {
    return ':memory:';
  }
  if (p.isEmpty) {
    throw const FormatException(
      'SQLite URL needs a path (e.g. sqlite:///path/to.db) or :memory:',
    );
  }
  return Uri.decodeComponent(p.startsWith('/') ? p : p);
}

ConnectionProfile _profileNetwork(
  Uri uri,
  DatabaseType type, {
  required String id,
  required DateTime createdAt,
  String? name,
}) {
  final String host = uri.host.isNotEmpty
      ? uri.host
      : (throw const FormatException('URL is missing host'));
  final int port = uri.hasPort ? uri.port : type.defaultPort;

  String database = _databaseFromPath(uri.path);
  if (database.isEmpty) {
    database = type == DatabaseType.postgres ? 'postgres' : '';
  }

  final (String username, String? password) = _parseUserInfo(uri);

  final String user = username.isNotEmpty
      ? username
      : (type == DatabaseType.postgres ? 'postgres' : 'root');

  final SSLConfig? ssl = _sslFromQuery(uri, type);

  final String label =
      name ?? '${type.displayName.split(' ').first} · $host';

  return ConnectionProfile(
    id: id,
    name: label,
    type: type,
    host: host,
    port: port,
    database: database,
    username: user,
    password: password,
    ssl: ssl,
    createdAt: createdAt,
  );
}

(String, String?) _parseUserInfo(Uri uri) {
  final String info = uri.userInfo;
  if (info.isEmpty) {
    return ('', null);
  }
  final int colon = info.indexOf(':');
  if (colon < 0) {
    return (Uri.decodeComponent(info), null);
  }
  return (
    Uri.decodeComponent(info.substring(0, colon)),
    Uri.decodeComponent(info.substring(colon + 1)),
  );
}

String _databaseFromPath(String path) {
  if (path.isEmpty || path == '/') {
    return '';
  }
  final String trimmed = path.startsWith('/') ? path.substring(1) : path;
  return Uri.decodeComponent(trimmed);
}

SSLConfig? _sslFromQuery(Uri uri, DatabaseType type) {
  if (type == DatabaseType.sqlite) {
    return null;
  }
  final Map<String, String> q = uri.queryParameters;
  final String? sslmode = q['sslmode']?.toLowerCase();
  final String? ssl = q['ssl']?.toLowerCase();

  if (ssl == 'false' ||
      ssl == '0' ||
      sslmode == 'disable' ||
      sslmode == 'false') {
    return const SSLConfig(mode: SslMode.disable);
  }
  if (sslmode == 'allow') {
    return const SSLConfig(mode: SslMode.allow);
  }
  if (sslmode == 'verify-full' ||
      sslmode == 'verify_full' ||
      sslmode == 'verify-ca' ||
      sslmode == 'verify_ca') {
    return const SSLConfig(mode: SslMode.verifyFull);
  }
  return const SSLConfig(mode: SslMode.require);
}

String _defaultNameSqlite(String database) {
  if (database == ':memory:') {
    return 'SQLite (memory)';
  }
  final int slash = database.replaceAll(r'\', '/').lastIndexOf('/');
  final String base =
      slash < 0 ? database : database.substring(slash + 1);
  return base.isEmpty ? 'SQLite' : 'SQLite · $base';
}
