import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mydb/models/database_type.dart';

part 'query_history_entry.freezed.dart';
part 'query_history_entry.g.dart';

@freezed
class QueryHistoryEntry with _$QueryHistoryEntry {
  const factory QueryHistoryEntry({
    required String id,
    required String connectionId,
    required DatabaseType databaseType,
    required String sql,
    required DateTime executedAt,
    int? durationMs,
    @Default(false) bool success,
  }) = _QueryHistoryEntry;

  factory QueryHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$QueryHistoryEntryFromJson(json);
}
