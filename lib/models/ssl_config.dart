import 'package:freezed_annotation/freezed_annotation.dart';

part 'ssl_config.freezed.dart';
part 'ssl_config.g.dart';

/// SSL/TLS mode for database connections.
@JsonEnum(fieldRename: FieldRename.snake, alwaysCreate: true)
enum SslMode {
  disable,
  allow,
  require,
  verifyFull,
}

@freezed
class SSLConfig with _$SSLConfig {
  const factory SSLConfig({
    @Default(SslMode.require) SslMode mode,
    String? caCertPath,
    String? clientCertPath,
    String? clientKeyPath,
  }) = _SSLConfig;

  factory SSLConfig.fromJson(Map<String, dynamic> json) =>
      _$SSLConfigFromJson(json);
}
