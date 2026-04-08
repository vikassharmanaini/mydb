// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'import_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImportConfig _$ImportConfigFromJson(Map<String, dynamic> json) {
  return _ImportConfig.fromJson(json);
}

/// @nodoc
mixin _$ImportConfig {
  ImportSourceKind get sourceKind => throw _privateConstructorUsedError;
  String get sourcePath => throw _privateConstructorUsedError;
  String get targetSchema => throw _privateConstructorUsedError;
  String get targetTable => throw _privateConstructorUsedError;
  bool get firstRowIsHeader => throw _privateConstructorUsedError;
  bool get continueOnRowError => throw _privateConstructorUsedError;

  /// Serializes this ImportConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImportConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImportConfigCopyWith<ImportConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImportConfigCopyWith<$Res> {
  factory $ImportConfigCopyWith(
          ImportConfig value, $Res Function(ImportConfig) then) =
      _$ImportConfigCopyWithImpl<$Res, ImportConfig>;
  @useResult
  $Res call(
      {ImportSourceKind sourceKind,
      String sourcePath,
      String targetSchema,
      String targetTable,
      bool firstRowIsHeader,
      bool continueOnRowError});
}

/// @nodoc
class _$ImportConfigCopyWithImpl<$Res, $Val extends ImportConfig>
    implements $ImportConfigCopyWith<$Res> {
  _$ImportConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImportConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceKind = null,
    Object? sourcePath = null,
    Object? targetSchema = null,
    Object? targetTable = null,
    Object? firstRowIsHeader = null,
    Object? continueOnRowError = null,
  }) {
    return _then(_value.copyWith(
      sourceKind: null == sourceKind
          ? _value.sourceKind
          : sourceKind // ignore: cast_nullable_to_non_nullable
              as ImportSourceKind,
      sourcePath: null == sourcePath
          ? _value.sourcePath
          : sourcePath // ignore: cast_nullable_to_non_nullable
              as String,
      targetSchema: null == targetSchema
          ? _value.targetSchema
          : targetSchema // ignore: cast_nullable_to_non_nullable
              as String,
      targetTable: null == targetTable
          ? _value.targetTable
          : targetTable // ignore: cast_nullable_to_non_nullable
              as String,
      firstRowIsHeader: null == firstRowIsHeader
          ? _value.firstRowIsHeader
          : firstRowIsHeader // ignore: cast_nullable_to_non_nullable
              as bool,
      continueOnRowError: null == continueOnRowError
          ? _value.continueOnRowError
          : continueOnRowError // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImportConfigImplCopyWith<$Res>
    implements $ImportConfigCopyWith<$Res> {
  factory _$$ImportConfigImplCopyWith(
          _$ImportConfigImpl value, $Res Function(_$ImportConfigImpl) then) =
      __$$ImportConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ImportSourceKind sourceKind,
      String sourcePath,
      String targetSchema,
      String targetTable,
      bool firstRowIsHeader,
      bool continueOnRowError});
}

/// @nodoc
class __$$ImportConfigImplCopyWithImpl<$Res>
    extends _$ImportConfigCopyWithImpl<$Res, _$ImportConfigImpl>
    implements _$$ImportConfigImplCopyWith<$Res> {
  __$$ImportConfigImplCopyWithImpl(
      _$ImportConfigImpl _value, $Res Function(_$ImportConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of ImportConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceKind = null,
    Object? sourcePath = null,
    Object? targetSchema = null,
    Object? targetTable = null,
    Object? firstRowIsHeader = null,
    Object? continueOnRowError = null,
  }) {
    return _then(_$ImportConfigImpl(
      sourceKind: null == sourceKind
          ? _value.sourceKind
          : sourceKind // ignore: cast_nullable_to_non_nullable
              as ImportSourceKind,
      sourcePath: null == sourcePath
          ? _value.sourcePath
          : sourcePath // ignore: cast_nullable_to_non_nullable
              as String,
      targetSchema: null == targetSchema
          ? _value.targetSchema
          : targetSchema // ignore: cast_nullable_to_non_nullable
              as String,
      targetTable: null == targetTable
          ? _value.targetTable
          : targetTable // ignore: cast_nullable_to_non_nullable
              as String,
      firstRowIsHeader: null == firstRowIsHeader
          ? _value.firstRowIsHeader
          : firstRowIsHeader // ignore: cast_nullable_to_non_nullable
              as bool,
      continueOnRowError: null == continueOnRowError
          ? _value.continueOnRowError
          : continueOnRowError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImportConfigImpl implements _ImportConfig {
  const _$ImportConfigImpl(
      {required this.sourceKind,
      required this.sourcePath,
      required this.targetSchema,
      required this.targetTable,
      this.firstRowIsHeader = true,
      this.continueOnRowError = true});

  factory _$ImportConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImportConfigImplFromJson(json);

  @override
  final ImportSourceKind sourceKind;
  @override
  final String sourcePath;
  @override
  final String targetSchema;
  @override
  final String targetTable;
  @override
  @JsonKey()
  final bool firstRowIsHeader;
  @override
  @JsonKey()
  final bool continueOnRowError;

  @override
  String toString() {
    return 'ImportConfig(sourceKind: $sourceKind, sourcePath: $sourcePath, targetSchema: $targetSchema, targetTable: $targetTable, firstRowIsHeader: $firstRowIsHeader, continueOnRowError: $continueOnRowError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImportConfigImpl &&
            (identical(other.sourceKind, sourceKind) ||
                other.sourceKind == sourceKind) &&
            (identical(other.sourcePath, sourcePath) ||
                other.sourcePath == sourcePath) &&
            (identical(other.targetSchema, targetSchema) ||
                other.targetSchema == targetSchema) &&
            (identical(other.targetTable, targetTable) ||
                other.targetTable == targetTable) &&
            (identical(other.firstRowIsHeader, firstRowIsHeader) ||
                other.firstRowIsHeader == firstRowIsHeader) &&
            (identical(other.continueOnRowError, continueOnRowError) ||
                other.continueOnRowError == continueOnRowError));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sourceKind, sourcePath,
      targetSchema, targetTable, firstRowIsHeader, continueOnRowError);

  /// Create a copy of ImportConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImportConfigImplCopyWith<_$ImportConfigImpl> get copyWith =>
      __$$ImportConfigImplCopyWithImpl<_$ImportConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImportConfigImplToJson(
      this,
    );
  }
}

abstract class _ImportConfig implements ImportConfig {
  const factory _ImportConfig(
      {required final ImportSourceKind sourceKind,
      required final String sourcePath,
      required final String targetSchema,
      required final String targetTable,
      final bool firstRowIsHeader,
      final bool continueOnRowError}) = _$ImportConfigImpl;

  factory _ImportConfig.fromJson(Map<String, dynamic> json) =
      _$ImportConfigImpl.fromJson;

  @override
  ImportSourceKind get sourceKind;
  @override
  String get sourcePath;
  @override
  String get targetSchema;
  @override
  String get targetTable;
  @override
  bool get firstRowIsHeader;
  @override
  bool get continueOnRowError;

  /// Create a copy of ImportConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImportConfigImplCopyWith<_$ImportConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
