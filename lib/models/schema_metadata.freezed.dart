// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schema_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SchemaInfo _$SchemaInfoFromJson(Map<String, dynamic> json) {
  return _SchemaInfo.fromJson(json);
}

/// @nodoc
mixin _$SchemaInfo {
  String get name => throw _privateConstructorUsedError;
  String? get owner => throw _privateConstructorUsedError;

  /// Serializes this SchemaInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SchemaInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SchemaInfoCopyWith<SchemaInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchemaInfoCopyWith<$Res> {
  factory $SchemaInfoCopyWith(
          SchemaInfo value, $Res Function(SchemaInfo) then) =
      _$SchemaInfoCopyWithImpl<$Res, SchemaInfo>;
  @useResult
  $Res call({String name, String? owner});
}

/// @nodoc
class _$SchemaInfoCopyWithImpl<$Res, $Val extends SchemaInfo>
    implements $SchemaInfoCopyWith<$Res> {
  _$SchemaInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SchemaInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? owner = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      owner: freezed == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SchemaInfoImplCopyWith<$Res>
    implements $SchemaInfoCopyWith<$Res> {
  factory _$$SchemaInfoImplCopyWith(
          _$SchemaInfoImpl value, $Res Function(_$SchemaInfoImpl) then) =
      __$$SchemaInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? owner});
}

/// @nodoc
class __$$SchemaInfoImplCopyWithImpl<$Res>
    extends _$SchemaInfoCopyWithImpl<$Res, _$SchemaInfoImpl>
    implements _$$SchemaInfoImplCopyWith<$Res> {
  __$$SchemaInfoImplCopyWithImpl(
      _$SchemaInfoImpl _value, $Res Function(_$SchemaInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of SchemaInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? owner = freezed,
  }) {
    return _then(_$SchemaInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      owner: freezed == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SchemaInfoImpl implements _SchemaInfo {
  const _$SchemaInfoImpl({required this.name, this.owner});

  factory _$SchemaInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SchemaInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String? owner;

  @override
  String toString() {
    return 'SchemaInfo(name: $name, owner: $owner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SchemaInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.owner, owner) || other.owner == owner));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, owner);

  /// Create a copy of SchemaInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SchemaInfoImplCopyWith<_$SchemaInfoImpl> get copyWith =>
      __$$SchemaInfoImplCopyWithImpl<_$SchemaInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SchemaInfoImplToJson(
      this,
    );
  }
}

abstract class _SchemaInfo implements SchemaInfo {
  const factory _SchemaInfo({required final String name, final String? owner}) =
      _$SchemaInfoImpl;

  factory _SchemaInfo.fromJson(Map<String, dynamic> json) =
      _$SchemaInfoImpl.fromJson;

  @override
  String get name;
  @override
  String? get owner;

  /// Create a copy of SchemaInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SchemaInfoImplCopyWith<_$SchemaInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TableInfo _$TableInfoFromJson(Map<String, dynamic> json) {
  return _TableInfo.fromJson(json);
}

/// @nodoc
mixin _$TableInfo {
  String get schema => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;

  /// Serializes this TableInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TableInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableInfoCopyWith<TableInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableInfoCopyWith<$Res> {
  factory $TableInfoCopyWith(TableInfo value, $Res Function(TableInfo) then) =
      _$TableInfoCopyWithImpl<$Res, TableInfo>;
  @useResult
  $Res call({String schema, String name, String? comment});
}

/// @nodoc
class _$TableInfoCopyWithImpl<$Res, $Val extends TableInfo>
    implements $TableInfoCopyWith<$Res> {
  _$TableInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? name = null,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TableInfoImplCopyWith<$Res>
    implements $TableInfoCopyWith<$Res> {
  factory _$$TableInfoImplCopyWith(
          _$TableInfoImpl value, $Res Function(_$TableInfoImpl) then) =
      __$$TableInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String schema, String name, String? comment});
}

/// @nodoc
class __$$TableInfoImplCopyWithImpl<$Res>
    extends _$TableInfoCopyWithImpl<$Res, _$TableInfoImpl>
    implements _$$TableInfoImplCopyWith<$Res> {
  __$$TableInfoImplCopyWithImpl(
      _$TableInfoImpl _value, $Res Function(_$TableInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of TableInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? name = null,
    Object? comment = freezed,
  }) {
    return _then(_$TableInfoImpl(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TableInfoImpl implements _TableInfo {
  const _$TableInfoImpl(
      {required this.schema, required this.name, this.comment});

  factory _$TableInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TableInfoImplFromJson(json);

  @override
  final String schema;
  @override
  final String name;
  @override
  final String? comment;

  @override
  String toString() {
    return 'TableInfo(schema: $schema, name: $name, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableInfoImpl &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, schema, name, comment);

  /// Create a copy of TableInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableInfoImplCopyWith<_$TableInfoImpl> get copyWith =>
      __$$TableInfoImplCopyWithImpl<_$TableInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TableInfoImplToJson(
      this,
    );
  }
}

abstract class _TableInfo implements TableInfo {
  const factory _TableInfo(
      {required final String schema,
      required final String name,
      final String? comment}) = _$TableInfoImpl;

  factory _TableInfo.fromJson(Map<String, dynamic> json) =
      _$TableInfoImpl.fromJson;

  @override
  String get schema;
  @override
  String get name;
  @override
  String? get comment;

  /// Create a copy of TableInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableInfoImplCopyWith<_$TableInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ColumnInfo _$ColumnInfoFromJson(Map<String, dynamic> json) {
  return _ColumnInfo.fromJson(json);
}

/// @nodoc
mixin _$ColumnInfo {
  String get name => throw _privateConstructorUsedError;
  String get dataType => throw _privateConstructorUsedError;
  int get ordinalPosition => throw _privateConstructorUsedError;
  bool get nullable => throw _privateConstructorUsedError;
  String? get defaultValue => throw _privateConstructorUsedError;
  bool get isPrimaryKey => throw _privateConstructorUsedError;

  /// Serializes this ColumnInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ColumnInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ColumnInfoCopyWith<ColumnInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColumnInfoCopyWith<$Res> {
  factory $ColumnInfoCopyWith(
          ColumnInfo value, $Res Function(ColumnInfo) then) =
      _$ColumnInfoCopyWithImpl<$Res, ColumnInfo>;
  @useResult
  $Res call(
      {String name,
      String dataType,
      int ordinalPosition,
      bool nullable,
      String? defaultValue,
      bool isPrimaryKey});
}

/// @nodoc
class _$ColumnInfoCopyWithImpl<$Res, $Val extends ColumnInfo>
    implements $ColumnInfoCopyWith<$Res> {
  _$ColumnInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ColumnInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? dataType = null,
    Object? ordinalPosition = null,
    Object? nullable = null,
    Object? defaultValue = freezed,
    Object? isPrimaryKey = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dataType: null == dataType
          ? _value.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as String,
      ordinalPosition: null == ordinalPosition
          ? _value.ordinalPosition
          : ordinalPosition // ignore: cast_nullable_to_non_nullable
              as int,
      nullable: null == nullable
          ? _value.nullable
          : nullable // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrimaryKey: null == isPrimaryKey
          ? _value.isPrimaryKey
          : isPrimaryKey // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ColumnInfoImplCopyWith<$Res>
    implements $ColumnInfoCopyWith<$Res> {
  factory _$$ColumnInfoImplCopyWith(
          _$ColumnInfoImpl value, $Res Function(_$ColumnInfoImpl) then) =
      __$$ColumnInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String dataType,
      int ordinalPosition,
      bool nullable,
      String? defaultValue,
      bool isPrimaryKey});
}

/// @nodoc
class __$$ColumnInfoImplCopyWithImpl<$Res>
    extends _$ColumnInfoCopyWithImpl<$Res, _$ColumnInfoImpl>
    implements _$$ColumnInfoImplCopyWith<$Res> {
  __$$ColumnInfoImplCopyWithImpl(
      _$ColumnInfoImpl _value, $Res Function(_$ColumnInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ColumnInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? dataType = null,
    Object? ordinalPosition = null,
    Object? nullable = null,
    Object? defaultValue = freezed,
    Object? isPrimaryKey = null,
  }) {
    return _then(_$ColumnInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dataType: null == dataType
          ? _value.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as String,
      ordinalPosition: null == ordinalPosition
          ? _value.ordinalPosition
          : ordinalPosition // ignore: cast_nullable_to_non_nullable
              as int,
      nullable: null == nullable
          ? _value.nullable
          : nullable // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrimaryKey: null == isPrimaryKey
          ? _value.isPrimaryKey
          : isPrimaryKey // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ColumnInfoImpl implements _ColumnInfo {
  const _$ColumnInfoImpl(
      {required this.name,
      required this.dataType,
      required this.ordinalPosition,
      this.nullable = true,
      this.defaultValue,
      this.isPrimaryKey = false});

  factory _$ColumnInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColumnInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String dataType;
  @override
  final int ordinalPosition;
  @override
  @JsonKey()
  final bool nullable;
  @override
  final String? defaultValue;
  @override
  @JsonKey()
  final bool isPrimaryKey;

  @override
  String toString() {
    return 'ColumnInfo(name: $name, dataType: $dataType, ordinalPosition: $ordinalPosition, nullable: $nullable, defaultValue: $defaultValue, isPrimaryKey: $isPrimaryKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ColumnInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dataType, dataType) ||
                other.dataType == dataType) &&
            (identical(other.ordinalPosition, ordinalPosition) ||
                other.ordinalPosition == ordinalPosition) &&
            (identical(other.nullable, nullable) ||
                other.nullable == nullable) &&
            (identical(other.defaultValue, defaultValue) ||
                other.defaultValue == defaultValue) &&
            (identical(other.isPrimaryKey, isPrimaryKey) ||
                other.isPrimaryKey == isPrimaryKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, dataType, ordinalPosition,
      nullable, defaultValue, isPrimaryKey);

  /// Create a copy of ColumnInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ColumnInfoImplCopyWith<_$ColumnInfoImpl> get copyWith =>
      __$$ColumnInfoImplCopyWithImpl<_$ColumnInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ColumnInfoImplToJson(
      this,
    );
  }
}

abstract class _ColumnInfo implements ColumnInfo {
  const factory _ColumnInfo(
      {required final String name,
      required final String dataType,
      required final int ordinalPosition,
      final bool nullable,
      final String? defaultValue,
      final bool isPrimaryKey}) = _$ColumnInfoImpl;

  factory _ColumnInfo.fromJson(Map<String, dynamic> json) =
      _$ColumnInfoImpl.fromJson;

  @override
  String get name;
  @override
  String get dataType;
  @override
  int get ordinalPosition;
  @override
  bool get nullable;
  @override
  String? get defaultValue;
  @override
  bool get isPrimaryKey;

  /// Create a copy of ColumnInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ColumnInfoImplCopyWith<_$ColumnInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IndexInfo _$IndexInfoFromJson(Map<String, dynamic> json) {
  return _IndexInfo.fromJson(json);
}

/// @nodoc
mixin _$IndexInfo {
  String get name => throw _privateConstructorUsedError;
  bool get unique => throw _privateConstructorUsedError;
  List<String> get columnNames => throw _privateConstructorUsedError;
  String? get filterCondition => throw _privateConstructorUsedError;

  /// Serializes this IndexInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IndexInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IndexInfoCopyWith<IndexInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IndexInfoCopyWith<$Res> {
  factory $IndexInfoCopyWith(IndexInfo value, $Res Function(IndexInfo) then) =
      _$IndexInfoCopyWithImpl<$Res, IndexInfo>;
  @useResult
  $Res call(
      {String name,
      bool unique,
      List<String> columnNames,
      String? filterCondition});
}

/// @nodoc
class _$IndexInfoCopyWithImpl<$Res, $Val extends IndexInfo>
    implements $IndexInfoCopyWith<$Res> {
  _$IndexInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IndexInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? unique = null,
    Object? columnNames = null,
    Object? filterCondition = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unique: null == unique
          ? _value.unique
          : unique // ignore: cast_nullable_to_non_nullable
              as bool,
      columnNames: null == columnNames
          ? _value.columnNames
          : columnNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      filterCondition: freezed == filterCondition
          ? _value.filterCondition
          : filterCondition // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IndexInfoImplCopyWith<$Res>
    implements $IndexInfoCopyWith<$Res> {
  factory _$$IndexInfoImplCopyWith(
          _$IndexInfoImpl value, $Res Function(_$IndexInfoImpl) then) =
      __$$IndexInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      bool unique,
      List<String> columnNames,
      String? filterCondition});
}

/// @nodoc
class __$$IndexInfoImplCopyWithImpl<$Res>
    extends _$IndexInfoCopyWithImpl<$Res, _$IndexInfoImpl>
    implements _$$IndexInfoImplCopyWith<$Res> {
  __$$IndexInfoImplCopyWithImpl(
      _$IndexInfoImpl _value, $Res Function(_$IndexInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of IndexInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? unique = null,
    Object? columnNames = null,
    Object? filterCondition = freezed,
  }) {
    return _then(_$IndexInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unique: null == unique
          ? _value.unique
          : unique // ignore: cast_nullable_to_non_nullable
              as bool,
      columnNames: null == columnNames
          ? _value._columnNames
          : columnNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      filterCondition: freezed == filterCondition
          ? _value.filterCondition
          : filterCondition // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IndexInfoImpl implements _IndexInfo {
  const _$IndexInfoImpl(
      {required this.name,
      required this.unique,
      required final List<String> columnNames,
      this.filterCondition})
      : _columnNames = columnNames;

  factory _$IndexInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$IndexInfoImplFromJson(json);

  @override
  final String name;
  @override
  final bool unique;
  final List<String> _columnNames;
  @override
  List<String> get columnNames {
    if (_columnNames is EqualUnmodifiableListView) return _columnNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_columnNames);
  }

  @override
  final String? filterCondition;

  @override
  String toString() {
    return 'IndexInfo(name: $name, unique: $unique, columnNames: $columnNames, filterCondition: $filterCondition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IndexInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unique, unique) || other.unique == unique) &&
            const DeepCollectionEquality()
                .equals(other._columnNames, _columnNames) &&
            (identical(other.filterCondition, filterCondition) ||
                other.filterCondition == filterCondition));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, unique,
      const DeepCollectionEquality().hash(_columnNames), filterCondition);

  /// Create a copy of IndexInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IndexInfoImplCopyWith<_$IndexInfoImpl> get copyWith =>
      __$$IndexInfoImplCopyWithImpl<_$IndexInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IndexInfoImplToJson(
      this,
    );
  }
}

abstract class _IndexInfo implements IndexInfo {
  const factory _IndexInfo(
      {required final String name,
      required final bool unique,
      required final List<String> columnNames,
      final String? filterCondition}) = _$IndexInfoImpl;

  factory _IndexInfo.fromJson(Map<String, dynamic> json) =
      _$IndexInfoImpl.fromJson;

  @override
  String get name;
  @override
  bool get unique;
  @override
  List<String> get columnNames;
  @override
  String? get filterCondition;

  /// Create a copy of IndexInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IndexInfoImplCopyWith<_$IndexInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForeignKeyInfo _$ForeignKeyInfoFromJson(Map<String, dynamic> json) {
  return _ForeignKeyInfo.fromJson(json);
}

/// @nodoc
mixin _$ForeignKeyInfo {
  String get name => throw _privateConstructorUsedError;
  String get column => throw _privateConstructorUsedError;
  String get referencedSchema => throw _privateConstructorUsedError;
  String get referencedTable => throw _privateConstructorUsedError;
  String get referencedColumn => throw _privateConstructorUsedError;
  String? get onUpdate => throw _privateConstructorUsedError;
  String? get onDelete => throw _privateConstructorUsedError;

  /// Serializes this ForeignKeyInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForeignKeyInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForeignKeyInfoCopyWith<ForeignKeyInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForeignKeyInfoCopyWith<$Res> {
  factory $ForeignKeyInfoCopyWith(
          ForeignKeyInfo value, $Res Function(ForeignKeyInfo) then) =
      _$ForeignKeyInfoCopyWithImpl<$Res, ForeignKeyInfo>;
  @useResult
  $Res call(
      {String name,
      String column,
      String referencedSchema,
      String referencedTable,
      String referencedColumn,
      String? onUpdate,
      String? onDelete});
}

/// @nodoc
class _$ForeignKeyInfoCopyWithImpl<$Res, $Val extends ForeignKeyInfo>
    implements $ForeignKeyInfoCopyWith<$Res> {
  _$ForeignKeyInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForeignKeyInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? column = null,
    Object? referencedSchema = null,
    Object? referencedTable = null,
    Object? referencedColumn = null,
    Object? onUpdate = freezed,
    Object? onDelete = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      column: null == column
          ? _value.column
          : column // ignore: cast_nullable_to_non_nullable
              as String,
      referencedSchema: null == referencedSchema
          ? _value.referencedSchema
          : referencedSchema // ignore: cast_nullable_to_non_nullable
              as String,
      referencedTable: null == referencedTable
          ? _value.referencedTable
          : referencedTable // ignore: cast_nullable_to_non_nullable
              as String,
      referencedColumn: null == referencedColumn
          ? _value.referencedColumn
          : referencedColumn // ignore: cast_nullable_to_non_nullable
              as String,
      onUpdate: freezed == onUpdate
          ? _value.onUpdate
          : onUpdate // ignore: cast_nullable_to_non_nullable
              as String?,
      onDelete: freezed == onDelete
          ? _value.onDelete
          : onDelete // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForeignKeyInfoImplCopyWith<$Res>
    implements $ForeignKeyInfoCopyWith<$Res> {
  factory _$$ForeignKeyInfoImplCopyWith(_$ForeignKeyInfoImpl value,
          $Res Function(_$ForeignKeyInfoImpl) then) =
      __$$ForeignKeyInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String column,
      String referencedSchema,
      String referencedTable,
      String referencedColumn,
      String? onUpdate,
      String? onDelete});
}

/// @nodoc
class __$$ForeignKeyInfoImplCopyWithImpl<$Res>
    extends _$ForeignKeyInfoCopyWithImpl<$Res, _$ForeignKeyInfoImpl>
    implements _$$ForeignKeyInfoImplCopyWith<$Res> {
  __$$ForeignKeyInfoImplCopyWithImpl(
      _$ForeignKeyInfoImpl _value, $Res Function(_$ForeignKeyInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ForeignKeyInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? column = null,
    Object? referencedSchema = null,
    Object? referencedTable = null,
    Object? referencedColumn = null,
    Object? onUpdate = freezed,
    Object? onDelete = freezed,
  }) {
    return _then(_$ForeignKeyInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      column: null == column
          ? _value.column
          : column // ignore: cast_nullable_to_non_nullable
              as String,
      referencedSchema: null == referencedSchema
          ? _value.referencedSchema
          : referencedSchema // ignore: cast_nullable_to_non_nullable
              as String,
      referencedTable: null == referencedTable
          ? _value.referencedTable
          : referencedTable // ignore: cast_nullable_to_non_nullable
              as String,
      referencedColumn: null == referencedColumn
          ? _value.referencedColumn
          : referencedColumn // ignore: cast_nullable_to_non_nullable
              as String,
      onUpdate: freezed == onUpdate
          ? _value.onUpdate
          : onUpdate // ignore: cast_nullable_to_non_nullable
              as String?,
      onDelete: freezed == onDelete
          ? _value.onDelete
          : onDelete // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForeignKeyInfoImpl implements _ForeignKeyInfo {
  const _$ForeignKeyInfoImpl(
      {required this.name,
      required this.column,
      required this.referencedSchema,
      required this.referencedTable,
      required this.referencedColumn,
      this.onUpdate,
      this.onDelete});

  factory _$ForeignKeyInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForeignKeyInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String column;
  @override
  final String referencedSchema;
  @override
  final String referencedTable;
  @override
  final String referencedColumn;
  @override
  final String? onUpdate;
  @override
  final String? onDelete;

  @override
  String toString() {
    return 'ForeignKeyInfo(name: $name, column: $column, referencedSchema: $referencedSchema, referencedTable: $referencedTable, referencedColumn: $referencedColumn, onUpdate: $onUpdate, onDelete: $onDelete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForeignKeyInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.column, column) || other.column == column) &&
            (identical(other.referencedSchema, referencedSchema) ||
                other.referencedSchema == referencedSchema) &&
            (identical(other.referencedTable, referencedTable) ||
                other.referencedTable == referencedTable) &&
            (identical(other.referencedColumn, referencedColumn) ||
                other.referencedColumn == referencedColumn) &&
            (identical(other.onUpdate, onUpdate) ||
                other.onUpdate == onUpdate) &&
            (identical(other.onDelete, onDelete) ||
                other.onDelete == onDelete));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, column, referencedSchema,
      referencedTable, referencedColumn, onUpdate, onDelete);

  /// Create a copy of ForeignKeyInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForeignKeyInfoImplCopyWith<_$ForeignKeyInfoImpl> get copyWith =>
      __$$ForeignKeyInfoImplCopyWithImpl<_$ForeignKeyInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForeignKeyInfoImplToJson(
      this,
    );
  }
}

abstract class _ForeignKeyInfo implements ForeignKeyInfo {
  const factory _ForeignKeyInfo(
      {required final String name,
      required final String column,
      required final String referencedSchema,
      required final String referencedTable,
      required final String referencedColumn,
      final String? onUpdate,
      final String? onDelete}) = _$ForeignKeyInfoImpl;

  factory _ForeignKeyInfo.fromJson(Map<String, dynamic> json) =
      _$ForeignKeyInfoImpl.fromJson;

  @override
  String get name;
  @override
  String get column;
  @override
  String get referencedSchema;
  @override
  String get referencedTable;
  @override
  String get referencedColumn;
  @override
  String? get onUpdate;
  @override
  String? get onDelete;

  /// Create a copy of ForeignKeyInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForeignKeyInfoImplCopyWith<_$ForeignKeyInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ViewInfo _$ViewInfoFromJson(Map<String, dynamic> json) {
  return _ViewInfo.fromJson(json);
}

/// @nodoc
mixin _$ViewInfo {
  String get schema => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get definition => throw _privateConstructorUsedError;

  /// Serializes this ViewInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ViewInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ViewInfoCopyWith<ViewInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewInfoCopyWith<$Res> {
  factory $ViewInfoCopyWith(ViewInfo value, $Res Function(ViewInfo) then) =
      _$ViewInfoCopyWithImpl<$Res, ViewInfo>;
  @useResult
  $Res call({String schema, String name, String? definition});
}

/// @nodoc
class _$ViewInfoCopyWithImpl<$Res, $Val extends ViewInfo>
    implements $ViewInfoCopyWith<$Res> {
  _$ViewInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ViewInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? name = null,
    Object? definition = freezed,
  }) {
    return _then(_value.copyWith(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      definition: freezed == definition
          ? _value.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ViewInfoImplCopyWith<$Res>
    implements $ViewInfoCopyWith<$Res> {
  factory _$$ViewInfoImplCopyWith(
          _$ViewInfoImpl value, $Res Function(_$ViewInfoImpl) then) =
      __$$ViewInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String schema, String name, String? definition});
}

/// @nodoc
class __$$ViewInfoImplCopyWithImpl<$Res>
    extends _$ViewInfoCopyWithImpl<$Res, _$ViewInfoImpl>
    implements _$$ViewInfoImplCopyWith<$Res> {
  __$$ViewInfoImplCopyWithImpl(
      _$ViewInfoImpl _value, $Res Function(_$ViewInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ViewInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? name = null,
    Object? definition = freezed,
  }) {
    return _then(_$ViewInfoImpl(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      definition: freezed == definition
          ? _value.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ViewInfoImpl implements _ViewInfo {
  const _$ViewInfoImpl(
      {required this.schema, required this.name, this.definition});

  factory _$ViewInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ViewInfoImplFromJson(json);

  @override
  final String schema;
  @override
  final String name;
  @override
  final String? definition;

  @override
  String toString() {
    return 'ViewInfo(schema: $schema, name: $name, definition: $definition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViewInfoImpl &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.definition, definition) ||
                other.definition == definition));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, schema, name, definition);

  /// Create a copy of ViewInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewInfoImplCopyWith<_$ViewInfoImpl> get copyWith =>
      __$$ViewInfoImplCopyWithImpl<_$ViewInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ViewInfoImplToJson(
      this,
    );
  }
}

abstract class _ViewInfo implements ViewInfo {
  const factory _ViewInfo(
      {required final String schema,
      required final String name,
      final String? definition}) = _$ViewInfoImpl;

  factory _ViewInfo.fromJson(Map<String, dynamic> json) =
      _$ViewInfoImpl.fromJson;

  @override
  String get schema;
  @override
  String get name;
  @override
  String? get definition;

  /// Create a copy of ViewInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ViewInfoImplCopyWith<_$ViewInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoutineInfo _$RoutineInfoFromJson(Map<String, dynamic> json) {
  return _RoutineInfo.fromJson(json);
}

/// @nodoc
mixin _$RoutineInfo {
  String get schema => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get kind => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  String? get returnType => throw _privateConstructorUsedError;

  /// Serializes this RoutineInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoutineInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoutineInfoCopyWith<RoutineInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutineInfoCopyWith<$Res> {
  factory $RoutineInfoCopyWith(
          RoutineInfo value, $Res Function(RoutineInfo) then) =
      _$RoutineInfoCopyWithImpl<$Res, RoutineInfo>;
  @useResult
  $Res call(
      {String schema,
      String name,
      String kind,
      String? language,
      String? returnType});
}

/// @nodoc
class _$RoutineInfoCopyWithImpl<$Res, $Val extends RoutineInfo>
    implements $RoutineInfoCopyWith<$Res> {
  _$RoutineInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoutineInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? name = null,
    Object? kind = null,
    Object? language = freezed,
    Object? returnType = freezed,
  }) {
    return _then(_value.copyWith(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      returnType: freezed == returnType
          ? _value.returnType
          : returnType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoutineInfoImplCopyWith<$Res>
    implements $RoutineInfoCopyWith<$Res> {
  factory _$$RoutineInfoImplCopyWith(
          _$RoutineInfoImpl value, $Res Function(_$RoutineInfoImpl) then) =
      __$$RoutineInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String schema,
      String name,
      String kind,
      String? language,
      String? returnType});
}

/// @nodoc
class __$$RoutineInfoImplCopyWithImpl<$Res>
    extends _$RoutineInfoCopyWithImpl<$Res, _$RoutineInfoImpl>
    implements _$$RoutineInfoImplCopyWith<$Res> {
  __$$RoutineInfoImplCopyWithImpl(
      _$RoutineInfoImpl _value, $Res Function(_$RoutineInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoutineInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? name = null,
    Object? kind = null,
    Object? language = freezed,
    Object? returnType = freezed,
  }) {
    return _then(_$RoutineInfoImpl(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      returnType: freezed == returnType
          ? _value.returnType
          : returnType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoutineInfoImpl implements _RoutineInfo {
  const _$RoutineInfoImpl(
      {required this.schema,
      required this.name,
      required this.kind,
      this.language,
      this.returnType});

  factory _$RoutineInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoutineInfoImplFromJson(json);

  @override
  final String schema;
  @override
  final String name;
  @override
  final String kind;
  @override
  final String? language;
  @override
  final String? returnType;

  @override
  String toString() {
    return 'RoutineInfo(schema: $schema, name: $name, kind: $kind, language: $language, returnType: $returnType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineInfoImpl &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.returnType, returnType) ||
                other.returnType == returnType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, schema, name, kind, language, returnType);

  /// Create a copy of RoutineInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineInfoImplCopyWith<_$RoutineInfoImpl> get copyWith =>
      __$$RoutineInfoImplCopyWithImpl<_$RoutineInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoutineInfoImplToJson(
      this,
    );
  }
}

abstract class _RoutineInfo implements RoutineInfo {
  const factory _RoutineInfo(
      {required final String schema,
      required final String name,
      required final String kind,
      final String? language,
      final String? returnType}) = _$RoutineInfoImpl;

  factory _RoutineInfo.fromJson(Map<String, dynamic> json) =
      _$RoutineInfoImpl.fromJson;

  @override
  String get schema;
  @override
  String get name;
  @override
  String get kind;
  @override
  String? get language;
  @override
  String? get returnType;

  /// Create a copy of RoutineInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutineInfoImplCopyWith<_$RoutineInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SchemaMetadata _$SchemaMetadataFromJson(Map<String, dynamic> json) {
  return _SchemaMetadata.fromJson(json);
}

/// @nodoc
mixin _$SchemaMetadata {
  List<SchemaInfo> get schemas => throw _privateConstructorUsedError;
  List<TableInfo> get tables => throw _privateConstructorUsedError;
  List<ViewInfo> get views => throw _privateConstructorUsedError;

  /// Serializes this SchemaMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SchemaMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SchemaMetadataCopyWith<SchemaMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchemaMetadataCopyWith<$Res> {
  factory $SchemaMetadataCopyWith(
          SchemaMetadata value, $Res Function(SchemaMetadata) then) =
      _$SchemaMetadataCopyWithImpl<$Res, SchemaMetadata>;
  @useResult
  $Res call(
      {List<SchemaInfo> schemas, List<TableInfo> tables, List<ViewInfo> views});
}

/// @nodoc
class _$SchemaMetadataCopyWithImpl<$Res, $Val extends SchemaMetadata>
    implements $SchemaMetadataCopyWith<$Res> {
  _$SchemaMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SchemaMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schemas = null,
    Object? tables = null,
    Object? views = null,
  }) {
    return _then(_value.copyWith(
      schemas: null == schemas
          ? _value.schemas
          : schemas // ignore: cast_nullable_to_non_nullable
              as List<SchemaInfo>,
      tables: null == tables
          ? _value.tables
          : tables // ignore: cast_nullable_to_non_nullable
              as List<TableInfo>,
      views: null == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as List<ViewInfo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SchemaMetadataImplCopyWith<$Res>
    implements $SchemaMetadataCopyWith<$Res> {
  factory _$$SchemaMetadataImplCopyWith(_$SchemaMetadataImpl value,
          $Res Function(_$SchemaMetadataImpl) then) =
      __$$SchemaMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SchemaInfo> schemas, List<TableInfo> tables, List<ViewInfo> views});
}

/// @nodoc
class __$$SchemaMetadataImplCopyWithImpl<$Res>
    extends _$SchemaMetadataCopyWithImpl<$Res, _$SchemaMetadataImpl>
    implements _$$SchemaMetadataImplCopyWith<$Res> {
  __$$SchemaMetadataImplCopyWithImpl(
      _$SchemaMetadataImpl _value, $Res Function(_$SchemaMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SchemaMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schemas = null,
    Object? tables = null,
    Object? views = null,
  }) {
    return _then(_$SchemaMetadataImpl(
      schemas: null == schemas
          ? _value._schemas
          : schemas // ignore: cast_nullable_to_non_nullable
              as List<SchemaInfo>,
      tables: null == tables
          ? _value._tables
          : tables // ignore: cast_nullable_to_non_nullable
              as List<TableInfo>,
      views: null == views
          ? _value._views
          : views // ignore: cast_nullable_to_non_nullable
              as List<ViewInfo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SchemaMetadataImpl implements _SchemaMetadata {
  const _$SchemaMetadataImpl(
      {final List<SchemaInfo> schemas = const [],
      final List<TableInfo> tables = const [],
      final List<ViewInfo> views = const []})
      : _schemas = schemas,
        _tables = tables,
        _views = views;

  factory _$SchemaMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SchemaMetadataImplFromJson(json);

  final List<SchemaInfo> _schemas;
  @override
  @JsonKey()
  List<SchemaInfo> get schemas {
    if (_schemas is EqualUnmodifiableListView) return _schemas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_schemas);
  }

  final List<TableInfo> _tables;
  @override
  @JsonKey()
  List<TableInfo> get tables {
    if (_tables is EqualUnmodifiableListView) return _tables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tables);
  }

  final List<ViewInfo> _views;
  @override
  @JsonKey()
  List<ViewInfo> get views {
    if (_views is EqualUnmodifiableListView) return _views;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_views);
  }

  @override
  String toString() {
    return 'SchemaMetadata(schemas: $schemas, tables: $tables, views: $views)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SchemaMetadataImpl &&
            const DeepCollectionEquality().equals(other._schemas, _schemas) &&
            const DeepCollectionEquality().equals(other._tables, _tables) &&
            const DeepCollectionEquality().equals(other._views, _views));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_schemas),
      const DeepCollectionEquality().hash(_tables),
      const DeepCollectionEquality().hash(_views));

  /// Create a copy of SchemaMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SchemaMetadataImplCopyWith<_$SchemaMetadataImpl> get copyWith =>
      __$$SchemaMetadataImplCopyWithImpl<_$SchemaMetadataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SchemaMetadataImplToJson(
      this,
    );
  }
}

abstract class _SchemaMetadata implements SchemaMetadata {
  const factory _SchemaMetadata(
      {final List<SchemaInfo> schemas,
      final List<TableInfo> tables,
      final List<ViewInfo> views}) = _$SchemaMetadataImpl;

  factory _SchemaMetadata.fromJson(Map<String, dynamic> json) =
      _$SchemaMetadataImpl.fromJson;

  @override
  List<SchemaInfo> get schemas;
  @override
  List<TableInfo> get tables;
  @override
  List<ViewInfo> get views;

  /// Create a copy of SchemaMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SchemaMetadataImplCopyWith<_$SchemaMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
