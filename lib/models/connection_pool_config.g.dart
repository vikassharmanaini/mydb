// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_pool_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectionPoolConfigImpl _$$ConnectionPoolConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectionPoolConfigImpl(
      minSize: (json['minSize'] as num?)?.toInt() ?? 1,
      maxSize: (json['maxSize'] as num?)?.toInt() ?? 10,
      idleTimeoutSeconds: (json['idleTimeoutSeconds'] as num?)?.toInt() ?? 30,
    );

Map<String, dynamic> _$$ConnectionPoolConfigImplToJson(
        _$ConnectionPoolConfigImpl instance) =>
    <String, dynamic>{
      'minSize': instance.minSize,
      'maxSize': instance.maxSize,
      'idleTimeoutSeconds': instance.idleTimeoutSeconds,
    };
