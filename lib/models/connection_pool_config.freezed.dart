// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_pool_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConnectionPoolConfig _$ConnectionPoolConfigFromJson(Map<String, dynamic> json) {
  return _ConnectionPoolConfig.fromJson(json);
}

/// @nodoc
mixin _$ConnectionPoolConfig {
  int get minSize => throw _privateConstructorUsedError;
  int get maxSize => throw _privateConstructorUsedError;

  /// Idle timeout in seconds (pool eviction).
  int get idleTimeoutSeconds => throw _privateConstructorUsedError;

  /// Serializes this ConnectionPoolConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionPoolConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionPoolConfigCopyWith<ConnectionPoolConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionPoolConfigCopyWith<$Res> {
  factory $ConnectionPoolConfigCopyWith(ConnectionPoolConfig value,
          $Res Function(ConnectionPoolConfig) then) =
      _$ConnectionPoolConfigCopyWithImpl<$Res, ConnectionPoolConfig>;
  @useResult
  $Res call({int minSize, int maxSize, int idleTimeoutSeconds});
}

/// @nodoc
class _$ConnectionPoolConfigCopyWithImpl<$Res,
        $Val extends ConnectionPoolConfig>
    implements $ConnectionPoolConfigCopyWith<$Res> {
  _$ConnectionPoolConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionPoolConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minSize = null,
    Object? maxSize = null,
    Object? idleTimeoutSeconds = null,
  }) {
    return _then(_value.copyWith(
      minSize: null == minSize
          ? _value.minSize
          : minSize // ignore: cast_nullable_to_non_nullable
              as int,
      maxSize: null == maxSize
          ? _value.maxSize
          : maxSize // ignore: cast_nullable_to_non_nullable
              as int,
      idleTimeoutSeconds: null == idleTimeoutSeconds
          ? _value.idleTimeoutSeconds
          : idleTimeoutSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConnectionPoolConfigImplCopyWith<$Res>
    implements $ConnectionPoolConfigCopyWith<$Res> {
  factory _$$ConnectionPoolConfigImplCopyWith(_$ConnectionPoolConfigImpl value,
          $Res Function(_$ConnectionPoolConfigImpl) then) =
      __$$ConnectionPoolConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int minSize, int maxSize, int idleTimeoutSeconds});
}

/// @nodoc
class __$$ConnectionPoolConfigImplCopyWithImpl<$Res>
    extends _$ConnectionPoolConfigCopyWithImpl<$Res, _$ConnectionPoolConfigImpl>
    implements _$$ConnectionPoolConfigImplCopyWith<$Res> {
  __$$ConnectionPoolConfigImplCopyWithImpl(_$ConnectionPoolConfigImpl _value,
      $Res Function(_$ConnectionPoolConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionPoolConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minSize = null,
    Object? maxSize = null,
    Object? idleTimeoutSeconds = null,
  }) {
    return _then(_$ConnectionPoolConfigImpl(
      minSize: null == minSize
          ? _value.minSize
          : minSize // ignore: cast_nullable_to_non_nullable
              as int,
      maxSize: null == maxSize
          ? _value.maxSize
          : maxSize // ignore: cast_nullable_to_non_nullable
              as int,
      idleTimeoutSeconds: null == idleTimeoutSeconds
          ? _value.idleTimeoutSeconds
          : idleTimeoutSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionPoolConfigImpl extends _ConnectionPoolConfig {
  const _$ConnectionPoolConfigImpl(
      {this.minSize = 1, this.maxSize = 10, this.idleTimeoutSeconds = 30})
      : super._();

  factory _$ConnectionPoolConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionPoolConfigImplFromJson(json);

  @override
  @JsonKey()
  final int minSize;
  @override
  @JsonKey()
  final int maxSize;

  /// Idle timeout in seconds (pool eviction).
  @override
  @JsonKey()
  final int idleTimeoutSeconds;

  @override
  String toString() {
    return 'ConnectionPoolConfig(minSize: $minSize, maxSize: $maxSize, idleTimeoutSeconds: $idleTimeoutSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionPoolConfigImpl &&
            (identical(other.minSize, minSize) || other.minSize == minSize) &&
            (identical(other.maxSize, maxSize) || other.maxSize == maxSize) &&
            (identical(other.idleTimeoutSeconds, idleTimeoutSeconds) ||
                other.idleTimeoutSeconds == idleTimeoutSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, minSize, maxSize, idleTimeoutSeconds);

  /// Create a copy of ConnectionPoolConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionPoolConfigImplCopyWith<_$ConnectionPoolConfigImpl>
      get copyWith =>
          __$$ConnectionPoolConfigImplCopyWithImpl<_$ConnectionPoolConfigImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionPoolConfigImplToJson(
      this,
    );
  }
}

abstract class _ConnectionPoolConfig extends ConnectionPoolConfig {
  const factory _ConnectionPoolConfig(
      {final int minSize,
      final int maxSize,
      final int idleTimeoutSeconds}) = _$ConnectionPoolConfigImpl;
  const _ConnectionPoolConfig._() : super._();

  factory _ConnectionPoolConfig.fromJson(Map<String, dynamic> json) =
      _$ConnectionPoolConfigImpl.fromJson;

  @override
  int get minSize;
  @override
  int get maxSize;

  /// Idle timeout in seconds (pool eviction).
  @override
  int get idleTimeoutSeconds;

  /// Create a copy of ConnectionPoolConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionPoolConfigImplCopyWith<_$ConnectionPoolConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}
