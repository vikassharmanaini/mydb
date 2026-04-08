// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExportConfigImpl _$$ExportConfigImplFromJson(Map<String, dynamic> json) =>
    _$ExportConfigImpl(
      format: $enumDecode(_$ExportFormatEnumMap, json['format']),
      outputPath: json['outputPath'] as String,
      includeHeaders: json['includeHeaders'] as bool? ?? true,
      batchSize: (json['batchSize'] as num?)?.toInt() ?? 5000,
    );

Map<String, dynamic> _$$ExportConfigImplToJson(_$ExportConfigImpl instance) =>
    <String, dynamic>{
      'format': _$ExportFormatEnumMap[instance.format]!,
      'outputPath': instance.outputPath,
      'includeHeaders': instance.includeHeaders,
      'batchSize': instance.batchSize,
    };

const _$ExportFormatEnumMap = {
  ExportFormat.csv: 'csv',
  ExportFormat.json: 'json',
  ExportFormat.xlsx: 'xlsx',
  ExportFormat.sqlInsert: 'sqlInsert',
};
