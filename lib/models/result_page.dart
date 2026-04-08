import 'package:freezed_annotation/freezed_annotation.dart';

part 'result_page.freezed.dart';

@freezed
class ResultPage with _$ResultPage {
  const factory ResultPage({
    required int pageIndex,
    required int pageSize,
    required List<String> columns,
    required List<List<dynamic>> rows,
    /// Total rows if known; otherwise pagination continues until an empty page.
    int? totalRows,
    required Duration queryDuration,
    String? error,
  }) = _ResultPage;
}
