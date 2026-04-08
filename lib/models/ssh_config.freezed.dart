// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ssh_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SSHConfig _$SSHConfigFromJson(Map<String, dynamic> json) {
  return _SSHConfig.fromJson(json);
}

/// @nodoc
mixin _$SSHConfig {
  String get host => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;

  /// Path to private key file on disk (optional if password auth).
  String? get privateKeyPath => throw _privateConstructorUsedError;

  /// Key passphrase stored via [CredentialService], not serialized here.
  bool get hasKeyPassphrase => throw _privateConstructorUsedError;

  /// Serializes this SSHConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SSHConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SSHConfigCopyWith<SSHConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SSHConfigCopyWith<$Res> {
  factory $SSHConfigCopyWith(SSHConfig value, $Res Function(SSHConfig) then) =
      _$SSHConfigCopyWithImpl<$Res, SSHConfig>;
  @useResult
  $Res call(
      {String host,
      int port,
      String username,
      String? privateKeyPath,
      bool hasKeyPassphrase});
}

/// @nodoc
class _$SSHConfigCopyWithImpl<$Res, $Val extends SSHConfig>
    implements $SSHConfigCopyWith<$Res> {
  _$SSHConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SSHConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? port = null,
    Object? username = null,
    Object? privateKeyPath = freezed,
    Object? hasKeyPassphrase = null,
  }) {
    return _then(_value.copyWith(
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      privateKeyPath: freezed == privateKeyPath
          ? _value.privateKeyPath
          : privateKeyPath // ignore: cast_nullable_to_non_nullable
              as String?,
      hasKeyPassphrase: null == hasKeyPassphrase
          ? _value.hasKeyPassphrase
          : hasKeyPassphrase // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SSHConfigImplCopyWith<$Res>
    implements $SSHConfigCopyWith<$Res> {
  factory _$$SSHConfigImplCopyWith(
          _$SSHConfigImpl value, $Res Function(_$SSHConfigImpl) then) =
      __$$SSHConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String host,
      int port,
      String username,
      String? privateKeyPath,
      bool hasKeyPassphrase});
}

/// @nodoc
class __$$SSHConfigImplCopyWithImpl<$Res>
    extends _$SSHConfigCopyWithImpl<$Res, _$SSHConfigImpl>
    implements _$$SSHConfigImplCopyWith<$Res> {
  __$$SSHConfigImplCopyWithImpl(
      _$SSHConfigImpl _value, $Res Function(_$SSHConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of SSHConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? port = null,
    Object? username = null,
    Object? privateKeyPath = freezed,
    Object? hasKeyPassphrase = null,
  }) {
    return _then(_$SSHConfigImpl(
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      privateKeyPath: freezed == privateKeyPath
          ? _value.privateKeyPath
          : privateKeyPath // ignore: cast_nullable_to_non_nullable
              as String?,
      hasKeyPassphrase: null == hasKeyPassphrase
          ? _value.hasKeyPassphrase
          : hasKeyPassphrase // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SSHConfigImpl implements _SSHConfig {
  const _$SSHConfigImpl(
      {required this.host,
      this.port = 22,
      required this.username,
      this.privateKeyPath,
      this.hasKeyPassphrase = false});

  factory _$SSHConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$SSHConfigImplFromJson(json);

  @override
  final String host;
  @override
  @JsonKey()
  final int port;
  @override
  final String username;

  /// Path to private key file on disk (optional if password auth).
  @override
  final String? privateKeyPath;

  /// Key passphrase stored via [CredentialService], not serialized here.
  @override
  @JsonKey()
  final bool hasKeyPassphrase;

  @override
  String toString() {
    return 'SSHConfig(host: $host, port: $port, username: $username, privateKeyPath: $privateKeyPath, hasKeyPassphrase: $hasKeyPassphrase)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SSHConfigImpl &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.privateKeyPath, privateKeyPath) ||
                other.privateKeyPath == privateKeyPath) &&
            (identical(other.hasKeyPassphrase, hasKeyPassphrase) ||
                other.hasKeyPassphrase == hasKeyPassphrase));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, host, port, username, privateKeyPath, hasKeyPassphrase);

  /// Create a copy of SSHConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SSHConfigImplCopyWith<_$SSHConfigImpl> get copyWith =>
      __$$SSHConfigImplCopyWithImpl<_$SSHConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SSHConfigImplToJson(
      this,
    );
  }
}

abstract class _SSHConfig implements SSHConfig {
  const factory _SSHConfig(
      {required final String host,
      final int port,
      required final String username,
      final String? privateKeyPath,
      final bool hasKeyPassphrase}) = _$SSHConfigImpl;

  factory _SSHConfig.fromJson(Map<String, dynamic> json) =
      _$SSHConfigImpl.fromJson;

  @override
  String get host;
  @override
  int get port;
  @override
  String get username;

  /// Path to private key file on disk (optional if password auth).
  @override
  String? get privateKeyPath;

  /// Key passphrase stored via [CredentialService], not serialized here.
  @override
  bool get hasKeyPassphrase;

  /// Create a copy of SSHConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SSHConfigImplCopyWith<_$SSHConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
