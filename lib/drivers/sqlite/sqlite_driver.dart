import 'dart:async';

import 'package:mydb/drivers/connection_event.dart';
import 'package:mydb/drivers/driver_interface.dart';
import 'package:mydb/drivers/sqlite/sqlite_metadata.dart';
import 'package:mydb/models/connection_profile.dart';
import 'package:mydb/models/database_object.dart';
import 'package:mydb/models/database_type.dart';
import 'package:mydb/models/result_page.dart';
import 'package:mydb/models/schema_metadata.dart';
import 'package:sqlite3/sqlite3.dart';

/// SQLite [DatabaseDriver] via `sqlite3` FFI.
///
/// [ConnectionProfile.database] is the file path, or `:memory:` for an
/// in-memory database. [ConnectionProfile.host] may be `:memory:` as an
/// alternative signal. SSL and SSH are ignored.
///
/// [cancelCurrentQuery] is a no-op (no stable interrupt API in this binding).
class SQLiteDriver implements DatabaseDriver {
  SQLiteDriver();

  final StreamController<ConnectionEvent> _events =
      StreamController<ConnectionEvent>.broadcast();

  Database? _db;
  int _txDepth = 0;

  @override
  DatabaseType get type => DatabaseType.sqlite;

  @override
  bool get isConnected => _db != null;

  @override
  Stream<ConnectionEvent> get events => _events.stream;

  @override
  Future<void> connect(ConnectionProfile profile) async {
    if (profile.type != DatabaseType.sqlite) {
      throw ArgumentError.value(profile.type, 'profile.type', 'expected sqlite');
    }
    if (profile.ssh != null) {
      throw UnsupportedError(
        'SSH tunnel is not implemented for SQLite profiles.',
      );
    }
    await disconnect();
    final path = profile.database.trim();
    final mem = path == ':memory:' || profile.host.trim() == ':memory:';
    try {
      _db = mem ? sqlite3.openInMemory() : sqlite3.open(path);
      _events.add(const ConnectionEvent.connected());
    } catch (e, st) {
      _events.add(ConnectionEvent.error(e.toString(), st.toString()));
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    final d = _db;
    _db = null;
    if (d != null) {
      try {
        if (_txDepth > 0) {
          d.execute('ROLLBACK');
        }
      } catch (_) {
        /* ignore */
      }
      _txDepth = 0;
      d.dispose();
      _events.add(const ConnectionEvent.disconnected());
    }
  }

  @override
  Future<void> cancelCurrentQuery() async {}

  @override
  Stream<ResultPage> executeQuery(String sql, {int pageSize = 500}) async* {
    await _ensureConnected();
    final sw = Stopwatch()..start();
    final stmt = _db!.prepare(sql);
    try {
      final IteratingCursor cur =
          stmt.iterateWith(const StatementParameters.empty());
      var colNames = <String>[];
      var buf = <List<dynamic>>[];
      var pageIndex = 0;
      var yielded = false;
      while (cur.moveNext()) {
        if (colNames.isEmpty) {
          colNames = List<String>.from(cur.columnNames);
        }
        final Row row = cur.current;
        buf.add(List<dynamic>.from(row.values));
        if (buf.length >= pageSize) {
          yield ResultPage(
            pageIndex: pageIndex++,
            pageSize: pageSize,
            columns: colNames,
            rows: buf,
            totalRows: null,
            queryDuration: sw.elapsed,
          );
          yielded = true;
          buf = <List<dynamic>>[];
        }
      }
      if (buf.isNotEmpty || !yielded) {
        yield ResultPage(
          pageIndex: pageIndex,
          pageSize: pageSize,
          columns: colNames,
          rows: buf,
          totalRows: colNames.isEmpty ? 0 : null,
          queryDuration: sw.elapsed,
        );
      }
    } finally {
      stmt.dispose();
    }
  }

  @override
  Future<int> executeUpdate(String sql) async {
    await _ensureConnected();
    _db!.execute(sql);
    return _db!.updatedRows;
  }

  @override
  Future<void> beginTransaction() async {
    await _ensureConnected();
    if (_txDepth > 0) {
      throw StateError('Nested transactions are not supported for SQLite.');
    }
    _txDepth = 1;
    _db!.execute('BEGIN');
  }

  @override
  Future<void> commit() async {
    await _ensureConnected();
    if (_txDepth != 1) {
      throw StateError('No active transaction to commit.');
    }
    _db!.execute('COMMIT');
    _txDepth = 0;
  }

  @override
  Future<void> rollback() async {
    await _ensureConnected();
    if (_txDepth != 1) {
      throw StateError('No active transaction to roll back.');
    }
    _db!.execute('ROLLBACK');
    _txDepth = 0;
  }

  @override
  Future<List<SchemaInfo>> listSchemas() async {
    await _ensureConnected();
    return SQLiteMetadata.listSchemas(_db!);
  }

  @override
  Future<List<TableInfo>> listTables(String schema) async {
    await _ensureConnected();
    return SQLiteMetadata.listTables(_db!, schema);
  }

  @override
  Future<List<ColumnInfo>> listColumns(String schema, String table) async {
    await _ensureConnected();
    return SQLiteMetadata.listColumns(_db!, schema, table);
  }

  @override
  Future<List<IndexInfo>> listIndexes(String schema, String table) async {
    await _ensureConnected();
    return SQLiteMetadata.listIndexes(_db!, schema, table);
  }

  @override
  Future<List<ForeignKeyInfo>> listForeignKeys(
    String schema,
    String table,
  ) async {
    await _ensureConnected();
    return SQLiteMetadata.listForeignKeys(_db!, schema, table);
  }

  @override
  Future<List<ViewInfo>> listViews(String schema) async {
    await _ensureConnected();
    return SQLiteMetadata.listViews(_db!, schema);
  }

  @override
  Future<List<RoutineInfo>> listRoutines(String schema) async {
    await _ensureConnected();
    return SQLiteMetadata.listRoutines(_db!, schema);
  }

  @override
  Future<String> generateDDL(DatabaseObject object) async {
    await _ensureConnected();
    return SQLiteMetadata.generateDDL(_db!, object);
  }

  @override
  Future<int> getRowCount(String schema, String table) async {
    await _ensureConnected();
    final qs = SQLiteMetadata.quoteIdent(schema);
    final qt = SQLiteMetadata.quoteIdent(table);
    final rs = _db!.select('SELECT COUNT(*) AS c FROM $qs.$qt');
    return (rs.first['c']! as num).toInt();
  }

  Future<void> _ensureConnected() async {
    if (_db == null) {
      throw StateError('Not connected to SQLite.');
    }
  }
}
