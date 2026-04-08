// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImportConfigImpl _$$ImportConfigImplFromJson(Map<String, dynamic> json) =>
    _$ImportConfigImpl(
      sourceKind: $enumDecode(_$ImportSourceKindEnumMap, json['sourceKind']),
      sourcePath: json['sourcePath'] as String,
      targetSchema: json['targetSchema'] as String,
      targetTable: json['targetTable'] as String,
      firstRowIsHeader: json['firstRowIsHeader'] as bool? ?? true,
      continueOnRowError: json['continueOnRowError'] as bool? ?? true,
    );

Map<String, dynamic> _$$ImportConfigImplToJson(_$ImportConfigImpl instance) =>
    <String, dynamic>{
      'sourceKind': _$ImportSourceKindEnumMap[instance.sourceKind]!,
      'sourcePath': instance.sourcePath,
      'targetSchema': instance.targetSchema,
      'targetTable': instance.targetTable,
      'firstRowIsHeader': instance.firstRowIsHeader,
      'continueOnRowError': instance.continueOnRowError,
    };

const _$ImportSourceKindEnumMap = {
  ImportSourceKind.csv: 'csv',
  ImportSourceKind.xlsx: 'xlsx',
};
