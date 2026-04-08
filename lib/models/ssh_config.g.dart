// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ssh_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SSHConfigImpl _$$SSHConfigImplFromJson(Map<String, dynamic> json) =>
    _$SSHConfigImpl(
      host: json['host'] as String,
      port: (json['port'] as num?)?.toInt() ?? 22,
      username: json['username'] as String,
      privateKeyPath: json['privateKeyPath'] as String?,
      hasKeyPassphrase: json['hasKeyPassphrase'] as bool? ?? false,
    );

Map<String, dynamic> _$$SSHConfigImplToJson(_$SSHConfigImpl instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
      'username': instance.username,
      'privateKeyPath': instance.privateKeyPath,
      'hasKeyPassphrase': instance.hasKeyPassphrase,
    };
