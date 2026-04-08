// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectionProfileImpl _$$ConnectionProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectionProfileImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$DatabaseTypeEnumMap, json['type']),
      host: json['host'] as String,
      port: (json['port'] as num).toInt(),
      database: json['database'] as String,
      username: json['username'] as String,
      ssl: json['ssl'] == null
          ? null
          : SSLConfig.fromJson(json['ssl'] as Map<String, dynamic>),
      ssh: json['ssh'] == null
          ? null
          : SSHConfig.fromJson(json['ssh'] as Map<String, dynamic>),
      pool: json['pool'] == null
          ? const ConnectionPoolConfig()
          : ConnectionPoolConfig.fromJson(json['pool'] as Map<String, dynamic>),
      colorHex: json['colorHex'] as String? ?? '#1565C0',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ConnectionProfileImplToJson(
        _$ConnectionProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$DatabaseTypeEnumMap[instance.type]!,
      'host': instance.host,
      'port': instance.port,
      'database': instance.database,
      'username': instance.username,
      'ssl': instance.ssl,
      'ssh': instance.ssh,
      'pool': instance.pool,
      'colorHex': instance.colorHex,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$DatabaseTypeEnumMap = {
  DatabaseType.postgres: 'postgres',
  DatabaseType.mysql: 'mysql',
  DatabaseType.sqlite: 'sqlite',
  DatabaseType.mssql: 'mssql',
};
