import 'package:freezed_annotation/freezed_annotation.dart';

part 'schema_metadata.freezed.dart';
part 'schema_metadata.g.dart';

@freezed
class SchemaInfo with _$SchemaInfo {
  const factory SchemaInfo({
    required String name,
    String? owner,
  }) = _SchemaInfo;

  factory SchemaInfo.fromJson(Map<String, dynamic> json) =>
      _$SchemaInfoFromJson(json);
}

@freezed
class TableInfo with _$TableInfo {
  const factory TableInfo({
    required String schema,
    required String name,
    String? comment,
  }) = _TableInfo;

  factory TableInfo.fromJson(Map<String, dynamic> json) =>
      _$TableInfoFromJson(json);
}

@freezed
class ColumnInfo with _$ColumnInfo {
  const factory ColumnInfo({
    required String name,
    required String dataType,
    required int ordinalPosition,
    @Default(true) bool nullable,
    String? defaultValue,
    @Default(false) bool isPrimaryKey,
  }) = _ColumnInfo;

  factory ColumnInfo.fromJson(Map<String, dynamic> json) =>
      _$ColumnInfoFromJson(json);
}

@freezed
class IndexInfo with _$IndexInfo {
  const factory IndexInfo({
    required String name,
    required bool unique,
    required List<String> columnNames,
    String? filterCondition,
  }) = _IndexInfo;

  factory IndexInfo.fromJson(Map<String, dynamic> json) =>
      _$IndexInfoFromJson(json);
}

@freezed
class ForeignKeyInfo with _$ForeignKeyInfo {
  const factory ForeignKeyInfo({
    required String name,
    required String column,
    required String referencedSchema,
    required String referencedTable,
    required String referencedColumn,
    String? onUpdate,
    String? onDelete,
  }) = _ForeignKeyInfo;

  factory ForeignKeyInfo.fromJson(Map<String, dynamic> json) =>
      _$ForeignKeyInfoFromJson(json);
}

@freezed
class ViewInfo with _$ViewInfo {
  const factory ViewInfo({
    required String schema,
    required String name,
    String? definition,
  }) = _ViewInfo;

  factory ViewInfo.fromJson(Map<String, dynamic> json) =>
      _$ViewInfoFromJson(json);
}

@freezed
class RoutineInfo with _$RoutineInfo {
  const factory RoutineInfo({
    required String schema,
    required String name,
    required String kind,
    String? language,
    String? returnType,
  }) = _RoutineInfo;

  factory RoutineInfo.fromJson(Map<String, dynamic> json) =>
      _$RoutineInfoFromJson(json);
}

/// Cached snapshot of metadata for a connection (demand-loaded subsets).
@freezed
class SchemaMetadata with _$SchemaMetadata {
  const factory SchemaMetadata({
    @Default([]) List<SchemaInfo> schemas,
    @Default([]) List<TableInfo> tables,
    @Default([]) List<ViewInfo> views,
  }) = _SchemaMetadata;

  factory SchemaMetadata.fromJson(Map<String, dynamic> json) =>
      _$SchemaMetadataFromJson(json);
}
