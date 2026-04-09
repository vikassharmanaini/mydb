import 'package:mydb/drivers/driver_interface.dart';
import 'package:mydb/local_db/daos/history_dao.dart';
import 'package:mydb/models/query_history_entry.dart';
import 'package:mydb/models/result_page.dart';
import 'package:uuid/uuid.dart';

/// Runs SQL through a [DatabaseDriver], tracks wall-clock duration, and
/// optionally appends to local [HistoryDao].
final class QueryService {
  QueryService({
    required DatabaseDriver driver,
    required String connectionId,
    HistoryDao? historyDao,
    this.recordHistory = true,
    this.maxSqlLengthForHistory = 256000,
    Uuid? uuid,
  })  : _driver = driver,
        _connectionId = connectionId,
        _history = historyDao,
        _uuid = uuid ?? const Uuid();

  final DatabaseDriver _driver;
  final String _connectionId;
  final HistoryDao? _history;
  final Uuid _uuid;

  /// When false, no rows are written to [HistoryDao].
  final bool recordHistory;

  /// Long statements are truncated before persistence.
  final int maxSqlLengthForHistory;

  /// Delegates to the underlying driver.
  Future<void> cancelCurrentQuery() => _driver.cancelCurrentQuery();

  /// Streams result pages; records one history row after the stream completes
  /// (success or failure). [sql] is the executed text (same as sent to driver).
  Stream<ResultPage> executeQuery(
    String sql, {
    int pageSize = 500,
  }) async* {
    final String stored = _truncateForHistory(sql);
    final Stopwatch sw = Stopwatch()..start();
    bool success = true;
    try {
      await for (final ResultPage page
          in _driver.executeQuery(sql, pageSize: pageSize)) {
        yield page;
      }
    } catch (_) {
      success = false;
      rethrow;
    } finally {
      sw.stop();
      await _persistHistory(stored, sw.elapsedMilliseconds, success);
    }
  }

  /// Runs a write statement; records history after completion.
  Future<int> executeUpdate(String sql) async {
    final String stored = _truncateForHistory(sql);
    final Stopwatch sw = Stopwatch()..start();
    bool success = true;
    try {
      return await _driver.executeUpdate(sql);
    } catch (_) {
      success = false;
      rethrow;
    } finally {
      sw.stop();
      await _persistHistory(stored, sw.elapsedMilliseconds, success);
    }
  }

  String _truncateForHistory(String sql) {
    if (sql.length <= maxSqlLengthForHistory) {
      return sql;
    }
    return sql.substring(0, maxSqlLengthForHistory);
  }

  Future<void> _persistHistory(
    String sql,
    int durationMs,
    bool success,
  ) async {
    final HistoryDao? dao = _history;
    if (!recordHistory || dao == null) {
      return;
    }
    try {
      await dao.insertEntry(
        QueryHistoryEntry(
          id: _uuid.v4(),
          connectionId: _connectionId,
          databaseType: _driver.type,
          sql: sql,
          executedAt: DateTime.now().toUtc(),
          durationMs: durationMs,
          success: success,
        ),
      );
    } catch (_) {
      /* persistence must not break queries */
    }
  }
}
