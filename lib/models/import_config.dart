import 'package:freezed_annotation/freezed_annotation.dart';

part 'import_config.freezed.dart';
part 'import_config.g.dart';

@JsonEnum(alwaysCreate: true)
enum ImportSourceKind {
  csv,
  xlsx,
}

@freezed
class ImportConfig with _$ImportConfig {
  const factory ImportConfig({
    required ImportSourceKind sourceKind,
    required String sourcePath,
    required String targetSchema,
    required String targetTable,
    @Default(true) bool firstRowIsHeader,
    @Default(true) bool continueOnRowError,
  }) = _ImportConfig;

  factory ImportConfig.fromJson(Map<String, dynamic> json) =>
      _$ImportConfigFromJson(json);
}
