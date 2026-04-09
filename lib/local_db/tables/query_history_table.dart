import 'package:drift/drift.dart';

/// Query execution history (one row per run).
class QueryHistory extends Table {
  TextColumn get id => text()();
  TextColumn get connectionId => text()();
  TextColumn get databaseType => text()();
  TextColumn get sql => text()();
  DateTimeColumn get executedAt => dateTime()();
  IntColumn get durationMs => integer().nullable()();
  BoolColumn get success => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
