import 'dart:async';

import 'package:mydb/drivers/connection_event.dart';
import 'package:mydb/models/connection_profile.dart';
import 'package:mydb/models/database_object.dart';
import 'package:mydb/models/database_type.dart';
import 'package:mydb/models/result_page.dart';
import 'package:mydb/models/schema_metadata.dart';

/// Database access contract (SPEC §4.1).
abstract interface class DatabaseDriver {
  DatabaseType get type;

  bool get isConnected;

  Stream<ConnectionEvent> get events;

  Future<void> connect(ConnectionProfile profile);

  Future<void> disconnect();

  Future<void> cancelCurrentQuery();

  Stream<ResultPage> executeQuery(String sql, {int pageSize = 500});

  Future<int> executeUpdate(String sql);

  Future<void> beginTransaction();

  Future<void> commit();

  Future<void> rollback();

  Future<List<SchemaInfo>> listSchemas();

  Future<List<TableInfo>> listTables(String schema);

  Future<List<ColumnInfo>> listColumns(String schema, String table);

  Future<List<IndexInfo>> listIndexes(String schema, String table);

  Future<List<ForeignKeyInfo>> listForeignKeys(String schema, String table);

  Future<List<ViewInfo>> listViews(String schema);

  Future<List<RoutineInfo>> listRoutines(String schema);

  Future<String> generateDDL(DatabaseObject object);

  Future<int> getRowCount(String schema, String table);
}
