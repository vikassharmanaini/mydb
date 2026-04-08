// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ssl_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SSLConfig _$SSLConfigFromJson(Map<String, dynamic> json) {
  return _SSLConfig.fromJson(json);
}

/// @nodoc
mixin _$SSLConfig {
  SslMode get mode => throw _privateConstructorUsedError;
  String? get caCertPath => throw _privateConstructorUsedError;
  String? get clientCertPath => throw _privateConstructorUsedError;
  String? get clientKeyPath => throw _privateConstructorUsedError;

  /// Serializes this SSLConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SSLConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SSLConfigCopyWith<SSLConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SSLConfigCopyWith<$Res> {
  factory $SSLConfigCopyWith(SSLConfig value, $Res Function(SSLConfig) then) =
      _$SSLConfigCopyWithImpl<$Res, SSLConfig>;
  @useResult
  $Res call(
      {SslMode mode,
      String? caCertPath,
      String? clientCertPath,
      String? clientKeyPath});
}

/// @nodoc
class _$SSLConfigCopyWithImpl<$Res, $Val extends SSLConfig>
    implements $SSLConfigCopyWith<$Res> {
  _$SSLConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SSLConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? caCertPath = freezed,
    Object? clientCertPath = freezed,
    Object? clientKeyPath = freezed,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as SslMode,
      caCertPath: freezed == caCertPath
          ? _value.caCertPath
          : caCertPath // ignore: cast_nullable_to_non_nullable
              as String?,
      clientCertPath: freezed == clientCertPath
          ? _value.clientCertPath
          : clientCertPath // ignore: cast_nullable_to_non_nullable
              as String?,
      clientKeyPath: freezed == clientKeyPath
          ? _value.clientKeyPath
          : clientKeyPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SSLConfigImplCopyWith<$Res>
    implements $SSLConfigCopyWith<$Res> {
  factory _$$SSLConfigImplCopyWith(
          _$SSLConfigImpl value, $Res Function(_$SSLConfigImpl) then) =
      __$$SSLConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SslMode mode,
      String? caCertPath,
      String? clientCertPath,
      String? clientKeyPath});
}

/// @nodoc
class __$$SSLConfigImplCopyWithImpl<$Res>
    extends _$SSLConfigCopyWithImpl<$Res, _$SSLConfigImpl>
    implements _$$SSLConfigImplCopyWith<$Res> {
  __$$SSLConfigImplCopyWithImpl(
      _$SSLConfigImpl _value, $Res Function(_$SSLConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of SSLConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? caCertPath = freezed,
    Object? clientCertPath = freezed,
    Object? clientKeyPath = freezed,
  }) {
    return _then(_$SSLConfigImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as SslMode,
      caCertPath: freezed == caCertPath
          ? _value.caCertPath
          : caCertPath // ignore: cast_nullable_to_non_nullable
              as String?,
      clientCertPath: freezed == clientCertPath
          ? _value.clientCertPath
          : clientCertPath // ignore: cast_nullable_to_non_nullable
              as String?,
      clientKeyPath: freezed == clientKeyPath
          ? _value.clientKeyPath
          : clientKeyPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SSLConfigImpl implements _SSLConfig {
  const _$SSLConfigImpl(
      {this.mode = SslMode.require,
      this.caCertPath,
      this.clientCertPath,
      this.clientKeyPath});

  factory _$SSLConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$SSLConfigImplFromJson(json);

  @override
  @JsonKey()
  final SslMode mode;
  @override
  final String? caCertPath;
  @override
  final String? clientCertPath;
  @override
  final String? clientKeyPath;

  @override
  String toString() {
    return 'SSLConfig(mode: $mode, caCertPath: $caCertPath, clientCertPath: $clientCertPath, clientKeyPath: $clientKeyPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SSLConfigImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.caCertPath, caCertPath) ||
                other.caCertPath == caCertPath) &&
            (identical(other.clientCertPath, clientCertPath) ||
                other.clientCertPath == clientCertPath) &&
            (identical(other.clientKeyPath, clientKeyPath) ||
                other.clientKeyPath == clientKeyPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, mode, caCertPath, clientCertPath, clientKeyPath);

  /// Create a copy of SSLConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SSLConfigImplCopyWith<_$SSLConfigImpl> get copyWith =>
      __$$SSLConfigImplCopyWithImpl<_$SSLConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SSLConfigImplToJson(
      this,
    );
  }
}

abstract class _SSLConfig implements SSLConfig {
  const factory _SSLConfig(
      {final SslMode mode,
      final String? caCertPath,
      final String? clientCertPath,
      final String? clientKeyPath}) = _$SSLConfigImpl;

  factory _SSLConfig.fromJson(Map<String, dynamic> json) =
      _$SSLConfigImpl.fromJson;

  @override
  SslMode get mode;
  @override
  String? get caCertPath;
  @override
  String? get clientCertPath;
  @override
  String? get clientKeyPath;

  /// Create a copy of SSLConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SSLConfigImplCopyWith<_$SSLConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
