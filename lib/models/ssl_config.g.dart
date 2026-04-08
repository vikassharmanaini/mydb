// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ssl_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SSLConfigImpl _$$SSLConfigImplFromJson(Map<String, dynamic> json) =>
    _$SSLConfigImpl(
      mode: $enumDecodeNullable(_$SslModeEnumMap, json['mode']) ??
          SslMode.require,
      caCertPath: json['caCertPath'] as String?,
      clientCertPath: json['clientCertPath'] as String?,
      clientKeyPath: json['clientKeyPath'] as String?,
    );

Map<String, dynamic> _$$SSLConfigImplToJson(_$SSLConfigImpl instance) =>
    <String, dynamic>{
      'mode': _$SslModeEnumMap[instance.mode]!,
      'caCertPath': instance.caCertPath,
      'clientCertPath': instance.clientCertPath,
      'clientKeyPath': instance.clientKeyPath,
    };

const _$SslModeEnumMap = {
  SslMode.disable: 'disable',
  SslMode.allow: 'allow',
  SslMode.require: 'require',
  SslMode.verifyFull: 'verify_full',
};
