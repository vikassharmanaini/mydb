import 'package:drift/drift.dart';
import 'package:mydb/local_db/app_database.dart';
import 'package:mydb/local_db/tables/query_history_table.dart';
import 'package:mydb/models/database_type.dart';
import 'package:mydb/models/query_history_entry.dart';

part 'history_dao.g.dart';

@DriftAccessor(tables: <Type>[QueryHistory])
class HistoryDao extends DatabaseAccessor<AppDatabase> with _$HistoryDaoMixin {
  HistoryDao(super.db);

  static QueryHistoryEntry _rowToEntry(QueryHistoryData row) {
    return QueryHistoryEntry(
      id: row.id,
      connectionId: row.connectionId,
      databaseType: DatabaseType.values.byName(row.databaseType),
      sql: row.sql,
      executedAt: row.executedAt,
      durationMs: row.durationMs,
      success: row.success,
    );
  }

  Future<void> insertEntry(QueryHistoryEntry entry) async {
    await into(queryHistory).insert(
      QueryHistoryCompanion.insert(
        id: entry.id,
        connectionId: entry.connectionId,
        databaseType: entry.databaseType.name,
        sql: entry.sql,
        executedAt: entry.executedAt,
        durationMs: Value<int?>(entry.durationMs),
        success: Value<bool>(entry.success),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<List<QueryHistoryEntry>> listRecent({
    String? connectionId,
    int limit = 100,
  }) async {
    final SimpleSelectStatement<$QueryHistoryTable, QueryHistoryData> q =
        select(queryHistory);
    if (connectionId != null) {
      q.where(($QueryHistoryTable t) => t.connectionId.equals(connectionId));
    }
    q
      ..orderBy(<OrderClauseGenerator<$QueryHistoryTable>>[
        ($QueryHistoryTable t) => OrderingTerm.desc(t.executedAt),
      ])
      ..limit(limit);
    final List<QueryHistoryData> rows = await q.get();
    return rows.map(_rowToEntry).toList();
  }

  /// Substring search on [sql] (LIKE metacharacters in [pattern] are escaped).
  Future<List<QueryHistoryEntry>> searchSql(String pattern) async {
    final String escaped = _escapeLikePattern(pattern);
    final List<QueryHistoryData> rows = await (select(queryHistory)
          ..where(
            ($QueryHistoryTable t) => t.sql.like('%$escaped%'),
          )
          ..orderBy(<OrderClauseGenerator<$QueryHistoryTable>>[
            ($QueryHistoryTable t) => OrderingTerm.desc(t.executedAt),
          ])
          ..limit(200))
        .get();
    return rows.map(_rowToEntry).toList();
  }

  Future<int> deleteEntry(String id) async {
    return (await (delete(queryHistory)
          ..where(($QueryHistoryTable t) => t.id.equals(id)))
        .go());
  }

  Future<int> deleteForConnection(String connectionId) async {
    return (await (delete(queryHistory)
          ..where(($QueryHistoryTable t) => t.connectionId.equals(connectionId)))
        .go());
  }

  static String _escapeLikePattern(String raw) {
    return raw
        .replaceAll(r'\', r'\\')
        .replaceAll('%', r'\%')
        .replaceAll('_', r'\_');
  }
}
