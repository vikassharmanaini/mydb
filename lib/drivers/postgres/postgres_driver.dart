import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:mydb/drivers/connection_event.dart';
import 'package:mydb/drivers/driver_interface.dart';
import 'package:mydb/drivers/postgres/postgres_metadata.dart';
import 'package:mydb/models/connection_profile.dart';
import 'package:mydb/models/database_object.dart';
import 'package:mydb/models/database_type.dart';
import 'package:mydb/models/result_page.dart';
import 'package:mydb/models/schema_metadata.dart';
import 'package:mydb/models/ssl_config.dart' as app_ssl;
import 'package:postgres/postgres.dart' as pg;

/// PostgreSQL [DatabaseDriver] using package `postgres`.
///
/// Uses a single [pg.Connection] so transactions and cancel are reliable.
/// Connection pooling (TASK T-217) can wrap multiple connections later.
class PostgresDriver implements DatabaseDriver {
  PostgresDriver();

  final StreamController<ConnectionEvent> _events =
      StreamController<ConnectionEvent>.broadcast();

  pg.Connection? _conn;
  pg.Endpoint? _endpoint;
  pg.ConnectionSettings? _settings;

  int _txDepth = 0;
  int _cursorSeq = 0;
  int? _activeQueryPid;

  @override
  DatabaseType get type => DatabaseType.postgres;

  @override
  bool get isConnected => _conn != null && _conn!.isOpen;

  @override
  Stream<ConnectionEvent> get events => _events.stream;

  @override
  Future<void> connect(ConnectionProfile profile) async {
    if (profile.type != DatabaseType.postgres) {
      throw ArgumentError.value(profile.type, 'profile.type', 'expected postgres');
    }
    if (profile.ssh != null) {
      throw UnsupportedError(
        'SSH tunnel is not implemented yet. Remove SSH from the profile or implement SSHTunnelService.',
      );
    }
    await disconnect();
    final port = profile.port <= 0 ? profile.type.defaultPort : profile.port;
    _endpoint = pg.Endpoint(
      host: profile.host,
      port: port,
      database: profile.database,
      username: profile.username,
      password: profile.password,
    );
    _settings = _buildConnectionSettings(profile);
    try {
      _conn = await pg.Connection.open(_endpoint!, settings: _settings);
      _events.add(const ConnectionEvent.connected());
    } catch (e, st) {
      _events.add(ConnectionEvent.error(e.toString(), st.toString()));
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    _activeQueryPid = null;
    final c = _conn;
    _conn = null;
    if (c != null) {
      try {
        if (_txDepth > 0) {
          await c.execute('ROLLBACK');
        }
      } catch (_) {
        /* ignore */
      }
      _txDepth = 0;
      try {
        await c.close();
      } catch (_) {
        /* ignore */
      }
      _events.add(const ConnectionEvent.disconnected());
    }
  }

  @override
  Future<void> cancelCurrentQuery() async {
    final pid = _activeQueryPid;
    final ep = _endpoint;
    final st = _settings;
    if (pid == null || ep == null || st == null) {
      return;
    }
    final cancelConn = await pg.Connection.open(ep, settings: st);
    try {
      await cancelConn.execute(
        pg.Sql.named('SELECT pg_cancel_backend(@p:int4)'),
        parameters: <String, Object?>{'p': pid},
      );
    } finally {
      await cancelConn.close();
    }
  }

  @override
  Stream<ResultPage> executeQuery(String sql, {int pageSize = 500}) async* {
    await _ensureConnected();
    final sw = Stopwatch()..start();
    try {
      await _refreshBackendPid();
      if (_shouldPageWithCursor(sql)) {
        yield* _executeWithCursor(sql, pageSize, sw);
      } else {
        yield* _executeSimplePaged(sql, pageSize, sw);
      }
    } finally {
      _activeQueryPid = null;
    }
  }

  @override
  Future<int> executeUpdate(String sql) async {
    await _ensureConnected();
    await _refreshBackendPid();
    try {
      final r = await _conn!.execute(sql, ignoreRows: true);
      return r.affectedRows;
    } finally {
      _activeQueryPid = null;
    }
  }

  @override
  Future<void> beginTransaction() async {
    await _ensureConnected();
    if (_txDepth > 0) {
      throw StateError('Nested transactions are not supported for PostgreSQL.');
    }
    _txDepth = 1;
    await _conn!.execute('BEGIN');
  }

  @override
  Future<void> commit() async {
    await _ensureConnected();
    if (_txDepth != 1) {
      throw StateError('No active transaction to commit.');
    }
    await _conn!.execute('COMMIT');
    _txDepth = 0;
  }

  @override
  Future<void> rollback() async {
    await _ensureConnected();
    if (_txDepth != 1) {
      throw StateError('No active transaction to roll back.');
    }
    await _conn!.execute('ROLLBACK');
    _txDepth = 0;
  }

  @override
  Future<List<SchemaInfo>> listSchemas() async {
    await _ensureConnected();
    return PostgresMetadata.listSchemas(_conn!);
  }

  @override
  Future<List<TableInfo>> listTables(String schema) async {
    await _ensureConnected();
    return PostgresMetadata.listTables(_conn!, schema);
  }

  @override
  Future<List<ColumnInfo>> listColumns(String schema, String table) async {
    await _ensureConnected();
    return PostgresMetadata.listColumns(_conn!, schema, table);
  }

  @override
  Future<List<IndexInfo>> listIndexes(String schema, String table) async {
    await _ensureConnected();
    return PostgresMetadata.listIndexes(_conn!, schema, table);
  }

  @override
  Future<List<ForeignKeyInfo>> listForeignKeys(
    String schema,
    String table,
  ) async {
    await _ensureConnected();
    return PostgresMetadata.listForeignKeys(_conn!, schema, table);
  }

  @override
  Future<List<ViewInfo>> listViews(String schema) async {
    await _ensureConnected();
    return PostgresMetadata.listViews(_conn!, schema);
  }

  @override
  Future<List<RoutineInfo>> listRoutines(String schema) async {
    await _ensureConnected();
    return PostgresMetadata.listRoutines(_conn!, schema);
  }

  @override
  Future<String> generateDDL(DatabaseObject object) async {
    await _ensureConnected();
    return PostgresMetadata.generateDDL(_conn!, object);
  }

  @override
  Future<int> getRowCount(String schema, String table) async {
    await _ensureConnected();
    final qSchema = PostgresMetadata.quoteIdent(schema);
    final qTable = PostgresMetadata.quoteIdent(table);
    final r = await _conn!.execute('SELECT COUNT(*) FROM $qSchema.$qTable');
    return (r.first.first as num).toInt();
  }

  Future<void> _ensureConnected() async {
    if (_conn == null || !_conn!.isOpen) {
      throw StateError('Not connected to PostgreSQL.');
    }
  }

  Future<void> _refreshBackendPid() async {
    final r = await _conn!.execute('SELECT pg_backend_pid()');
    _activeQueryPid = (r.first.first as int);
  }

  pg.ConnectionSettings _buildConnectionSettings(ConnectionProfile profile) {
    final ssl = profile.ssl;
    if (ssl == null) {
      return const pg.ConnectionSettings(
        applicationName: 'dbstudio',
        sslMode: pg.SslMode.disable,
      );
    }
    final pg.SslMode mode = switch (ssl.mode) {
      app_ssl.SslMode.disable => pg.SslMode.disable,
      app_ssl.SslMode.allow => pg.SslMode.require,
      app_ssl.SslMode.require => pg.SslMode.require,
      app_ssl.SslMode.verifyFull => pg.SslMode.verifyFull,
    };
    SecurityContext? ctx;
    final ca = ssl.caCertPath;
    if (ca != null && ca.isNotEmpty) {
      ctx = SecurityContext(withTrustedRoots: true)..setTrustedCertificates(ca);
    }
    final cert = ssl.clientCertPath;
    final key = ssl.clientKeyPath;
    if (cert != null &&
        key != null &&
        cert.isNotEmpty &&
        key.isNotEmpty) {
      ctx ??= SecurityContext();
      ctx.useCertificateChain(cert);
      ctx.usePrivateKey(key);
    }
    return pg.ConnectionSettings(
      applicationName: 'dbstudio',
      sslMode: mode,
      securityContext: ctx,
    );
  }

  bool _shouldPageWithCursor(String sql) {
    var t = sql.trim();
    if (t.endsWith(';')) {
      t = t.substring(0, t.length - 1).trim();
    }
    if (t.contains(';')) {
      return false;
    }
    final u = t.toUpperCase();
    return u.startsWith('SELECT') ||
        u.startsWith('WITH') ||
        u.startsWith('VALUES') ||
        u.startsWith('TABLE ');
  }

  Stream<ResultPage> _executeSimplePaged(
    String sql,
    int pageSize,
    Stopwatch sw,
  ) async* {
    final r = await _conn!.execute(sql);
    final cols = _columnNames(r.schema);
    if (r.isEmpty) {
      yield ResultPage(
        pageIndex: 0,
        pageSize: pageSize,
        columns: cols,
        rows: <List<dynamic>>[],
        totalRows: 0,
        queryDuration: sw.elapsed,
      );
      return;
    }
    final rows = r.map((pg.ResultRow row) => List<dynamic>.from(row)).toList();
    var page = 0;
    for (var i = 0; i < rows.length; i += pageSize, page++) {
      final end = min(i + pageSize, rows.length);
      yield ResultPage(
        pageIndex: page,
        pageSize: pageSize,
        columns: cols,
        rows: rows.sublist(i, end),
        totalRows: rows.length,
        queryDuration: sw.elapsed,
      );
    }
  }

  Stream<ResultPage> _executeWithCursor(
    String sql,
    int pageSize,
    Stopwatch sw,
  ) async* {
    final cursor = 'dbstudio_c${_cursorSeq++}';
    final outerTx = _txDepth > 0;
    if (!outerTx) {
      await _conn!.execute('BEGIN');
    }
    try {
      await _conn!.execute('DECLARE "$cursor" NO SCROLL CURSOR FOR $sql');
      var pageIndex = 0;
      while (true) {
        await _refreshBackendPid();
        final r = await _conn!.execute('FETCH $pageSize FROM "$cursor"');
        if (r.isEmpty) {
          break;
        }
        final cols = _columnNames(r.schema);
        final rows =
            r.map((pg.ResultRow row) => List<dynamic>.from(row)).toList();
        yield ResultPage(
          pageIndex: pageIndex++,
          pageSize: pageSize,
          columns: cols,
          rows: rows,
          totalRows: null,
          queryDuration: sw.elapsed,
        );
        if (rows.length < pageSize) {
          break;
        }
      }
    } finally {
      try {
        await _conn!.execute('CLOSE "$cursor"');
      } catch (_) {
        /* ignore */
      }
      if (!outerTx) {
        try {
          await _conn!.execute('COMMIT');
        } catch (_) {
          /* ignore */
        }
      }
    }
  }

  List<String> _columnNames(pg.ResultSchema schema) {
    return schema.columns
        .asMap()
        .entries
        .map((MapEntry<int, pg.ResultSchemaColumn> e) =>
            e.value.columnName ?? 'column_${e.key}')
        .toList();
  }
}
