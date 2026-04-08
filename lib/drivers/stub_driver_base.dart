import 'dart:async';

import 'package:mydb/drivers/connection_event.dart';
import 'package:mydb/drivers/driver_interface.dart';
import 'package:mydb/models/connection_profile.dart';
import 'package:mydb/models/database_object.dart';
import 'package:mydb/models/database_type.dart';
import 'package:mydb/models/result_page.dart';
import 'package:mydb/models/schema_metadata.dart';

/// Base class for drivers until real connectivity is implemented.
abstract class StubDatabaseDriver implements DatabaseDriver {
  StubDatabaseDriver(this.type);

  @override
  final DatabaseType type;

  // Closed when the process exits; real drivers will tie this to connection lifecycle.
  // ignore: close_sinks
  final StreamController<ConnectionEvent> _events =
      StreamController<ConnectionEvent>.broadcast();

  @override
  Stream<ConnectionEvent> get events => _events.stream;

  bool _connected = false;

  @override
  bool get isConnected => _connected;

  @override
  Future<void> connect(ConnectionProfile profile) async {
    throw UnimplementedError(
      '${type.displayName} driver: connect() not implemented yet.',
    );
  }

  @override
  Future<void> disconnect() async {
    _connected = false;
  }

  @override
  Future<void> cancelCurrentQuery() async {}

  @override
  Stream<ResultPage> executeQuery(String sql, {int pageSize = 500}) {
    throw UnimplementedError(
      '${type.displayName} driver: executeQuery() not implemented yet.',
    );
  }

  @override
  Future<int> executeUpdate(String sql) async {
    throw UnimplementedError(
      '${type.displayName} driver: executeUpdate() not implemented yet.',
    );
  }

  @override
  Future<void> beginTransaction() async {
    throw UnimplementedError(
      '${type.displayName} driver: transactions not implemented yet.',
    );
  }

  @override
  Future<void> commit() async {
    throw UnimplementedError(
      '${type.displayName} driver: transactions not implemented yet.',
    );
  }

  @override
  Future<void> rollback() async {
    throw UnimplementedError(
      '${type.displayName} driver: transactions not implemented yet.',
    );
  }

  @override
  Future<List<SchemaInfo>> listSchemas() async {
    throw UnimplementedError(
      '${type.displayName} driver: listSchemas() not implemented yet.',
    );
  }

  @override
  Future<List<TableInfo>> listTables(String schema) async {
    throw UnimplementedError(
      '${type.displayName} driver: listTables() not implemented yet.',
    );
  }

  @override
  Future<List<ColumnInfo>> listColumns(String schema, String table) async {
    throw UnimplementedError(
      '${type.displayName} driver: listColumns() not implemented yet.',
    );
  }

  @override
  Future<List<IndexInfo>> listIndexes(String schema, String table) async {
    throw UnimplementedError(
      '${type.displayName} driver: listIndexes() not implemented yet.',
    );
  }

  @override
  Future<List<ForeignKeyInfo>> listForeignKeys(
    String schema,
    String table,
  ) async {
    throw UnimplementedError(
      '${type.displayName} driver: listForeignKeys() not implemented yet.',
    );
  }

  @override
  Future<List<ViewInfo>> listViews(String schema) async {
    throw UnimplementedError(
      '${type.displayName} driver: listViews() not implemented yet.',
    );
  }

  @override
  Future<List<RoutineInfo>> listRoutines(String schema) async {
    throw UnimplementedError(
      '${type.displayName} driver: listRoutines() not implemented yet.',
    );
  }

  @override
  Future<String> generateDDL(DatabaseObject object) async {
    throw UnimplementedError(
      '${type.displayName} driver: generateDDL() not implemented yet.',
    );
  }

  @override
  Future<int> getRowCount(String schema, String table) async {
    throw UnimplementedError(
      '${type.displayName} driver: getRowCount() not implemented yet.',
    );
  }
}
