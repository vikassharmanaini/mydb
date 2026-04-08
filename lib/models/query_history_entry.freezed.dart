// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QueryHistoryEntry _$QueryHistoryEntryFromJson(Map<String, dynamic> json) {
  return _QueryHistoryEntry.fromJson(json);
}

/// @nodoc
mixin _$QueryHistoryEntry {
  String get id => throw _privateConstructorUsedError;
  String get connectionId => throw _privateConstructorUsedError;
  DatabaseType get databaseType => throw _privateConstructorUsedError;
  String get sql => throw _privateConstructorUsedError;
  DateTime get executedAt => throw _privateConstructorUsedError;
  int? get durationMs => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;

  /// Serializes this QueryHistoryEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueryHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueryHistoryEntryCopyWith<QueryHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryHistoryEntryCopyWith<$Res> {
  factory $QueryHistoryEntryCopyWith(
          QueryHistoryEntry value, $Res Function(QueryHistoryEntry) then) =
      _$QueryHistoryEntryCopyWithImpl<$Res, QueryHistoryEntry>;
  @useResult
  $Res call(
      {String id,
      String connectionId,
      DatabaseType databaseType,
      String sql,
      DateTime executedAt,
      int? durationMs,
      bool success});
}

/// @nodoc
class _$QueryHistoryEntryCopyWithImpl<$Res, $Val extends QueryHistoryEntry>
    implements $QueryHistoryEntryCopyWith<$Res> {
  _$QueryHistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueryHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? connectionId = null,
    Object? databaseType = null,
    Object? sql = null,
    Object? executedAt = null,
    Object? durationMs = freezed,
    Object? success = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      connectionId: null == connectionId
          ? _value.connectionId
          : connectionId // ignore: cast_nullable_to_non_nullable
              as String,
      databaseType: null == databaseType
          ? _value.databaseType
          : databaseType // ignore: cast_nullable_to_non_nullable
              as DatabaseType,
      sql: null == sql
          ? _value.sql
          : sql // ignore: cast_nullable_to_non_nullable
              as String,
      executedAt: null == executedAt
          ? _value.executedAt
          : executedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationMs: freezed == durationMs
          ? _value.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int?,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QueryHistoryEntryImplCopyWith<$Res>
    implements $QueryHistoryEntryCopyWith<$Res> {
  factory _$$QueryHistoryEntryImplCopyWith(_$QueryHistoryEntryImpl value,
          $Res Function(_$QueryHistoryEntryImpl) then) =
      __$$QueryHistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String connectionId,
      DatabaseType databaseType,
      String sql,
      DateTime executedAt,
      int? durationMs,
      bool success});
}

/// @nodoc
class __$$QueryHistoryEntryImplCopyWithImpl<$Res>
    extends _$QueryHistoryEntryCopyWithImpl<$Res, _$QueryHistoryEntryImpl>
    implements _$$QueryHistoryEntryImplCopyWith<$Res> {
  __$$QueryHistoryEntryImplCopyWithImpl(_$QueryHistoryEntryImpl _value,
      $Res Function(_$QueryHistoryEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueryHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? connectionId = null,
    Object? databaseType = null,
    Object? sql = null,
    Object? executedAt = null,
    Object? durationMs = freezed,
    Object? success = null,
  }) {
    return _then(_$QueryHistoryEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      connectionId: null == connectionId
          ? _value.connectionId
          : connectionId // ignore: cast_nullable_to_non_nullable
              as String,
      databaseType: null == databaseType
          ? _value.databaseType
          : databaseType // ignore: cast_nullable_to_non_nullable
              as DatabaseType,
      sql: null == sql
          ? _value.sql
          : sql // ignore: cast_nullable_to_non_nullable
              as String,
      executedAt: null == executedAt
          ? _value.executedAt
          : executedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationMs: freezed == durationMs
          ? _value.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int?,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QueryHistoryEntryImpl implements _QueryHistoryEntry {
  const _$QueryHistoryEntryImpl(
      {required this.id,
      required this.connectionId,
      required this.databaseType,
      required this.sql,
      required this.executedAt,
      this.durationMs,
      this.success = false});

  factory _$QueryHistoryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueryHistoryEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String connectionId;
  @override
  final DatabaseType databaseType;
  @override
  final String sql;
  @override
  final DateTime executedAt;
  @override
  final int? durationMs;
  @override
  @JsonKey()
  final bool success;

  @override
  String toString() {
    return 'QueryHistoryEntry(id: $id, connectionId: $connectionId, databaseType: $databaseType, sql: $sql, executedAt: $executedAt, durationMs: $durationMs, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueryHistoryEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.connectionId, connectionId) ||
                other.connectionId == connectionId) &&
            (identical(other.databaseType, databaseType) ||
                other.databaseType == databaseType) &&
            (identical(other.sql, sql) || other.sql == sql) &&
            (identical(other.executedAt, executedAt) ||
                other.executedAt == executedAt) &&
            (identical(other.durationMs, durationMs) ||
                other.durationMs == durationMs) &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, connectionId, databaseType,
      sql, executedAt, durationMs, success);

  /// Create a copy of QueryHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryHistoryEntryImplCopyWith<_$QueryHistoryEntryImpl> get copyWith =>
      __$$QueryHistoryEntryImplCopyWithImpl<_$QueryHistoryEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueryHistoryEntryImplToJson(
      this,
    );
  }
}

abstract class _QueryHistoryEntry implements QueryHistoryEntry {
  const factory _QueryHistoryEntry(
      {required final String id,
      required final String connectionId,
      required final DatabaseType databaseType,
      required final String sql,
      required final DateTime executedAt,
      final int? durationMs,
      final bool success}) = _$QueryHistoryEntryImpl;

  factory _QueryHistoryEntry.fromJson(Map<String, dynamic> json) =
      _$QueryHistoryEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get connectionId;
  @override
  DatabaseType get databaseType;
  @override
  String get sql;
  @override
  DateTime get executedAt;
  @override
  int? get durationMs;
  @override
  bool get success;

  /// Create a copy of QueryHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueryHistoryEntryImplCopyWith<_$QueryHistoryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
