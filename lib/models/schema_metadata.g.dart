// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SchemaInfoImpl _$$SchemaInfoImplFromJson(Map<String, dynamic> json) =>
    _$SchemaInfoImpl(
      name: json['name'] as String,
      owner: json['owner'] as String?,
    );

Map<String, dynamic> _$$SchemaInfoImplToJson(_$SchemaInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'owner': instance.owner,
    };

_$TableInfoImpl _$$TableInfoImplFromJson(Map<String, dynamic> json) =>
    _$TableInfoImpl(
      schema: json['schema'] as String,
      name: json['name'] as String,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$$TableInfoImplToJson(_$TableInfoImpl instance) =>
    <String, dynamic>{
      'schema': instance.schema,
      'name': instance.name,
      'comment': instance.comment,
    };

_$ColumnInfoImpl _$$ColumnInfoImplFromJson(Map<String, dynamic> json) =>
    _$ColumnInfoImpl(
      name: json['name'] as String,
      dataType: json['dataType'] as String,
      ordinalPosition: (json['ordinalPosition'] as num).toInt(),
      nullable: json['nullable'] as bool? ?? true,
      defaultValue: json['defaultValue'] as String?,
      isPrimaryKey: json['isPrimaryKey'] as bool? ?? false,
    );

Map<String, dynamic> _$$ColumnInfoImplToJson(_$ColumnInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dataType': instance.dataType,
      'ordinalPosition': instance.ordinalPosition,
      'nullable': instance.nullable,
      'defaultValue': instance.defaultValue,
      'isPrimaryKey': instance.isPrimaryKey,
    };

_$IndexInfoImpl _$$IndexInfoImplFromJson(Map<String, dynamic> json) =>
    _$IndexInfoImpl(
      name: json['name'] as String,
      unique: json['unique'] as bool,
      columnNames: (json['columnNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      filterCondition: json['filterCondition'] as String?,
    );

Map<String, dynamic> _$$IndexInfoImplToJson(_$IndexInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'unique': instance.unique,
      'columnNames': instance.columnNames,
      'filterCondition': instance.filterCondition,
    };

_$ForeignKeyInfoImpl _$$ForeignKeyInfoImplFromJson(Map<String, dynamic> json) =>
    _$ForeignKeyInfoImpl(
      name: json['name'] as String,
      column: json['column'] as String,
      referencedSchema: json['referencedSchema'] as String,
      referencedTable: json['referencedTable'] as String,
      referencedColumn: json['referencedColumn'] as String,
      onUpdate: json['onUpdate'] as String?,
      onDelete: json['onDelete'] as String?,
    );

Map<String, dynamic> _$$ForeignKeyInfoImplToJson(
        _$ForeignKeyInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'column': instance.column,
      'referencedSchema': instance.referencedSchema,
      'referencedTable': instance.referencedTable,
      'referencedColumn': instance.referencedColumn,
      'onUpdate': instance.onUpdate,
      'onDelete': instance.onDelete,
    };

_$ViewInfoImpl _$$ViewInfoImplFromJson(Map<String, dynamic> json) =>
    _$ViewInfoImpl(
      schema: json['schema'] as String,
      name: json['name'] as String,
      definition: json['definition'] as String?,
    );

Map<String, dynamic> _$$ViewInfoImplToJson(_$ViewInfoImpl instance) =>
    <String, dynamic>{
      'schema': instance.schema,
      'name': instance.name,
      'definition': instance.definition,
    };

_$RoutineInfoImpl _$$RoutineInfoImplFromJson(Map<String, dynamic> json) =>
    _$RoutineInfoImpl(
      schema: json['schema'] as String,
      name: json['name'] as String,
      kind: json['kind'] as String,
      language: json['language'] as String?,
      returnType: json['returnType'] as String?,
    );

Map<String, dynamic> _$$RoutineInfoImplToJson(_$RoutineInfoImpl instance) =>
    <String, dynamic>{
      'schema': instance.schema,
      'name': instance.name,
      'kind': instance.kind,
      'language': instance.language,
      'returnType': instance.returnType,
    };

_$SchemaMetadataImpl _$$SchemaMetadataImplFromJson(Map<String, dynamic> json) =>
    _$SchemaMetadataImpl(
      schemas: (json['schemas'] as List<dynamic>?)
              ?.map((e) => SchemaInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tables: (json['tables'] as List<dynamic>?)
              ?.map((e) => TableInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      views: (json['views'] as List<dynamic>?)
              ?.map((e) => ViewInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SchemaMetadataImplToJson(
        _$SchemaMetadataImpl instance) =>
    <String, dynamic>{
      'schemas': instance.schemas,
      'tables': instance.tables,
      'views': instance.views,
    };
