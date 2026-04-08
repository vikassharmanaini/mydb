import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_result.freezed.dart';

@freezed
class ResultRow with _$ResultRow {
  const factory ResultRow({
    required List<dynamic> values,
  }) = _ResultRow;
}

@freezed
class QueryResult with _$QueryResult {
  const factory QueryResult({
    required List<String> columns,
    required List<ResultRow> rows,
    required Duration duration,
    int? affectedRows,
    String? errorMessage,
  }) = _QueryResult;
}
