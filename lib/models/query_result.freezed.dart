// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ResultRow {
  List<dynamic> get values => throw _privateConstructorUsedError;

  /// Create a copy of ResultRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResultRowCopyWith<ResultRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultRowCopyWith<$Res> {
  factory $ResultRowCopyWith(ResultRow value, $Res Function(ResultRow) then) =
      _$ResultRowCopyWithImpl<$Res, ResultRow>;
  @useResult
  $Res call({List<dynamic> values});
}

/// @nodoc
class _$ResultRowCopyWithImpl<$Res, $Val extends ResultRow>
    implements $ResultRowCopyWith<$Res> {
  _$ResultRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResultRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_value.copyWith(
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResultRowImplCopyWith<$Res>
    implements $ResultRowCopyWith<$Res> {
  factory _$$ResultRowImplCopyWith(
          _$ResultRowImpl value, $Res Function(_$ResultRowImpl) then) =
      __$$ResultRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<dynamic> values});
}

/// @nodoc
class __$$ResultRowImplCopyWithImpl<$Res>
    extends _$ResultRowCopyWithImpl<$Res, _$ResultRowImpl>
    implements _$$ResultRowImplCopyWith<$Res> {
  __$$ResultRowImplCopyWithImpl(
      _$ResultRowImpl _value, $Res Function(_$ResultRowImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResultRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$ResultRowImpl(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc

class _$ResultRowImpl implements _ResultRow {
  const _$ResultRowImpl({required final List<dynamic> values})
      : _values = values;

  final List<dynamic> _values;
  @override
  List<dynamic> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'ResultRow(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultRowImpl &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  /// Create a copy of ResultRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultRowImplCopyWith<_$ResultRowImpl> get copyWith =>
      __$$ResultRowImplCopyWithImpl<_$ResultRowImpl>(this, _$identity);
}

abstract class _ResultRow implements ResultRow {
  const factory _ResultRow({required final List<dynamic> values}) =
      _$ResultRowImpl;

  @override
  List<dynamic> get values;

  /// Create a copy of ResultRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResultRowImplCopyWith<_$ResultRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QueryResult {
  List<String> get columns => throw _privateConstructorUsedError;
  List<ResultRow> get rows => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  int? get affectedRows => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of QueryResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueryResultCopyWith<QueryResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryResultCopyWith<$Res> {
  factory $QueryResultCopyWith(
          QueryResult value, $Res Function(QueryResult) then) =
      _$QueryResultCopyWithImpl<$Res, QueryResult>;
  @useResult
  $Res call(
      {List<String> columns,
      List<ResultRow> rows,
      Duration duration,
      int? affectedRows,
      String? errorMessage});
}

/// @nodoc
class _$QueryResultCopyWithImpl<$Res, $Val extends QueryResult>
    implements $QueryResultCopyWith<$Res> {
  _$QueryResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueryResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? columns = null,
    Object? rows = null,
    Object? duration = null,
    Object? affectedRows = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      columns: null == columns
          ? _value.columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<ResultRow>,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      affectedRows: freezed == affectedRows
          ? _value.affectedRows
          : affectedRows // ignore: cast_nullable_to_non_nullable
              as int?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QueryResultImplCopyWith<$Res>
    implements $QueryResultCopyWith<$Res> {
  factory _$$QueryResultImplCopyWith(
          _$QueryResultImpl value, $Res Function(_$QueryResultImpl) then) =
      __$$QueryResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> columns,
      List<ResultRow> rows,
      Duration duration,
      int? affectedRows,
      String? errorMessage});
}

/// @nodoc
class __$$QueryResultImplCopyWithImpl<$Res>
    extends _$QueryResultCopyWithImpl<$Res, _$QueryResultImpl>
    implements _$$QueryResultImplCopyWith<$Res> {
  __$$QueryResultImplCopyWithImpl(
      _$QueryResultImpl _value, $Res Function(_$QueryResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueryResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? columns = null,
    Object? rows = null,
    Object? duration = null,
    Object? affectedRows = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$QueryResultImpl(
      columns: null == columns
          ? _value._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<ResultRow>,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      affectedRows: freezed == affectedRows
          ? _value.affectedRows
          : affectedRows // ignore: cast_nullable_to_non_nullable
              as int?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$QueryResultImpl implements _QueryResult {
  const _$QueryResultImpl(
      {required final List<String> columns,
      required final List<ResultRow> rows,
      required this.duration,
      this.affectedRows,
      this.errorMessage})
      : _columns = columns,
        _rows = rows;

  final List<String> _columns;
  @override
  List<String> get columns {
    if (_columns is EqualUnmodifiableListView) return _columns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_columns);
  }

  final List<ResultRow> _rows;
  @override
  List<ResultRow> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  final Duration duration;
  @override
  final int? affectedRows;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'QueryResult(columns: $columns, rows: $rows, duration: $duration, affectedRows: $affectedRows, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueryResultImpl &&
            const DeepCollectionEquality().equals(other._columns, _columns) &&
            const DeepCollectionEquality().equals(other._rows, _rows) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.affectedRows, affectedRows) ||
                other.affectedRows == affectedRows) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_columns),
      const DeepCollectionEquality().hash(_rows),
      duration,
      affectedRows,
      errorMessage);

  /// Create a copy of QueryResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryResultImplCopyWith<_$QueryResultImpl> get copyWith =>
      __$$QueryResultImplCopyWithImpl<_$QueryResultImpl>(this, _$identity);
}

abstract class _QueryResult implements QueryResult {
  const factory _QueryResult(
      {required final List<String> columns,
      required final List<ResultRow> rows,
      required final Duration duration,
      final int? affectedRows,
      final String? errorMessage}) = _$QueryResultImpl;

  @override
  List<String> get columns;
  @override
  List<ResultRow> get rows;
  @override
  Duration get duration;
  @override
  int? get affectedRows;
  @override
  String? get errorMessage;

  /// Create a copy of QueryResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueryResultImplCopyWith<_$QueryResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
