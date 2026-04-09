import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:mydb/drivers/connection_event.dart';
import 'package:mydb/drivers/driver_interface.dart';
import 'package:mydb/drivers/mysql/mysql_metadata.dart';
import 'package:mydb/models/connection_profile.dart';
import 'package:mydb/models/database_object.dart';
import 'package:mydb/models/database_type.dart';
import 'package:mydb/models/result_page.dart';
import 'package:mydb/models/schema_metadata.dart';
import 'package:mydb/models/ssl_config.dart' as app_ssl;
import 'package:mydb/services/ssh_tunnel_service.dart';
import 'package:mysql_client/mysql_client.dart';

/// MySQL / MariaDB [DatabaseDriver] via `mysql_client`.
class MySQLDriver implements DatabaseDriver {
  MySQLDriver();

  final StreamController<ConnectionEvent> _events =
      StreamController<ConnectionEvent>.broadcast();

  MySQLConnection? _conn;
  SSHTunnelSession? _sshTunnel;
  int _txDepth = 0;
  int? _threadId;

  /// Recreate a sibling connection for [cancelCurrentQuery] / KILL QUERY.
  String? _host;
  int _port = 3306;
  String _user = '';
  String _password = '';
  bool _secure = true;
  String? _database;

  @override
  DatabaseType get type => DatabaseType.mysql;

  @override
  bool get isConnected => _conn != null && _conn!.connected;

  @override
  Stream<ConnectionEvent> get events => _events.stream;

  @override
  Future<void> connect(ConnectionProfile profile) async {
    if (profile.type != DatabaseType.mysql) {
      throw ArgumentError.value(profile.type, 'profile.type', 'expected mysql');
    }
    await disconnect();
    int port = profile.port <= 0 ? profile.type.defaultPort : profile.port;
    String host = profile.host;
    if (profile.ssh != null) {
      try {
        _sshTunnel = await SSHTunnelSession.open(
          ssh: profile.ssh!,
          remoteHost: profile.host,
          remotePort: port,
        );
      } catch (e, st) {
        _events.add(ConnectionEvent.error(e.toString(), st.toString()));
        rethrow;
      }
      host = InternetAddress.loopbackIPv4.address;
      port = _sshTunnel!.localPort;
    }
    _host = host;
    _port = port;
    _user = profile.username;
    _password = profile.password ?? '';
    _database = profile.database.isEmpty ? null : profile.database;
    _secure = _useTls(profile);

    _conn = await MySQLConnection.createConnection(
      host: host,
      port: port,
      userName: profile.username,
      password: _password,
      databaseName: _database,
      secure: _secure,
    );
    try {
      await _conn!.connect();
      await _refreshThreadId();
      _events.add(const ConnectionEvent.connected());
    } catch (e, st) {
      _events.add(ConnectionEvent.error(e.toString(), st.toString()));
      await _safeCloseConn();
      rethrow;
    }
  }

  bool _useTls(ConnectionProfile profile) {
    final ssl = profile.ssl;
    if (ssl == null) {
      return false;
    }
    return ssl.mode != app_ssl.SslMode.disable;
  }

  Future<void> _safeCloseConn() async {
    final c = _conn;
    _conn = null;
    _threadId = null;
    if (c != null) {
      try {
        await c.close();
      } catch (_) {
        /* ignore */
      }
    }
  }

  @override
  Future<void> disconnect() async {
    _threadId = null;
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
    final SSHTunnelSession? t = _sshTunnel;
    _sshTunnel = null;
    if (t != null) {
      try {
        await t.close();
      } catch (_) {
        /* ignore */
      }
    }
  }

  Future<void> _refreshThreadId() async {
    final c = _conn;
    if (c == null) {
      return;
    }
    final r = await c.execute('SELECT CONNECTION_ID()');
    if (r.rows.isEmpty) {
      return;
    }
    _threadId = int.parse(r.rows.first.colAt(0)!);
  }

  @override
  Future<void> cancelCurrentQuery() async {
    final id = _threadId;
    final host = _host;
    if (id == null || host == null) {
      return;
    }
    final killer = await MySQLConnection.createConnection(
      host: host,
      port: _port,
      userName: _user,
      password: _password,
      databaseName: _database,
      secure: _secure,
    );
    try {
      await killer.connect();
      await killer.execute('KILL QUERY $id');
    } finally {
      await killer.close();
    }
  }

  @override
  Stream<ResultPage> executeQuery(String sql, {int pageSize = 500}) async* {
    await _ensureConnected();
    final sw = Stopwatch()..start();
    try {
      await _refreshThreadId();
      if (_shouldStreamRows(sql)) {
        yield* _executeStreaming(sql, pageSize, sw);
      } else {
        yield* _executeBuffered(sql, pageSize, sw);
      }
    } finally {
      await _refreshThreadId();
    }
  }

  bool _shouldStreamRows(String sql) {
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
        u.startsWith('SHOW') ||
        u.startsWith('DESCRIBE') ||
        u.startsWith('DESC') ||
        u.startsWith('EXPLAIN');
  }

  Stream<ResultPage> _executeStreaming(
    String sql,
    int pageSize,
    Stopwatch sw,
  ) async* {
    final rs = await _conn!.execute(sql, null, true);
    if (rs is EmptyResultSet) {
      yield ResultPage(
        pageIndex: 0,
        pageSize: pageSize,
        columns: <String>[],
        rows: <List<dynamic>>[],
        totalRows: 0,
        queryDuration: sw.elapsed,
      );
      return;
    }
    if (rs is! IterableResultSet) {
      yield* _iResultToPages(rs, pageSize, sw);
      return;
    }
    final colNames = rs.cols.map((ResultSetColumn c) => c.name).toList();
    var buf = <List<dynamic>>[];
    var pageIndex = 0;
    await for (final ResultSetRow row in rs.rowsStream) {
      final m = row.typedAssoc();
      buf.add(colNames.map((String n) => m[n]).toList());
      if (buf.length >= pageSize) {
        yield ResultPage(
          pageIndex: pageIndex++,
          pageSize: pageSize,
          columns: colNames,
          rows: buf,
          totalRows: null,
          queryDuration: sw.elapsed,
        );
        buf = <List<dynamic>>[];
      }
    }
    yield ResultPage(
      pageIndex: pageIndex,
      pageSize: pageSize,
      columns: colNames,
      rows: buf,
      totalRows: null,
      queryDuration: sw.elapsed,
    );
  }

  Stream<ResultPage> _executeBuffered(
    String sql,
    int pageSize,
    Stopwatch sw,
  ) async* {
    final rs = await _conn!.execute(sql);
    yield* _iResultToPages(rs, pageSize, sw);
  }

  Stream<ResultPage> _iResultToPages(
    IResultSet rs,
    int pageSize,
    Stopwatch sw,
  ) async* {
    if (rs is EmptyResultSet) {
      yield ResultPage(
        pageIndex: 0,
        pageSize: pageSize,
        columns: <String>[],
        rows: <List<dynamic>>[],
        totalRows: 0,
        queryDuration: sw.elapsed,
      );
      return;
    }
    final colNames = rs.cols.map((ResultSetColumn c) => c.name).toList();
    final rows = rs.rows
        .map(
          (ResultSetRow row) =>
              colNames.map((String n) => row.typedAssoc()[n]).toList(),
        )
        .toList();
    if (rows.isEmpty) {
      yield ResultPage(
        pageIndex: 0,
        pageSize: pageSize,
        columns: colNames,
        rows: <List<dynamic>>[],
        totalRows: 0,
        queryDuration: sw.elapsed,
      );
      return;
    }
    var page = 0;
    for (var i = 0; i < rows.length; i += pageSize, page++) {
      final end = min(i + pageSize, rows.length);
      yield ResultPage(
        pageIndex: page,
        pageSize: pageSize,
        columns: colNames,
        rows: rows.sublist(i, end),
        totalRows: rows.length,
        queryDuration: sw.elapsed,
      );
    }
  }

  @override
  Future<int> executeUpdate(String sql) async {
    await _ensureConnected();
    await _refreshThreadId();
    try {
      final rs = await _conn!.execute(sql);
      return rs.affectedRows.toInt();
    } finally {
      await _refreshThreadId();
    }
  }

  @override
  Future<void> beginTransaction() async {
    await _ensureConnected();
    if (_txDepth > 0) {
      throw StateError('Nested transactions are not supported for MySQL.');
    }
    _txDepth = 1;
    await _conn!.execute('START TRANSACTION');
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
    return MySQLMetadata.listSchemas(_conn!);
  }

  @override
  Future<List<TableInfo>> listTables(String schema) async {
    await _ensureConnected();
    return MySQLMetadata.listTables(_conn!, schema);
  }

  @override
  Future<List<ColumnInfo>> listColumns(String schema, String table) async {
    await _ensureConnected();
    return MySQLMetadata.listColumns(_conn!, schema, table);
  }

  @override
  Future<List<IndexInfo>> listIndexes(String schema, String table) async {
    await _ensureConnected();
    return MySQLMetadata.listIndexes(_conn!, schema, table);
  }

  @override
  Future<List<ForeignKeyInfo>> listForeignKeys(
    String schema,
    String table,
  ) async {
    await _ensureConnected();
    return MySQLMetadata.listForeignKeys(_conn!, schema, table);
  }

  @override
  Future<List<ViewInfo>> listViews(String schema) async {
    await _ensureConnected();
    return MySQLMetadata.listViews(_conn!, schema);
  }

  @override
  Future<List<RoutineInfo>> listRoutines(String schema) async {
    await _ensureConnected();
    return MySQLMetadata.listRoutines(_conn!, schema);
  }

  @override
  Future<String> generateDDL(DatabaseObject object) async {
    await _ensureConnected();
    return MySQLMetadata.generateDDL(_conn!, object);
  }

  @override
  Future<int> getRowCount(String schema, String table) async {
    await _ensureConnected();
    final qs = MySQLMetadata.quoteIdent(schema);
    final qt = MySQLMetadata.quoteIdent(table);
    final r = await _conn!.execute('SELECT COUNT(*) AS c FROM $qs.$qt');
    final v = r.rows.first.colAt(0)!;
    return int.parse(v);
  }

  Future<void> _ensureConnected() async {
    if (_conn == null || !_conn!.connected) {
      throw StateError('Not connected to MySQL.');
    }
  }
}
