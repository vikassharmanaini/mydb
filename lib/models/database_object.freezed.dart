// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'database_object.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DatabaseObject {
  String get name => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) schema,
    required TResult Function(String schema, String name) table,
    required TResult Function(String schema, String name) view,
    required TResult Function(String schema, String table, String name) column,
    required TResult Function(String schema, String table, String name) index,
    required TResult Function(String schema, String table, String name)
        foreignKey,
    required TResult Function(String schema, String name) sequence,
    required TResult Function(String schema, String table, String name) trigger,
    required TResult Function(String schema, String name) procedure,
    required TResult Function(String schema, String name) function,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? schema,
    TResult? Function(String schema, String name)? table,
    TResult? Function(String schema, String name)? view,
    TResult? Function(String schema, String table, String name)? column,
    TResult? Function(String schema, String table, String name)? index,
    TResult? Function(String schema, String table, String name)? foreignKey,
    TResult? Function(String schema, String name)? sequence,
    TResult? Function(String schema, String table, String name)? trigger,
    TResult? Function(String schema, String name)? procedure,
    TResult? Function(String schema, String name)? function,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? schema,
    TResult Function(String schema, String name)? table,
    TResult Function(String schema, String name)? view,
    TResult Function(String schema, String table, String name)? column,
    TResult Function(String schema, String table, String name)? index,
    TResult Function(String schema, String table, String name)? foreignKey,
    TResult Function(String schema, String name)? sequence,
    TResult Function(String schema, String table, String name)? trigger,
    TResult Function(String schema, String name)? procedure,
    TResult Function(String schema, String name)? function,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DatabaseObjectSchema value) schema,
    required TResult Function(DatabaseObjectTable value) table,
    required TResult Function(DatabaseObjectView value) view,
    required TResult Function(DatabaseObjectColumn value) column,
    required TResult Function(DatabaseObjectIndex value) index,
    required TResult Function(DatabaseObjectForeignKey value) foreignKey,
    required TResult Function(DatabaseObjectSequence value) sequence,
    required TResult Function(DatabaseObjectTrigger value) trigger,
    required TResult Function(DatabaseObjectProcedure value) procedure,
    required TResult Function(DatabaseObjectFunction value) function,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseObjectSchema value)? schema,
    TResult? Function(DatabaseObjectTable value)? table,
    TResult? Function(DatabaseObjectView value)? view,
    TResult? Function(DatabaseObjectColumn value)? column,
    TResult? Function(DatabaseObjectIndex value)? index,
    TResult? Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult? Function(DatabaseObjectSequence value)? sequence,
    TResult? Function(DatabaseObjectTrigger value)? trigger,
    TResult? Function(DatabaseObjectProcedure value)? procedure,
    TResult? Function(DatabaseObjectFunction value)? function,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseObjectSchema value)? schema,
    TResult Function(DatabaseObjectTable value)? table,
    TResult Function(DatabaseObjectView value)? view,
    TResult Function(DatabaseObjectColumn value)? column,
    TResult Function(DatabaseObjectIndex value)? index,
    TResult Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult Function(DatabaseObjectSequence value)? sequence,
    TResult Function(DatabaseObjectTrigger value)? trigger,
    TResult Function(DatabaseObjectProcedure value)? procedure,
    TResult Function(DatabaseObjectFunction value)? function,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DatabaseObjectCopyWith<DatabaseObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatabaseObjectCopyWith<$Res> {
  factory $DatabaseObjectCopyWith(
          DatabaseObject value, $Res Function(DatabaseObject) then) =
      _$DatabaseObjectCopyWithImpl<$Res, DatabaseObject>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$DatabaseObjectCopyWithImpl<$Res, $Val extends DatabaseObject>
    implements $DatabaseObjectCopyWith<$Res> {
  _$DatabaseObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DatabaseObjectSchemaImplCopyWith<$Res>
    implements $DatabaseObjectCopyWith<$Res> {
  factory _$$DatabaseObjectSchemaImplCopyWith(_$DatabaseObjectSchemaImpl value,
          $Res Function(_$DatabaseObjectSchemaImpl) then) =
      __$$DatabaseObjectSchemaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$DatabaseObjectSchemaImplCopyWithImpl<$Res>
    extends _$DatabaseObjectCopyWithImpl<$Res, _$DatabaseObjectSchemaImpl>
    implements _$$DatabaseObjectSchemaImplCopyWith<$Res> {
  __$$DatabaseObjectSchemaImplCopyWithImpl(_$DatabaseObjectSchemaImpl _value,
      $Res Function(_$DatabaseObjectSchemaImpl) _then)
      : super(_value, _then);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$DatabaseObjectSchemaImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DatabaseObjectSchemaImpl implements DatabaseObjectSchema {
  const _$DatabaseObjectSchemaImpl({required this.name});

  @override
  final String name;

  @override
  String toString() {
    return 'DatabaseObject.schema(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseObjectSchemaImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseObjectSchemaImplCopyWith<_$DatabaseObjectSchemaImpl>
      get copyWith =>
          __$$DatabaseObjectSchemaImplCopyWithImpl<_$DatabaseObjectSchemaImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) schema,
    required TResult Function(String schema, String name) table,
    required TResult Function(String schema, String name) view,
    required TResult Function(String schema, String table, String name) column,
    required TResult Function(String schema, String table, String name) index,
    required TResult Function(String schema, String table, String name)
        foreignKey,
    required TResult Function(String schema, String name) sequence,
    required TResult Function(String schema, String table, String name) trigger,
    required TResult Function(String schema, String name) procedure,
    required TResult Function(String schema, String name) function,
  }) {
    return schema(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? schema,
    TResult? Function(String schema, String name)? table,
    TResult? Function(String schema, String name)? view,
    TResult? Function(String schema, String table, String name)? column,
    TResult? Function(String schema, String table, String name)? index,
    TResult? Function(String schema, String table, String name)? foreignKey,
    TResult? Function(String schema, String name)? sequence,
    TResult? Function(String schema, String table, String name)? trigger,
    TResult? Function(String schema, String name)? procedure,
    TResult? Function(String schema, String name)? function,
  }) {
    return schema?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? schema,
    TResult Function(String schema, String name)? table,
    TResult Function(String schema, String name)? view,
    TResult Function(String schema, String table, String name)? column,
    TResult Function(String schema, String table, String name)? index,
    TResult Function(String schema, String table, String name)? foreignKey,
    TResult Function(String schema, String name)? sequence,
    TResult Function(String schema, String table, String name)? trigger,
    TResult Function(String schema, String name)? procedure,
    TResult Function(String schema, String name)? function,
    required TResult orElse(),
  }) {
    if (schema != null) {
      return schema(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DatabaseObjectSchema value) schema,
    required TResult Function(DatabaseObjectTable value) table,
    required TResult Function(DatabaseObjectView value) view,
    required TResult Function(DatabaseObjectColumn value) column,
    required TResult Function(DatabaseObjectIndex value) index,
    required TResult Function(DatabaseObjectForeignKey value) foreignKey,
    required TResult Function(DatabaseObjectSequence value) sequence,
    required TResult Function(DatabaseObjectTrigger value) trigger,
    required TResult Function(DatabaseObjectProcedure value) procedure,
    required TResult Function(DatabaseObjectFunction value) function,
  }) {
    return schema(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseObjectSchema value)? schema,
    TResult? Function(DatabaseObjectTable value)? table,
    TResult? Function(DatabaseObjectView value)? view,
    TResult? Function(DatabaseObjectColumn value)? column,
    TResult? Function(DatabaseObjectIndex value)? index,
    TResult? Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult? Function(DatabaseObjectSequence value)? sequence,
    TResult? Function(DatabaseObjectTrigger value)? trigger,
    TResult? Function(DatabaseObjectProcedure value)? procedure,
    TResult? Function(DatabaseObjectFunction value)? function,
  }) {
    return schema?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseObjectSchema value)? schema,
    TResult Function(DatabaseObjectTable value)? table,
    TResult Function(DatabaseObjectView value)? view,
    TResult Function(DatabaseObjectColumn value)? column,
    TResult Function(DatabaseObjectIndex value)? index,
    TResult Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult Function(DatabaseObjectSequence value)? sequence,
    TResult Function(DatabaseObjectTrigger value)? trigger,
    TResult Function(DatabaseObjectProcedure value)? procedure,
    TResult Function(DatabaseObjectFunction value)? function,
    required TResult orElse(),
  }) {
    if (schema != null) {
      return schema(this);
    }
    return orElse();
  }
}

abstract class DatabaseObjectSchema implements DatabaseObject {
  const factory DatabaseObjectSchema({required final String name}) =
      _$DatabaseObjectSchemaImpl;

  @override
  String get name;

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabaseObjectSchemaImplCopyWith<_$DatabaseObjectSchemaImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatabaseObjectTableImplCopyWith<$Res>
    implements $DatabaseObjectCopyWith<$Res> {
  factory _$$DatabaseObjectTableImplCopyWith(_$DatabaseObjectTableImpl value,
          $Res Function(_$DatabaseObjectTableImpl) then) =
      __$$DatabaseObjectTableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String schema, String name});
}

/// @nodoc
class __$$DatabaseObjectTableImplCopyWithImpl<$Res>
    extends _$DatabaseObjectCopyWithImpl<$Res, _$DatabaseObjectTableImpl>
    implements _$$DatabaseObjectTableImplCopyWith<$Res> {
  __$$DatabaseObjectTableImplCopyWithImpl(_$DatabaseObjectTableImpl _value,
      $Res Function(_$DatabaseObjectTableImpl) _then)
      : super(_value, _then);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? name = null,
  }) {
    return _then(_$DatabaseObjectTableImpl(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DatabaseObjectTableImpl implements DatabaseObjectTable {
  const _$DatabaseObjectTableImpl({required this.schema, required this.name});

  @override
  final String schema;
  @override
  final String name;

  @override
  String toString() {
    return 'DatabaseObject.table(schema: $schema, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseObjectTableImpl &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, schema, name);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseObjectTableImplCopyWith<_$DatabaseObjectTableImpl> get copyWith =>
      __$$DatabaseObjectTableImplCopyWithImpl<_$DatabaseObjectTableImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) schema,
    required TResult Function(String schema, String name) table,
    required TResult Function(String schema, String name) view,
    required TResult Function(String schema, String table, String name) column,
    required TResult Function(String schema, String table, String name) index,
    required TResult Function(String schema, String table, String name)
        foreignKey,
    required TResult Function(String schema, String name) sequence,
    required TResult Function(String schema, String table, String name) trigger,
    required TResult Function(String schema, String name) procedure,
    required TResult Function(String schema, String name) function,
  }) {
    return table(this.schema, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? schema,
    TResult? Function(String schema, String name)? table,
    TResult? Function(String schema, String name)? view,
    TResult? Function(String schema, String table, String name)? column,
    TResult? Function(String schema, String table, String name)? index,
    TResult? Function(String schema, String table, String name)? foreignKey,
    TResult? Function(String schema, String name)? sequence,
    TResult? Function(String schema, String table, String name)? trigger,
    TResult? Function(String schema, String name)? procedure,
    TResult? Function(String schema, String name)? function,
  }) {
    return table?.call(this.schema, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? schema,
    TResult Function(String schema, String name)? table,
    TResult Function(String schema, String name)? view,
    TResult Function(String schema, String table, String name)? column,
    TResult Function(String schema, String table, String name)? index,
    TResult Function(String schema, String table, String name)? foreignKey,
    TResult Function(String schema, String name)? sequence,
    TResult Function(String schema, String table, String name)? trigger,
    TResult Function(String schema, String name)? procedure,
    TResult Function(String schema, String name)? function,
    required TResult orElse(),
  }) {
    if (table != null) {
      return table(this.schema, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DatabaseObjectSchema value) schema,
    required TResult Function(DatabaseObjectTable value) table,
    required TResult Function(DatabaseObjectView value) view,
    required TResult Function(DatabaseObjectColumn value) column,
    required TResult Function(DatabaseObjectIndex value) index,
    required TResult Function(DatabaseObjectForeignKey value) foreignKey,
    required TResult Function(DatabaseObjectSequence value) sequence,
    required TResult Function(DatabaseObjectTrigger value) trigger,
    required TResult Function(DatabaseObjectProcedure value) procedure,
    required TResult Function(DatabaseObjectFunction value) function,
  }) {
    return table(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseObjectSchema value)? schema,
    TResult? Function(DatabaseObjectTable value)? table,
    TResult? Function(DatabaseObjectView value)? view,
    TResult? Function(DatabaseObjectColumn value)? column,
    TResult? Function(DatabaseObjectIndex value)? index,
    TResult? Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult? Function(DatabaseObjectSequence value)? sequence,
    TResult? Function(DatabaseObjectTrigger value)? trigger,
    TResult? Function(DatabaseObjectProcedure value)? procedure,
    TResult? Function(DatabaseObjectFunction value)? function,
  }) {
    return table?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseObjectSchema value)? schema,
    TResult Function(DatabaseObjectTable value)? table,
    TResult Function(DatabaseObjectView value)? view,
    TResult Function(DatabaseObjectColumn value)? column,
    TResult Function(DatabaseObjectIndex value)? index,
    TResult Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult Function(DatabaseObjectSequence value)? sequence,
    TResult Function(DatabaseObjectTrigger value)? trigger,
    TResult Function(DatabaseObjectProcedure value)? procedure,
    TResult Function(DatabaseObjectFunction value)? function,
    required TResult orElse(),
  }) {
    if (table != null) {
      return table(this);
    }
    return orElse();
  }
}

abstract class DatabaseObjectTable implements DatabaseObject {
  const factory DatabaseObjectTable(
      {required final String schema,
      required final String name}) = _$DatabaseObjectTableImpl;

  String get schema;
  @override
  String get name;

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabaseObjectTableImplCopyWith<_$DatabaseObjectTableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatabaseObjectViewImplCopyWith<$Res>
    implements $DatabaseObjectCopyWith<$Res> {
  factory _$$DatabaseObjectViewImplCopyWith(_$DatabaseObjectViewImpl value,
          $Res Function(_$DatabaseObjectViewImpl) then) =
      __$$DatabaseObjectViewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String schema, String name});
}

/// @nodoc
class __$$DatabaseObjectViewImplCopyWithImpl<$Res>
    extends _$DatabaseObjectCopyWithImpl<$Res, _$DatabaseObjectViewImpl>
    implements _$$DatabaseObjectViewImplCopyWith<$Res> {
  __$$DatabaseObjectViewImplCopyWithImpl(_$DatabaseObjectViewImpl _value,
      $Res Function(_$DatabaseObjectViewImpl) _then)
      : super(_value, _then);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? name = null,
  }) {
    return _then(_$DatabaseObjectViewImpl(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DatabaseObjectViewImpl implements DatabaseObjectView {
  const _$DatabaseObjectViewImpl({required this.schema, required this.name});

  @override
  final String schema;
  @override
  final String name;

  @override
  String toString() {
    return 'DatabaseObject.view(schema: $schema, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseObjectViewImpl &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, schema, name);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseObjectViewImplCopyWith<_$DatabaseObjectViewImpl> get copyWith =>
      __$$DatabaseObjectViewImplCopyWithImpl<_$DatabaseObjectViewImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) schema,
    required TResult Function(String schema, String name) table,
    required TResult Function(String schema, String name) view,
    required TResult Function(String schema, String table, String name) column,
    required TResult Function(String schema, String table, String name) index,
    required TResult Function(String schema, String table, String name)
        foreignKey,
    required TResult Function(String schema, String name) sequence,
    required TResult Function(String schema, String table, String name) trigger,
    required TResult Function(String schema, String name) procedure,
    required TResult Function(String schema, String name) function,
  }) {
    return view(this.schema, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? schema,
    TResult? Function(String schema, String name)? table,
    TResult? Function(String schema, String name)? view,
    TResult? Function(String schema, String table, String name)? column,
    TResult? Function(String schema, String table, String name)? index,
    TResult? Function(String schema, String table, String name)? foreignKey,
    TResult? Function(String schema, String name)? sequence,
    TResult? Function(String schema, String table, String name)? trigger,
    TResult? Function(String schema, String name)? procedure,
    TResult? Function(String schema, String name)? function,
  }) {
    return view?.call(this.schema, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? schema,
    TResult Function(String schema, String name)? table,
    TResult Function(String schema, String name)? view,
    TResult Function(String schema, String table, String name)? column,
    TResult Function(String schema, String table, String name)? index,
    TResult Function(String schema, String table, String name)? foreignKey,
    TResult Function(String schema, String name)? sequence,
    TResult Function(String schema, String table, String name)? trigger,
    TResult Function(String schema, String name)? procedure,
    TResult Function(String schema, String name)? function,
    required TResult orElse(),
  }) {
    if (view != null) {
      return view(this.schema, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DatabaseObjectSchema value) schema,
    required TResult Function(DatabaseObjectTable value) table,
    required TResult Function(DatabaseObjectView value) view,
    required TResult Function(DatabaseObjectColumn value) column,
    required TResult Function(DatabaseObjectIndex value) index,
    required TResult Function(DatabaseObjectForeignKey value) foreignKey,
    required TResult Function(DatabaseObjectSequence value) sequence,
    required TResult Function(DatabaseObjectTrigger value) trigger,
    required TResult Function(DatabaseObjectProcedure value) procedure,
    required TResult Function(DatabaseObjectFunction value) function,
  }) {
    return view(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseObjectSchema value)? schema,
    TResult? Function(DatabaseObjectTable value)? table,
    TResult? Function(DatabaseObjectView value)? view,
    TResult? Function(DatabaseObjectColumn value)? column,
    TResult? Function(DatabaseObjectIndex value)? index,
    TResult? Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult? Function(DatabaseObjectSequence value)? sequence,
    TResult? Function(DatabaseObjectTrigger value)? trigger,
    TResult? Function(DatabaseObjectProcedure value)? procedure,
    TResult? Function(DatabaseObjectFunction value)? function,
  }) {
    return view?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseObjectSchema value)? schema,
    TResult Function(DatabaseObjectTable value)? table,
    TResult Function(DatabaseObjectView value)? view,
    TResult Function(DatabaseObjectColumn value)? column,
    TResult Function(DatabaseObjectIndex value)? index,
    TResult Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult Function(DatabaseObjectSequence value)? sequence,
    TResult Function(DatabaseObjectTrigger value)? trigger,
    TResult Function(DatabaseObjectProcedure value)? procedure,
    TResult Function(DatabaseObjectFunction value)? function,
    required TResult orElse(),
  }) {
    if (view != null) {
      return view(this);
    }
    return orElse();
  }
}

abstract class DatabaseObjectView implements DatabaseObject {
  const factory DatabaseObjectView(
      {required final String schema,
      required final String name}) = _$DatabaseObjectViewImpl;

  String get schema;
  @override
  String get name;

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabaseObjectViewImplCopyWith<_$DatabaseObjectViewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatabaseObjectColumnImplCopyWith<$Res>
    implements $DatabaseObjectCopyWith<$Res> {
  factory _$$DatabaseObjectColumnImplCopyWith(_$DatabaseObjectColumnImpl value,
          $Res Function(_$DatabaseObjectColumnImpl) then) =
      __$$DatabaseObjectColumnImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String schema, String table, String name});
}

/// @nodoc
class __$$DatabaseObjectColumnImplCopyWithImpl<$Res>
    extends _$DatabaseObjectCopyWithImpl<$Res, _$DatabaseObjectColumnImpl>
    implements _$$DatabaseObjectColumnImplCopyWith<$Res> {
  __$$DatabaseObjectColumnImplCopyWithImpl(_$DatabaseObjectColumnImpl _value,
      $Res Function(_$DatabaseObjectColumnImpl) _then)
      : super(_value, _then);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? table = null,
    Object? name = null,
  }) {
    return _then(_$DatabaseObjectColumnImpl(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DatabaseObjectColumnImpl implements DatabaseObjectColumn {
  const _$DatabaseObjectColumnImpl(
      {required this.schema, required this.table, required this.name});

  @override
  final String schema;
  @override
  final String table;
  @override
  final String name;

  @override
  String toString() {
    return 'DatabaseObject.column(schema: $schema, table: $table, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseObjectColumnImpl &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, schema, table, name);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseObjectColumnImplCopyWith<_$DatabaseObjectColumnImpl>
      get copyWith =>
          __$$DatabaseObjectColumnImplCopyWithImpl<_$DatabaseObjectColumnImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) schema,
    required TResult Function(String schema, String name) table,
    required TResult Function(String schema, String name) view,
    required TResult Function(String schema, String table, String name) column,
    required TResult Function(String schema, String table, String name) index,
    required TResult Function(String schema, String table, String name)
        foreignKey,
    required TResult Function(String schema, String name) sequence,
    required TResult Function(String schema, String table, String name) trigger,
    required TResult Function(String schema, String name) procedure,
    required TResult Function(String schema, String name) function,
  }) {
    return column(this.schema, this.table, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? schema,
    TResult? Function(String schema, String name)? table,
    TResult? Function(String schema, String name)? view,
    TResult? Function(String schema, String table, String name)? column,
    TResult? Function(String schema, String table, String name)? index,
    TResult? Function(String schema, String table, String name)? foreignKey,
    TResult? Function(String schema, String name)? sequence,
    TResult? Function(String schema, String table, String name)? trigger,
    TResult? Function(String schema, String name)? procedure,
    TResult? Function(String schema, String name)? function,
  }) {
    return column?.call(this.schema, this.table, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? schema,
    TResult Function(String schema, String name)? table,
    TResult Function(String schema, String name)? view,
    TResult Function(String schema, String table, String name)? column,
    TResult Function(String schema, String table, String name)? index,
    TResult Function(String schema, String table, String name)? foreignKey,
    TResult Function(String schema, String name)? sequence,
    TResult Function(String schema, String table, String name)? trigger,
    TResult Function(String schema, String name)? procedure,
    TResult Function(String schema, String name)? function,
    required TResult orElse(),
  }) {
    if (column != null) {
      return column(this.schema, this.table, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DatabaseObjectSchema value) schema,
    required TResult Function(DatabaseObjectTable value) table,
    required TResult Function(DatabaseObjectView value) view,
    required TResult Function(DatabaseObjectColumn value) column,
    required TResult Function(DatabaseObjectIndex value) index,
    required TResult Function(DatabaseObjectForeignKey value) foreignKey,
    required TResult Function(DatabaseObjectSequence value) sequence,
    required TResult Function(DatabaseObjectTrigger value) trigger,
    required TResult Function(DatabaseObjectProcedure value) procedure,
    required TResult Function(DatabaseObjectFunction value) function,
  }) {
    return column(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseObjectSchema value)? schema,
    TResult? Function(DatabaseObjectTable value)? table,
    TResult? Function(DatabaseObjectView value)? view,
    TResult? Function(DatabaseObjectColumn value)? column,
    TResult? Function(DatabaseObjectIndex value)? index,
    TResult? Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult? Function(DatabaseObjectSequence value)? sequence,
    TResult? Function(DatabaseObjectTrigger value)? trigger,
    TResult? Function(DatabaseObjectProcedure value)? procedure,
    TResult? Function(DatabaseObjectFunction value)? function,
  }) {
    return column?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseObjectSchema value)? schema,
    TResult Function(DatabaseObjectTable value)? table,
    TResult Function(DatabaseObjectView value)? view,
    TResult Function(DatabaseObjectColumn value)? column,
    TResult Function(DatabaseObjectIndex value)? index,
    TResult Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult Function(DatabaseObjectSequence value)? sequence,
    TResult Function(DatabaseObjectTrigger value)? trigger,
    TResult Function(DatabaseObjectProcedure value)? procedure,
    TResult Function(DatabaseObjectFunction value)? function,
    required TResult orElse(),
  }) {
    if (column != null) {
      return column(this);
    }
    return orElse();
  }
}

abstract class DatabaseObjectColumn implements DatabaseObject {
  const factory DatabaseObjectColumn(
      {required final String schema,
      required final String table,
      required final String name}) = _$DatabaseObjectColumnImpl;

  String get schema;
  String get table;
  @override
  String get name;

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabaseObjectColumnImplCopyWith<_$DatabaseObjectColumnImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatabaseObjectIndexImplCopyWith<$Res>
    implements $DatabaseObjectCopyWith<$Res> {
  factory _$$DatabaseObjectIndexImplCopyWith(_$DatabaseObjectIndexImpl value,
          $Res Function(_$DatabaseObjectIndexImpl) then) =
      __$$DatabaseObjectIndexImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String schema, String table, String name});
}

/// @nodoc
class __$$DatabaseObjectIndexImplCopyWithImpl<$Res>
    extends _$DatabaseObjectCopyWithImpl<$Res, _$DatabaseObjectIndexImpl>
    implements _$$DatabaseObjectIndexImplCopyWith<$Res> {
  __$$DatabaseObjectIndexImplCopyWithImpl(_$DatabaseObjectIndexImpl _value,
      $Res Function(_$DatabaseObjectIndexImpl) _then)
      : super(_value, _then);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? table = null,
    Object? name = null,
  }) {
    return _then(_$DatabaseObjectIndexImpl(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DatabaseObjectIndexImpl implements DatabaseObjectIndex {
  const _$DatabaseObjectIndexImpl(
      {required this.schema, required this.table, required this.name});

  @override
  final String schema;
  @override
  final String table;
  @override
  final String name;

  @override
  String toString() {
    return 'DatabaseObject.index(schema: $schema, table: $table, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseObjectIndexImpl &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, schema, table, name);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseObjectIndexImplCopyWith<_$DatabaseObjectIndexImpl> get copyWith =>
      __$$DatabaseObjectIndexImplCopyWithImpl<_$DatabaseObjectIndexImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) schema,
    required TResult Function(String schema, String name) table,
    required TResult Function(String schema, String name) view,
    required TResult Function(String schema, String table, String name) column,
    required TResult Function(String schema, String table, String name) index,
    required TResult Function(String schema, String table, String name)
        foreignKey,
    required TResult Function(String schema, String name) sequence,
    required TResult Function(String schema, String table, String name) trigger,
    required TResult Function(String schema, String name) procedure,
    required TResult Function(String schema, String name) function,
  }) {
    return index(this.schema, this.table, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? schema,
    TResult? Function(String schema, String name)? table,
    TResult? Function(String schema, String name)? view,
    TResult? Function(String schema, String table, String name)? column,
    TResult? Function(String schema, String table, String name)? index,
    TResult? Function(String schema, String table, String name)? foreignKey,
    TResult? Function(String schema, String name)? sequence,
    TResult? Function(String schema, String table, String name)? trigger,
    TResult? Function(String schema, String name)? procedure,
    TResult? Function(String schema, String name)? function,
  }) {
    return index?.call(this.schema, this.table, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? schema,
    TResult Function(String schema, String name)? table,
    TResult Function(String schema, String name)? view,
    TResult Function(String schema, String table, String name)? column,
    TResult Function(String schema, String table, String name)? index,
    TResult Function(String schema, String table, String name)? foreignKey,
    TResult Function(String schema, String name)? sequence,
    TResult Function(String schema, String table, String name)? trigger,
    TResult Function(String schema, String name)? procedure,
    TResult Function(String schema, String name)? function,
    required TResult orElse(),
  }) {
    if (index != null) {
      return index(this.schema, this.table, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DatabaseObjectSchema value) schema,
    required TResult Function(DatabaseObjectTable value) table,
    required TResult Function(DatabaseObjectView value) view,
    required TResult Function(DatabaseObjectColumn value) column,
    required TResult Function(DatabaseObjectIndex value) index,
    required TResult Function(DatabaseObjectForeignKey value) foreignKey,
    required TResult Function(DatabaseObjectSequence value) sequence,
    required TResult Function(DatabaseObjectTrigger value) trigger,
    required TResult Function(DatabaseObjectProcedure value) procedure,
    required TResult Function(DatabaseObjectFunction value) function,
  }) {
    return index(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseObjectSchema value)? schema,
    TResult? Function(DatabaseObjectTable value)? table,
    TResult? Function(DatabaseObjectView value)? view,
    TResult? Function(DatabaseObjectColumn value)? column,
    TResult? Function(DatabaseObjectIndex value)? index,
    TResult? Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult? Function(DatabaseObjectSequence value)? sequence,
    TResult? Function(DatabaseObjectTrigger value)? trigger,
    TResult? Function(DatabaseObjectProcedure value)? procedure,
    TResult? Function(DatabaseObjectFunction value)? function,
  }) {
    return index?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseObjectSchema value)? schema,
    TResult Function(DatabaseObjectTable value)? table,
    TResult Function(DatabaseObjectView value)? view,
    TResult Function(DatabaseObjectColumn value)? column,
    TResult Function(DatabaseObjectIndex value)? index,
    TResult Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult Function(DatabaseObjectSequence value)? sequence,
    TResult Function(DatabaseObjectTrigger value)? trigger,
    TResult Function(DatabaseObjectProcedure value)? procedure,
    TResult Function(DatabaseObjectFunction value)? function,
    required TResult orElse(),
  }) {
    if (index != null) {
      return index(this);
    }
    return orElse();
  }
}

abstract class DatabaseObjectIndex implements DatabaseObject {
  const factory DatabaseObjectIndex(
      {required final String schema,
      required final String table,
      required final String name}) = _$DatabaseObjectIndexImpl;

  String get schema;
  String get table;
  @override
  String get name;

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabaseObjectIndexImplCopyWith<_$DatabaseObjectIndexImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatabaseObjectForeignKeyImplCopyWith<$Res>
    implements $DatabaseObjectCopyWith<$Res> {
  factory _$$DatabaseObjectForeignKeyImplCopyWith(
          _$DatabaseObjectForeignKeyImpl value,
          $Res Function(_$DatabaseObjectForeignKeyImpl) then) =
      __$$DatabaseObjectForeignKeyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String schema, String table, String name});
}

/// @nodoc
class __$$DatabaseObjectForeignKeyImplCopyWithImpl<$Res>
    extends _$DatabaseObjectCopyWithImpl<$Res, _$DatabaseObjectForeignKeyImpl>
    implements _$$DatabaseObjectForeignKeyImplCopyWith<$Res> {
  __$$DatabaseObjectForeignKeyImplCopyWithImpl(
      _$DatabaseObjectForeignKeyImpl _value,
      $Res Function(_$DatabaseObjectForeignKeyImpl) _then)
      : super(_value, _then);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? table = null,
    Object? name = null,
  }) {
    return _then(_$DatabaseObjectForeignKeyImpl(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DatabaseObjectForeignKeyImpl implements DatabaseObjectForeignKey {
  const _$DatabaseObjectForeignKeyImpl(
      {required this.schema, required this.table, required this.name});

  @override
  final String schema;
  @override
  final String table;
  @override
  final String name;

  @override
  String toString() {
    return 'DatabaseObject.foreignKey(schema: $schema, table: $table, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseObjectForeignKeyImpl &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, schema, table, name);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseObjectForeignKeyImplCopyWith<_$DatabaseObjectForeignKeyImpl>
      get copyWith => __$$DatabaseObjectForeignKeyImplCopyWithImpl<
          _$DatabaseObjectForeignKeyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) schema,
    required TResult Function(String schema, String name) table,
    required TResult Function(String schema, String name) view,
    required TResult Function(String schema, String table, String name) column,
    required TResult Function(String schema, String table, String name) index,
    required TResult Function(String schema, String table, String name)
        foreignKey,
    required TResult Function(String schema, String name) sequence,
    required TResult Function(String schema, String table, String name) trigger,
    required TResult Function(String schema, String name) procedure,
    required TResult Function(String schema, String name) function,
  }) {
    return foreignKey(this.schema, this.table, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? schema,
    TResult? Function(String schema, String name)? table,
    TResult? Function(String schema, String name)? view,
    TResult? Function(String schema, String table, String name)? column,
    TResult? Function(String schema, String table, String name)? index,
    TResult? Function(String schema, String table, String name)? foreignKey,
    TResult? Function(String schema, String name)? sequence,
    TResult? Function(String schema, String table, String name)? trigger,
    TResult? Function(String schema, String name)? procedure,
    TResult? Function(String schema, String name)? function,
  }) {
    return foreignKey?.call(this.schema, this.table, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? schema,
    TResult Function(String schema, String name)? table,
    TResult Function(String schema, String name)? view,
    TResult Function(String schema, String table, String name)? column,
    TResult Function(String schema, String table, String name)? index,
    TResult Function(String schema, String table, String name)? foreignKey,
    TResult Function(String schema, String name)? sequence,
    TResult Function(String schema, String table, String name)? trigger,
    TResult Function(String schema, String name)? procedure,
    TResult Function(String schema, String name)? function,
    required TResult orElse(),
  }) {
    if (foreignKey != null) {
      return foreignKey(this.schema, this.table, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DatabaseObjectSchema value) schema,
    required TResult Function(DatabaseObjectTable value) table,
    required TResult Function(DatabaseObjectView value) view,
    required TResult Function(DatabaseObjectColumn value) column,
    required TResult Function(DatabaseObjectIndex value) index,
    required TResult Function(DatabaseObjectForeignKey value) foreignKey,
    required TResult Function(DatabaseObjectSequence value) sequence,
    required TResult Function(DatabaseObjectTrigger value) trigger,
    required TResult Function(DatabaseObjectProcedure value) procedure,
    required TResult Function(DatabaseObjectFunction value) function,
  }) {
    return foreignKey(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseObjectSchema value)? schema,
    TResult? Function(DatabaseObjectTable value)? table,
    TResult? Function(DatabaseObjectView value)? view,
    TResult? Function(DatabaseObjectColumn value)? column,
    TResult? Function(DatabaseObjectIndex value)? index,
    TResult? Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult? Function(DatabaseObjectSequence value)? sequence,
    TResult? Function(DatabaseObjectTrigger value)? trigger,
    TResult? Function(DatabaseObjectProcedure value)? procedure,
    TResult? Function(DatabaseObjectFunction value)? function,
  }) {
    return foreignKey?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseObjectSchema value)? schema,
    TResult Function(DatabaseObjectTable value)? table,
    TResult Function(DatabaseObjectView value)? view,
    TResult Function(DatabaseObjectColumn value)? column,
    TResult Function(DatabaseObjectIndex value)? index,
    TResult Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult Function(DatabaseObjectSequence value)? sequence,
    TResult Function(DatabaseObjectTrigger value)? trigger,
    TResult Function(DatabaseObjectProcedure value)? procedure,
    TResult Function(DatabaseObjectFunction value)? function,
    required TResult orElse(),
  }) {
    if (foreignKey != null) {
      return foreignKey(this);
    }
    return orElse();
  }
}

abstract class DatabaseObjectForeignKey implements DatabaseObject {
  const factory DatabaseObjectForeignKey(
      {required final String schema,
      required final String table,
      required final String name}) = _$DatabaseObjectForeignKeyImpl;

  String get schema;
  String get table;
  @override
  String get name;

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabaseObjectForeignKeyImplCopyWith<_$DatabaseObjectForeignKeyImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatabaseObjectSequenceImplCopyWith<$Res>
    implements $DatabaseObjectCopyWith<$Res> {
  factory _$$DatabaseObjectSequenceImplCopyWith(
          _$DatabaseObjectSequenceImpl value,
          $Res Function(_$DatabaseObjectSequenceImpl) then) =
      __$$DatabaseObjectSequenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String schema, String name});
}

/// @nodoc
class __$$DatabaseObjectSequenceImplCopyWithImpl<$Res>
    extends _$DatabaseObjectCopyWithImpl<$Res, _$DatabaseObjectSequenceImpl>
    implements _$$DatabaseObjectSequenceImplCopyWith<$Res> {
  __$$DatabaseObjectSequenceImplCopyWithImpl(
      _$DatabaseObjectSequenceImpl _value,
      $Res Function(_$DatabaseObjectSequenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? name = null,
  }) {
    return _then(_$DatabaseObjectSequenceImpl(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DatabaseObjectSequenceImpl implements DatabaseObjectSequence {
  const _$DatabaseObjectSequenceImpl(
      {required this.schema, required this.name});

  @override
  final String schema;
  @override
  final String name;

  @override
  String toString() {
    return 'DatabaseObject.sequence(schema: $schema, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseObjectSequenceImpl &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, schema, name);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseObjectSequenceImplCopyWith<_$DatabaseObjectSequenceImpl>
      get copyWith => __$$DatabaseObjectSequenceImplCopyWithImpl<
          _$DatabaseObjectSequenceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) schema,
    required TResult Function(String schema, String name) table,
    required TResult Function(String schema, String name) view,
    required TResult Function(String schema, String table, String name) column,
    required TResult Function(String schema, String table, String name) index,
    required TResult Function(String schema, String table, String name)
        foreignKey,
    required TResult Function(String schema, String name) sequence,
    required TResult Function(String schema, String table, String name) trigger,
    required TResult Function(String schema, String name) procedure,
    required TResult Function(String schema, String name) function,
  }) {
    return sequence(this.schema, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? schema,
    TResult? Function(String schema, String name)? table,
    TResult? Function(String schema, String name)? view,
    TResult? Function(String schema, String table, String name)? column,
    TResult? Function(String schema, String table, String name)? index,
    TResult? Function(String schema, String table, String name)? foreignKey,
    TResult? Function(String schema, String name)? sequence,
    TResult? Function(String schema, String table, String name)? trigger,
    TResult? Function(String schema, String name)? procedure,
    TResult? Function(String schema, String name)? function,
  }) {
    return sequence?.call(this.schema, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? schema,
    TResult Function(String schema, String name)? table,
    TResult Function(String schema, String name)? view,
    TResult Function(String schema, String table, String name)? column,
    TResult Function(String schema, String table, String name)? index,
    TResult Function(String schema, String table, String name)? foreignKey,
    TResult Function(String schema, String name)? sequence,
    TResult Function(String schema, String table, String name)? trigger,
    TResult Function(String schema, String name)? procedure,
    TResult Function(String schema, String name)? function,
    required TResult orElse(),
  }) {
    if (sequence != null) {
      return sequence(this.schema, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DatabaseObjectSchema value) schema,
    required TResult Function(DatabaseObjectTable value) table,
    required TResult Function(DatabaseObjectView value) view,
    required TResult Function(DatabaseObjectColumn value) column,
    required TResult Function(DatabaseObjectIndex value) index,
    required TResult Function(DatabaseObjectForeignKey value) foreignKey,
    required TResult Function(DatabaseObjectSequence value) sequence,
    required TResult Function(DatabaseObjectTrigger value) trigger,
    required TResult Function(DatabaseObjectProcedure value) procedure,
    required TResult Function(DatabaseObjectFunction value) function,
  }) {
    return sequence(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseObjectSchema value)? schema,
    TResult? Function(DatabaseObjectTable value)? table,
    TResult? Function(DatabaseObjectView value)? view,
    TResult? Function(DatabaseObjectColumn value)? column,
    TResult? Function(DatabaseObjectIndex value)? index,
    TResult? Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult? Function(DatabaseObjectSequence value)? sequence,
    TResult? Function(DatabaseObjectTrigger value)? trigger,
    TResult? Function(DatabaseObjectProcedure value)? procedure,
    TResult? Function(DatabaseObjectFunction value)? function,
  }) {
    return sequence?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseObjectSchema value)? schema,
    TResult Function(DatabaseObjectTable value)? table,
    TResult Function(DatabaseObjectView value)? view,
    TResult Function(DatabaseObjectColumn value)? column,
    TResult Function(DatabaseObjectIndex value)? index,
    TResult Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult Function(DatabaseObjectSequence value)? sequence,
    TResult Function(DatabaseObjectTrigger value)? trigger,
    TResult Function(DatabaseObjectProcedure value)? procedure,
    TResult Function(DatabaseObjectFunction value)? function,
    required TResult orElse(),
  }) {
    if (sequence != null) {
      return sequence(this);
    }
    return orElse();
  }
}

abstract class DatabaseObjectSequence implements DatabaseObject {
  const factory DatabaseObjectSequence(
      {required final String schema,
      required final String name}) = _$DatabaseObjectSequenceImpl;

  String get schema;
  @override
  String get name;

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabaseObjectSequenceImplCopyWith<_$DatabaseObjectSequenceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatabaseObjectTriggerImplCopyWith<$Res>
    implements $DatabaseObjectCopyWith<$Res> {
  factory _$$DatabaseObjectTriggerImplCopyWith(
          _$DatabaseObjectTriggerImpl value,
          $Res Function(_$DatabaseObjectTriggerImpl) then) =
      __$$DatabaseObjectTriggerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String schema, String table, String name});
}

/// @nodoc
class __$$DatabaseObjectTriggerImplCopyWithImpl<$Res>
    extends _$DatabaseObjectCopyWithImpl<$Res, _$DatabaseObjectTriggerImpl>
    implements _$$DatabaseObjectTriggerImplCopyWith<$Res> {
  __$$DatabaseObjectTriggerImplCopyWithImpl(_$DatabaseObjectTriggerImpl _value,
      $Res Function(_$DatabaseObjectTriggerImpl) _then)
      : super(_value, _then);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? table = null,
    Object? name = null,
  }) {
    return _then(_$DatabaseObjectTriggerImpl(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DatabaseObjectTriggerImpl implements DatabaseObjectTrigger {
  const _$DatabaseObjectTriggerImpl(
      {required this.schema, required this.table, required this.name});

  @override
  final String schema;
  @override
  final String table;
  @override
  final String name;

  @override
  String toString() {
    return 'DatabaseObject.trigger(schema: $schema, table: $table, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseObjectTriggerImpl &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, schema, table, name);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseObjectTriggerImplCopyWith<_$DatabaseObjectTriggerImpl>
      get copyWith => __$$DatabaseObjectTriggerImplCopyWithImpl<
          _$DatabaseObjectTriggerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) schema,
    required TResult Function(String schema, String name) table,
    required TResult Function(String schema, String name) view,
    required TResult Function(String schema, String table, String name) column,
    required TResult Function(String schema, String table, String name) index,
    required TResult Function(String schema, String table, String name)
        foreignKey,
    required TResult Function(String schema, String name) sequence,
    required TResult Function(String schema, String table, String name) trigger,
    required TResult Function(String schema, String name) procedure,
    required TResult Function(String schema, String name) function,
  }) {
    return trigger(this.schema, this.table, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? schema,
    TResult? Function(String schema, String name)? table,
    TResult? Function(String schema, String name)? view,
    TResult? Function(String schema, String table, String name)? column,
    TResult? Function(String schema, String table, String name)? index,
    TResult? Function(String schema, String table, String name)? foreignKey,
    TResult? Function(String schema, String name)? sequence,
    TResult? Function(String schema, String table, String name)? trigger,
    TResult? Function(String schema, String name)? procedure,
    TResult? Function(String schema, String name)? function,
  }) {
    return trigger?.call(this.schema, this.table, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? schema,
    TResult Function(String schema, String name)? table,
    TResult Function(String schema, String name)? view,
    TResult Function(String schema, String table, String name)? column,
    TResult Function(String schema, String table, String name)? index,
    TResult Function(String schema, String table, String name)? foreignKey,
    TResult Function(String schema, String name)? sequence,
    TResult Function(String schema, String table, String name)? trigger,
    TResult Function(String schema, String name)? procedure,
    TResult Function(String schema, String name)? function,
    required TResult orElse(),
  }) {
    if (trigger != null) {
      return trigger(this.schema, this.table, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DatabaseObjectSchema value) schema,
    required TResult Function(DatabaseObjectTable value) table,
    required TResult Function(DatabaseObjectView value) view,
    required TResult Function(DatabaseObjectColumn value) column,
    required TResult Function(DatabaseObjectIndex value) index,
    required TResult Function(DatabaseObjectForeignKey value) foreignKey,
    required TResult Function(DatabaseObjectSequence value) sequence,
    required TResult Function(DatabaseObjectTrigger value) trigger,
    required TResult Function(DatabaseObjectProcedure value) procedure,
    required TResult Function(DatabaseObjectFunction value) function,
  }) {
    return trigger(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseObjectSchema value)? schema,
    TResult? Function(DatabaseObjectTable value)? table,
    TResult? Function(DatabaseObjectView value)? view,
    TResult? Function(DatabaseObjectColumn value)? column,
    TResult? Function(DatabaseObjectIndex value)? index,
    TResult? Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult? Function(DatabaseObjectSequence value)? sequence,
    TResult? Function(DatabaseObjectTrigger value)? trigger,
    TResult? Function(DatabaseObjectProcedure value)? procedure,
    TResult? Function(DatabaseObjectFunction value)? function,
  }) {
    return trigger?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseObjectSchema value)? schema,
    TResult Function(DatabaseObjectTable value)? table,
    TResult Function(DatabaseObjectView value)? view,
    TResult Function(DatabaseObjectColumn value)? column,
    TResult Function(DatabaseObjectIndex value)? index,
    TResult Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult Function(DatabaseObjectSequence value)? sequence,
    TResult Function(DatabaseObjectTrigger value)? trigger,
    TResult Function(DatabaseObjectProcedure value)? procedure,
    TResult Function(DatabaseObjectFunction value)? function,
    required TResult orElse(),
  }) {
    if (trigger != null) {
      return trigger(this);
    }
    return orElse();
  }
}

abstract class DatabaseObjectTrigger implements DatabaseObject {
  const factory DatabaseObjectTrigger(
      {required final String schema,
      required final String table,
      required final String name}) = _$DatabaseObjectTriggerImpl;

  String get schema;
  String get table;
  @override
  String get name;

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabaseObjectTriggerImplCopyWith<_$DatabaseObjectTriggerImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatabaseObjectProcedureImplCopyWith<$Res>
    implements $DatabaseObjectCopyWith<$Res> {
  factory _$$DatabaseObjectProcedureImplCopyWith(
          _$DatabaseObjectProcedureImpl value,
          $Res Function(_$DatabaseObjectProcedureImpl) then) =
      __$$DatabaseObjectProcedureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String schema, String name});
}

/// @nodoc
class __$$DatabaseObjectProcedureImplCopyWithImpl<$Res>
    extends _$DatabaseObjectCopyWithImpl<$Res, _$DatabaseObjectProcedureImpl>
    implements _$$DatabaseObjectProcedureImplCopyWith<$Res> {
  __$$DatabaseObjectProcedureImplCopyWithImpl(
      _$DatabaseObjectProcedureImpl _value,
      $Res Function(_$DatabaseObjectProcedureImpl) _then)
      : super(_value, _then);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? name = null,
  }) {
    return _then(_$DatabaseObjectProcedureImpl(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DatabaseObjectProcedureImpl implements DatabaseObjectProcedure {
  const _$DatabaseObjectProcedureImpl(
      {required this.schema, required this.name});

  @override
  final String schema;
  @override
  final String name;

  @override
  String toString() {
    return 'DatabaseObject.procedure(schema: $schema, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseObjectProcedureImpl &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, schema, name);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseObjectProcedureImplCopyWith<_$DatabaseObjectProcedureImpl>
      get copyWith => __$$DatabaseObjectProcedureImplCopyWithImpl<
          _$DatabaseObjectProcedureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) schema,
    required TResult Function(String schema, String name) table,
    required TResult Function(String schema, String name) view,
    required TResult Function(String schema, String table, String name) column,
    required TResult Function(String schema, String table, String name) index,
    required TResult Function(String schema, String table, String name)
        foreignKey,
    required TResult Function(String schema, String name) sequence,
    required TResult Function(String schema, String table, String name) trigger,
    required TResult Function(String schema, String name) procedure,
    required TResult Function(String schema, String name) function,
  }) {
    return procedure(this.schema, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? schema,
    TResult? Function(String schema, String name)? table,
    TResult? Function(String schema, String name)? view,
    TResult? Function(String schema, String table, String name)? column,
    TResult? Function(String schema, String table, String name)? index,
    TResult? Function(String schema, String table, String name)? foreignKey,
    TResult? Function(String schema, String name)? sequence,
    TResult? Function(String schema, String table, String name)? trigger,
    TResult? Function(String schema, String name)? procedure,
    TResult? Function(String schema, String name)? function,
  }) {
    return procedure?.call(this.schema, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? schema,
    TResult Function(String schema, String name)? table,
    TResult Function(String schema, String name)? view,
    TResult Function(String schema, String table, String name)? column,
    TResult Function(String schema, String table, String name)? index,
    TResult Function(String schema, String table, String name)? foreignKey,
    TResult Function(String schema, String name)? sequence,
    TResult Function(String schema, String table, String name)? trigger,
    TResult Function(String schema, String name)? procedure,
    TResult Function(String schema, String name)? function,
    required TResult orElse(),
  }) {
    if (procedure != null) {
      return procedure(this.schema, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DatabaseObjectSchema value) schema,
    required TResult Function(DatabaseObjectTable value) table,
    required TResult Function(DatabaseObjectView value) view,
    required TResult Function(DatabaseObjectColumn value) column,
    required TResult Function(DatabaseObjectIndex value) index,
    required TResult Function(DatabaseObjectForeignKey value) foreignKey,
    required TResult Function(DatabaseObjectSequence value) sequence,
    required TResult Function(DatabaseObjectTrigger value) trigger,
    required TResult Function(DatabaseObjectProcedure value) procedure,
    required TResult Function(DatabaseObjectFunction value) function,
  }) {
    return procedure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseObjectSchema value)? schema,
    TResult? Function(DatabaseObjectTable value)? table,
    TResult? Function(DatabaseObjectView value)? view,
    TResult? Function(DatabaseObjectColumn value)? column,
    TResult? Function(DatabaseObjectIndex value)? index,
    TResult? Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult? Function(DatabaseObjectSequence value)? sequence,
    TResult? Function(DatabaseObjectTrigger value)? trigger,
    TResult? Function(DatabaseObjectProcedure value)? procedure,
    TResult? Function(DatabaseObjectFunction value)? function,
  }) {
    return procedure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseObjectSchema value)? schema,
    TResult Function(DatabaseObjectTable value)? table,
    TResult Function(DatabaseObjectView value)? view,
    TResult Function(DatabaseObjectColumn value)? column,
    TResult Function(DatabaseObjectIndex value)? index,
    TResult Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult Function(DatabaseObjectSequence value)? sequence,
    TResult Function(DatabaseObjectTrigger value)? trigger,
    TResult Function(DatabaseObjectProcedure value)? procedure,
    TResult Function(DatabaseObjectFunction value)? function,
    required TResult orElse(),
  }) {
    if (procedure != null) {
      return procedure(this);
    }
    return orElse();
  }
}

abstract class DatabaseObjectProcedure implements DatabaseObject {
  const factory DatabaseObjectProcedure(
      {required final String schema,
      required final String name}) = _$DatabaseObjectProcedureImpl;

  String get schema;
  @override
  String get name;

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabaseObjectProcedureImplCopyWith<_$DatabaseObjectProcedureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatabaseObjectFunctionImplCopyWith<$Res>
    implements $DatabaseObjectCopyWith<$Res> {
  factory _$$DatabaseObjectFunctionImplCopyWith(
          _$DatabaseObjectFunctionImpl value,
          $Res Function(_$DatabaseObjectFunctionImpl) then) =
      __$$DatabaseObjectFunctionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String schema, String name});
}

/// @nodoc
class __$$DatabaseObjectFunctionImplCopyWithImpl<$Res>
    extends _$DatabaseObjectCopyWithImpl<$Res, _$DatabaseObjectFunctionImpl>
    implements _$$DatabaseObjectFunctionImplCopyWith<$Res> {
  __$$DatabaseObjectFunctionImplCopyWithImpl(
      _$DatabaseObjectFunctionImpl _value,
      $Res Function(_$DatabaseObjectFunctionImpl) _then)
      : super(_value, _then);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? name = null,
  }) {
    return _then(_$DatabaseObjectFunctionImpl(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DatabaseObjectFunctionImpl implements DatabaseObjectFunction {
  const _$DatabaseObjectFunctionImpl(
      {required this.schema, required this.name});

  @override
  final String schema;
  @override
  final String name;

  @override
  String toString() {
    return 'DatabaseObject.function(schema: $schema, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseObjectFunctionImpl &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, schema, name);

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseObjectFunctionImplCopyWith<_$DatabaseObjectFunctionImpl>
      get copyWith => __$$DatabaseObjectFunctionImplCopyWithImpl<
          _$DatabaseObjectFunctionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) schema,
    required TResult Function(String schema, String name) table,
    required TResult Function(String schema, String name) view,
    required TResult Function(String schema, String table, String name) column,
    required TResult Function(String schema, String table, String name) index,
    required TResult Function(String schema, String table, String name)
        foreignKey,
    required TResult Function(String schema, String name) sequence,
    required TResult Function(String schema, String table, String name) trigger,
    required TResult Function(String schema, String name) procedure,
    required TResult Function(String schema, String name) function,
  }) {
    return function(this.schema, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? schema,
    TResult? Function(String schema, String name)? table,
    TResult? Function(String schema, String name)? view,
    TResult? Function(String schema, String table, String name)? column,
    TResult? Function(String schema, String table, String name)? index,
    TResult? Function(String schema, String table, String name)? foreignKey,
    TResult? Function(String schema, String name)? sequence,
    TResult? Function(String schema, String table, String name)? trigger,
    TResult? Function(String schema, String name)? procedure,
    TResult? Function(String schema, String name)? function,
  }) {
    return function?.call(this.schema, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? schema,
    TResult Function(String schema, String name)? table,
    TResult Function(String schema, String name)? view,
    TResult Function(String schema, String table, String name)? column,
    TResult Function(String schema, String table, String name)? index,
    TResult Function(String schema, String table, String name)? foreignKey,
    TResult Function(String schema, String name)? sequence,
    TResult Function(String schema, String table, String name)? trigger,
    TResult Function(String schema, String name)? procedure,
    TResult Function(String schema, String name)? function,
    required TResult orElse(),
  }) {
    if (function != null) {
      return function(this.schema, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DatabaseObjectSchema value) schema,
    required TResult Function(DatabaseObjectTable value) table,
    required TResult Function(DatabaseObjectView value) view,
    required TResult Function(DatabaseObjectColumn value) column,
    required TResult Function(DatabaseObjectIndex value) index,
    required TResult Function(DatabaseObjectForeignKey value) foreignKey,
    required TResult Function(DatabaseObjectSequence value) sequence,
    required TResult Function(DatabaseObjectTrigger value) trigger,
    required TResult Function(DatabaseObjectProcedure value) procedure,
    required TResult Function(DatabaseObjectFunction value) function,
  }) {
    return function(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseObjectSchema value)? schema,
    TResult? Function(DatabaseObjectTable value)? table,
    TResult? Function(DatabaseObjectView value)? view,
    TResult? Function(DatabaseObjectColumn value)? column,
    TResult? Function(DatabaseObjectIndex value)? index,
    TResult? Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult? Function(DatabaseObjectSequence value)? sequence,
    TResult? Function(DatabaseObjectTrigger value)? trigger,
    TResult? Function(DatabaseObjectProcedure value)? procedure,
    TResult? Function(DatabaseObjectFunction value)? function,
  }) {
    return function?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseObjectSchema value)? schema,
    TResult Function(DatabaseObjectTable value)? table,
    TResult Function(DatabaseObjectView value)? view,
    TResult Function(DatabaseObjectColumn value)? column,
    TResult Function(DatabaseObjectIndex value)? index,
    TResult Function(DatabaseObjectForeignKey value)? foreignKey,
    TResult Function(DatabaseObjectSequence value)? sequence,
    TResult Function(DatabaseObjectTrigger value)? trigger,
    TResult Function(DatabaseObjectProcedure value)? procedure,
    TResult Function(DatabaseObjectFunction value)? function,
    required TResult orElse(),
  }) {
    if (function != null) {
      return function(this);
    }
    return orElse();
  }
}

abstract class DatabaseObjectFunction implements DatabaseObject {
  const factory DatabaseObjectFunction(
      {required final String schema,
      required final String name}) = _$DatabaseObjectFunctionImpl;

  String get schema;
  @override
  String get name;

  /// Create a copy of DatabaseObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabaseObjectFunctionImplCopyWith<_$DatabaseObjectFunctionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
