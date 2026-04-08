import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_event.freezed.dart';

@freezed
sealed class ConnectionEvent with _$ConnectionEvent {
  const factory ConnectionEvent.connected() = ConnectionEventConnected;

  const factory ConnectionEvent.disconnected() = ConnectionEventDisconnected;

  const factory ConnectionEvent.error(
    String message, [
    @Default('') String stackTrace,
  ]) = ConnectionEventError;

  const factory ConnectionEvent.reconnecting() = ConnectionEventReconnecting;
}
