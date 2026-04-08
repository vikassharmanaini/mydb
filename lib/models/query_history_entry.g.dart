// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueryHistoryEntryImpl _$$QueryHistoryEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$QueryHistoryEntryImpl(
      id: json['id'] as String,
      connectionId: json['connectionId'] as String,
      databaseType: $enumDecode(_$DatabaseTypeEnumMap, json['databaseType']),
      sql: json['sql'] as String,
      executedAt: DateTime.parse(json['executedAt'] as String),
      durationMs: (json['durationMs'] as num?)?.toInt(),
      success: json['success'] as bool? ?? false,
    );

Map<String, dynamic> _$$QueryHistoryEntryImplToJson(
        _$QueryHistoryEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'connectionId': instance.connectionId,
      'databaseType': _$DatabaseTypeEnumMap[instance.databaseType]!,
      'sql': instance.sql,
      'executedAt': instance.executedAt.toIso8601String(),
      'durationMs': instance.durationMs,
      'success': instance.success,
    };

const _$DatabaseTypeEnumMap = {
  DatabaseType.postgres: 'postgres',
  DatabaseType.mysql: 'mysql',
  DatabaseType.sqlite: 'sqlite',
  DatabaseType.mssql: 'mssql',
};
