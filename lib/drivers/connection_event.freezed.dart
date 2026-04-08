// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ConnectionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connected,
    required TResult Function() disconnected,
    required TResult Function(String message, String stackTrace) error,
    required TResult Function() reconnecting,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message, String stackTrace)? error,
    TResult? Function()? reconnecting,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connected,
    TResult Function()? disconnected,
    TResult Function(String message, String stackTrace)? error,
    TResult Function()? reconnecting,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionEventConnected value) connected,
    required TResult Function(ConnectionEventDisconnected value) disconnected,
    required TResult Function(ConnectionEventError value) error,
    required TResult Function(ConnectionEventReconnecting value) reconnecting,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionEventConnected value)? connected,
    TResult? Function(ConnectionEventDisconnected value)? disconnected,
    TResult? Function(ConnectionEventError value)? error,
    TResult? Function(ConnectionEventReconnecting value)? reconnecting,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionEventConnected value)? connected,
    TResult Function(ConnectionEventDisconnected value)? disconnected,
    TResult Function(ConnectionEventError value)? error,
    TResult Function(ConnectionEventReconnecting value)? reconnecting,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionEventCopyWith<$Res> {
  factory $ConnectionEventCopyWith(
          ConnectionEvent value, $Res Function(ConnectionEvent) then) =
      _$ConnectionEventCopyWithImpl<$Res, ConnectionEvent>;
}

/// @nodoc
class _$ConnectionEventCopyWithImpl<$Res, $Val extends ConnectionEvent>
    implements $ConnectionEventCopyWith<$Res> {
  _$ConnectionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ConnectionEventConnectedImplCopyWith<$Res> {
  factory _$$ConnectionEventConnectedImplCopyWith(
          _$ConnectionEventConnectedImpl value,
          $Res Function(_$ConnectionEventConnectedImpl) then) =
      __$$ConnectionEventConnectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectionEventConnectedImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$ConnectionEventConnectedImpl>
    implements _$$ConnectionEventConnectedImplCopyWith<$Res> {
  __$$ConnectionEventConnectedImplCopyWithImpl(
      _$ConnectionEventConnectedImpl _value,
      $Res Function(_$ConnectionEventConnectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConnectionEventConnectedImpl implements ConnectionEventConnected {
  const _$ConnectionEventConnectedImpl();

  @override
  String toString() {
    return 'ConnectionEvent.connected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionEventConnectedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connected,
    required TResult Function() disconnected,
    required TResult Function(String message, String stackTrace) error,
    required TResult Function() reconnecting,
  }) {
    return connected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message, String stackTrace)? error,
    TResult? Function()? reconnecting,
  }) {
    return connected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connected,
    TResult Function()? disconnected,
    TResult Function(String message, String stackTrace)? error,
    TResult Function()? reconnecting,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionEventConnected value) connected,
    required TResult Function(ConnectionEventDisconnected value) disconnected,
    required TResult Function(ConnectionEventError value) error,
    required TResult Function(ConnectionEventReconnecting value) reconnecting,
  }) {
    return connected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionEventConnected value)? connected,
    TResult? Function(ConnectionEventDisconnected value)? disconnected,
    TResult? Function(ConnectionEventError value)? error,
    TResult? Function(ConnectionEventReconnecting value)? reconnecting,
  }) {
    return connected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionEventConnected value)? connected,
    TResult Function(ConnectionEventDisconnected value)? disconnected,
    TResult Function(ConnectionEventError value)? error,
    TResult Function(ConnectionEventReconnecting value)? reconnecting,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(this);
    }
    return orElse();
  }
}

abstract class ConnectionEventConnected implements ConnectionEvent {
  const factory ConnectionEventConnected() = _$ConnectionEventConnectedImpl;
}

/// @nodoc
abstract class _$$ConnectionEventDisconnectedImplCopyWith<$Res> {
  factory _$$ConnectionEventDisconnectedImplCopyWith(
          _$ConnectionEventDisconnectedImpl value,
          $Res Function(_$ConnectionEventDisconnectedImpl) then) =
      __$$ConnectionEventDisconnectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectionEventDisconnectedImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res,
        _$ConnectionEventDisconnectedImpl>
    implements _$$ConnectionEventDisconnectedImplCopyWith<$Res> {
  __$$ConnectionEventDisconnectedImplCopyWithImpl(
      _$ConnectionEventDisconnectedImpl _value,
      $Res Function(_$ConnectionEventDisconnectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConnectionEventDisconnectedImpl implements ConnectionEventDisconnected {
  const _$ConnectionEventDisconnectedImpl();

  @override
  String toString() {
    return 'ConnectionEvent.disconnected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionEventDisconnectedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connected,
    required TResult Function() disconnected,
    required TResult Function(String message, String stackTrace) error,
    required TResult Function() reconnecting,
  }) {
    return disconnected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message, String stackTrace)? error,
    TResult? Function()? reconnecting,
  }) {
    return disconnected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connected,
    TResult Function()? disconnected,
    TResult Function(String message, String stackTrace)? error,
    TResult Function()? reconnecting,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionEventConnected value) connected,
    required TResult Function(ConnectionEventDisconnected value) disconnected,
    required TResult Function(ConnectionEventError value) error,
    required TResult Function(ConnectionEventReconnecting value) reconnecting,
  }) {
    return disconnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionEventConnected value)? connected,
    TResult? Function(ConnectionEventDisconnected value)? disconnected,
    TResult? Function(ConnectionEventError value)? error,
    TResult? Function(ConnectionEventReconnecting value)? reconnecting,
  }) {
    return disconnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionEventConnected value)? connected,
    TResult Function(ConnectionEventDisconnected value)? disconnected,
    TResult Function(ConnectionEventError value)? error,
    TResult Function(ConnectionEventReconnecting value)? reconnecting,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected(this);
    }
    return orElse();
  }
}

abstract class ConnectionEventDisconnected implements ConnectionEvent {
  const factory ConnectionEventDisconnected() =
      _$ConnectionEventDisconnectedImpl;
}

/// @nodoc
abstract class _$$ConnectionEventErrorImplCopyWith<$Res> {
  factory _$$ConnectionEventErrorImplCopyWith(_$ConnectionEventErrorImpl value,
          $Res Function(_$ConnectionEventErrorImpl) then) =
      __$$ConnectionEventErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String stackTrace});
}

/// @nodoc
class __$$ConnectionEventErrorImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$ConnectionEventErrorImpl>
    implements _$$ConnectionEventErrorImplCopyWith<$Res> {
  __$$ConnectionEventErrorImplCopyWithImpl(_$ConnectionEventErrorImpl _value,
      $Res Function(_$ConnectionEventErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? stackTrace = null,
  }) {
    return _then(_$ConnectionEventErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConnectionEventErrorImpl implements ConnectionEventError {
  const _$ConnectionEventErrorImpl(this.message, [this.stackTrace = '']);

  @override
  final String message;
  @override
  @JsonKey()
  final String stackTrace;

  @override
  String toString() {
    return 'ConnectionEvent.error(message: $message, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionEventErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, stackTrace);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionEventErrorImplCopyWith<_$ConnectionEventErrorImpl>
      get copyWith =>
          __$$ConnectionEventErrorImplCopyWithImpl<_$ConnectionEventErrorImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connected,
    required TResult Function() disconnected,
    required TResult Function(String message, String stackTrace) error,
    required TResult Function() reconnecting,
  }) {
    return error(message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message, String stackTrace)? error,
    TResult? Function()? reconnecting,
  }) {
    return error?.call(message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connected,
    TResult Function()? disconnected,
    TResult Function(String message, String stackTrace)? error,
    TResult Function()? reconnecting,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionEventConnected value) connected,
    required TResult Function(ConnectionEventDisconnected value) disconnected,
    required TResult Function(ConnectionEventError value) error,
    required TResult Function(ConnectionEventReconnecting value) reconnecting,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionEventConnected value)? connected,
    TResult? Function(ConnectionEventDisconnected value)? disconnected,
    TResult? Function(ConnectionEventError value)? error,
    TResult? Function(ConnectionEventReconnecting value)? reconnecting,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionEventConnected value)? connected,
    TResult Function(ConnectionEventDisconnected value)? disconnected,
    TResult Function(ConnectionEventError value)? error,
    TResult Function(ConnectionEventReconnecting value)? reconnecting,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ConnectionEventError implements ConnectionEvent {
  const factory ConnectionEventError(final String message,
      [final String stackTrace]) = _$ConnectionEventErrorImpl;

  String get message;
  String get stackTrace;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionEventErrorImplCopyWith<_$ConnectionEventErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionEventReconnectingImplCopyWith<$Res> {
  factory _$$ConnectionEventReconnectingImplCopyWith(
          _$ConnectionEventReconnectingImpl value,
          $Res Function(_$ConnectionEventReconnectingImpl) then) =
      __$$ConnectionEventReconnectingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectionEventReconnectingImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res,
        _$ConnectionEventReconnectingImpl>
    implements _$$ConnectionEventReconnectingImplCopyWith<$Res> {
  __$$ConnectionEventReconnectingImplCopyWithImpl(
      _$ConnectionEventReconnectingImpl _value,
      $Res Function(_$ConnectionEventReconnectingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConnectionEventReconnectingImpl implements ConnectionEventReconnecting {
  const _$ConnectionEventReconnectingImpl();

  @override
  String toString() {
    return 'ConnectionEvent.reconnecting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionEventReconnectingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connected,
    required TResult Function() disconnected,
    required TResult Function(String message, String stackTrace) error,
    required TResult Function() reconnecting,
  }) {
    return reconnecting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message, String stackTrace)? error,
    TResult? Function()? reconnecting,
  }) {
    return reconnecting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connected,
    TResult Function()? disconnected,
    TResult Function(String message, String stackTrace)? error,
    TResult Function()? reconnecting,
    required TResult orElse(),
  }) {
    if (reconnecting != null) {
      return reconnecting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionEventConnected value) connected,
    required TResult Function(ConnectionEventDisconnected value) disconnected,
    required TResult Function(ConnectionEventError value) error,
    required TResult Function(ConnectionEventReconnecting value) reconnecting,
  }) {
    return reconnecting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionEventConnected value)? connected,
    TResult? Function(ConnectionEventDisconnected value)? disconnected,
    TResult? Function(ConnectionEventError value)? error,
    TResult? Function(ConnectionEventReconnecting value)? reconnecting,
  }) {
    return reconnecting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionEventConnected value)? connected,
    TResult Function(ConnectionEventDisconnected value)? disconnected,
    TResult Function(ConnectionEventError value)? error,
    TResult Function(ConnectionEventReconnecting value)? reconnecting,
    required TResult orElse(),
  }) {
    if (reconnecting != null) {
      return reconnecting(this);
    }
    return orElse();
  }
}

abstract class ConnectionEventReconnecting implements ConnectionEvent {
  const factory ConnectionEventReconnecting() =
      _$ConnectionEventReconnectingImpl;
}
