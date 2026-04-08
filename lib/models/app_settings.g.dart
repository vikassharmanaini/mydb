// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      darkMode: json['darkMode'] as bool? ?? true,
      editorFontSize: (json['editorFontSize'] as num?)?.toDouble() ?? 13.0,
      editorTabSize: (json['editorTabSize'] as num?)?.toInt() ?? 4,
      editorLineWrap: json['editorLineWrap'] as bool? ?? false,
      editorAutocomplete: json['editorAutocomplete'] as bool? ?? true,
      gridPageSize: (json['gridPageSize'] as num?)?.toInt() ?? 500,
      gridNullDisplay: json['gridNullDisplay'] as String? ?? 'NULL',
      gridDateFormat:
          json['gridDateFormat'] as String? ?? 'yyyy-MM-dd HH:mm:ss',
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'darkMode': instance.darkMode,
      'editorFontSize': instance.editorFontSize,
      'editorTabSize': instance.editorTabSize,
      'editorLineWrap': instance.editorLineWrap,
      'editorAutocomplete': instance.editorAutocomplete,
      'gridPageSize': instance.gridPageSize,
      'gridNullDisplay': instance.gridNullDisplay,
      'gridDateFormat': instance.gridDateFormat,
    };
