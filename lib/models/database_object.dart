import 'package:freezed_annotation/freezed_annotation.dart';

part 'database_object.freezed.dart';

/// Identifies a database object for DDL generation and tree nodes.
@freezed
sealed class DatabaseObject with _$DatabaseObject {
  const factory DatabaseObject.schema({required String name}) =
      DatabaseObjectSchema;

  const factory DatabaseObject.table({
    required String schema,
    required String name,
  }) = DatabaseObjectTable;

  const factory DatabaseObject.view({
    required String schema,
    required String name,
  }) = DatabaseObjectView;

  const factory DatabaseObject.column({
    required String schema,
    required String table,
    required String name,
  }) = DatabaseObjectColumn;

  const factory DatabaseObject.index({
    required String schema,
    required String table,
    required String name,
  }) = DatabaseObjectIndex;

  const factory DatabaseObject.foreignKey({
    required String schema,
    required String table,
    required String name,
  }) = DatabaseObjectForeignKey;

  const factory DatabaseObject.sequence({
    required String schema,
    required String name,
  }) = DatabaseObjectSequence;

  const factory DatabaseObject.trigger({
    required String schema,
    required String table,
    required String name,
  }) = DatabaseObjectTrigger;

  const factory DatabaseObject.procedure({
    required String schema,
    required String name,
  }) = DatabaseObjectProcedure;

  const factory DatabaseObject.function({
    required String schema,
    required String name,
  }) = DatabaseObjectFunction;
}
