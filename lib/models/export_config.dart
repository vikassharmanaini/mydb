import 'package:freezed_annotation/freezed_annotation.dart';

part 'export_config.freezed.dart';
part 'export_config.g.dart';

@JsonEnum(alwaysCreate: true)
enum ExportFormat {
  csv,
  json,
  xlsx,
  sqlInsert,
}

@freezed
class ExportConfig with _$ExportConfig {
  const factory ExportConfig({
    required ExportFormat format,
    required String outputPath,
    @Default(true) bool includeHeaders,
    @Default(5000) int batchSize,
  }) = _ExportConfig;

  factory ExportConfig.fromJson(Map<String, dynamic> json) =>
      _$ExportConfigFromJson(json);
}
