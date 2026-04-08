import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_pool_config.freezed.dart';
part 'connection_pool_config.g.dart';

@freezed
class ConnectionPoolConfig with _$ConnectionPoolConfig {
  const factory ConnectionPoolConfig({
    @Default(1) int minSize,
    @Default(10) int maxSize,
    /// Idle timeout in seconds (pool eviction).
    @Default(30) int idleTimeoutSeconds,
  }) = _ConnectionPoolConfig;

  const ConnectionPoolConfig._();

  Duration get idleTimeout => Duration(seconds: idleTimeoutSeconds);

  factory ConnectionPoolConfig.fromJson(Map<String, dynamic> json) =>
      _$ConnectionPoolConfigFromJson(json);
}
