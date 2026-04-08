// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ResultPage {
  int get pageIndex => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  List<String> get columns => throw _privateConstructorUsedError;
  List<List<dynamic>> get rows => throw _privateConstructorUsedError;

  /// Total rows if known; otherwise pagination continues until an empty page.
  int? get totalRows => throw _privateConstructorUsedError;
  Duration get queryDuration => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of ResultPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResultPageCopyWith<ResultPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultPageCopyWith<$Res> {
  factory $ResultPageCopyWith(
          ResultPage value, $Res Function(ResultPage) then) =
      _$ResultPageCopyWithImpl<$Res, ResultPage>;
  @useResult
  $Res call(
      {int pageIndex,
      int pageSize,
      List<String> columns,
      List<List<dynamic>> rows,
      int? totalRows,
      Duration queryDuration,
      String? error});
}

/// @nodoc
class _$ResultPageCopyWithImpl<$Res, $Val extends ResultPage>
    implements $ResultPageCopyWith<$Res> {
  _$ResultPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResultPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageIndex = null,
    Object? pageSize = null,
    Object? columns = null,
    Object? rows = null,
    Object? totalRows = freezed,
    Object? queryDuration = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      pageIndex: null == pageIndex
          ? _value.pageIndex
          : pageIndex // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      columns: null == columns
          ? _value.columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<List<dynamic>>,
      totalRows: freezed == totalRows
          ? _value.totalRows
          : totalRows // ignore: cast_nullable_to_non_nullable
              as int?,
      queryDuration: null == queryDuration
          ? _value.queryDuration
          : queryDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResultPageImplCopyWith<$Res>
    implements $ResultPageCopyWith<$Res> {
  factory _$$ResultPageImplCopyWith(
          _$ResultPageImpl value, $Res Function(_$ResultPageImpl) then) =
      __$$ResultPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int pageIndex,
      int pageSize,
      List<String> columns,
      List<List<dynamic>> rows,
      int? totalRows,
      Duration queryDuration,
      String? error});
}

/// @nodoc
class __$$ResultPageImplCopyWithImpl<$Res>
    extends _$ResultPageCopyWithImpl<$Res, _$ResultPageImpl>
    implements _$$ResultPageImplCopyWith<$Res> {
  __$$ResultPageImplCopyWithImpl(
      _$ResultPageImpl _value, $Res Function(_$ResultPageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResultPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageIndex = null,
    Object? pageSize = null,
    Object? columns = null,
    Object? rows = null,
    Object? totalRows = freezed,
    Object? queryDuration = null,
    Object? error = freezed,
  }) {
    return _then(_$ResultPageImpl(
      pageIndex: null == pageIndex
          ? _value.pageIndex
          : pageIndex // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      columns: null == columns
          ? _value._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<List<dynamic>>,
      totalRows: freezed == totalRows
          ? _value.totalRows
          : totalRows // ignore: cast_nullable_to_non_nullable
              as int?,
      queryDuration: null == queryDuration
          ? _value.queryDuration
          : queryDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ResultPageImpl implements _ResultPage {
  const _$ResultPageImpl(
      {required this.pageIndex,
      required this.pageSize,
      required final List<String> columns,
      required final List<List<dynamic>> rows,
      this.totalRows,
      required this.queryDuration,
      this.error})
      : _columns = columns,
        _rows = rows;

  @override
  final int pageIndex;
  @override
  final int pageSize;
  final List<String> _columns;
  @override
  List<String> get columns {
    if (_columns is EqualUnmodifiableListView) return _columns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_columns);
  }

  final List<List<dynamic>> _rows;
  @override
  List<List<dynamic>> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  /// Total rows if known; otherwise pagination continues until an empty page.
  @override
  final int? totalRows;
  @override
  final Duration queryDuration;
  @override
  final String? error;

  @override
  String toString() {
    return 'ResultPage(pageIndex: $pageIndex, pageSize: $pageSize, columns: $columns, rows: $rows, totalRows: $totalRows, queryDuration: $queryDuration, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultPageImpl &&
            (identical(other.pageIndex, pageIndex) ||
                other.pageIndex == pageIndex) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            const DeepCollectionEquality().equals(other._columns, _columns) &&
            const DeepCollectionEquality().equals(other._rows, _rows) &&
            (identical(other.totalRows, totalRows) ||
                other.totalRows == totalRows) &&
            (identical(other.queryDuration, queryDuration) ||
                other.queryDuration == queryDuration) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageIndex,
      pageSize,
      const DeepCollectionEquality().hash(_columns),
      const DeepCollectionEquality().hash(_rows),
      totalRows,
      queryDuration,
      error);

  /// Create a copy of ResultPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultPageImplCopyWith<_$ResultPageImpl> get copyWith =>
      __$$ResultPageImplCopyWithImpl<_$ResultPageImpl>(this, _$identity);
}

abstract class _ResultPage implements ResultPage {
  const factory _ResultPage(
      {required final int pageIndex,
      required final int pageSize,
      required final List<String> columns,
      required final List<List<dynamic>> rows,
      final int? totalRows,
      required final Duration queryDuration,
      final String? error}) = _$ResultPageImpl;

  @override
  int get pageIndex;
  @override
  int get pageSize;
  @override
  List<String> get columns;
  @override
  List<List<dynamic>> get rows;

  /// Total rows if known; otherwise pagination continues until an empty page.
  @override
  int? get totalRows;
  @override
  Duration get queryDuration;
  @override
  String? get error;

  /// Create a copy of ResultPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResultPageImplCopyWith<_$ResultPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
