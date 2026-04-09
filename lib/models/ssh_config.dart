import 'package:freezed_annotation/freezed_annotation.dart';

part 'ssh_config.freezed.dart';
part 'ssh_config.g.dart';

@freezed
class SSHConfig with _$SSHConfig {
  const factory SSHConfig({
    required String host,
    @Default(22) int port,
    required String username,
    /// Path to private key file on disk (optional if password auth).
    String? privateKeyPath,
    /// Key passphrase stored via [CredentialService], not serialized here.
    @Default(false) bool hasKeyPassphrase,
    /// SSH login password (in memory only; never written to JSON).
    @JsonKey(includeFromJson: false, includeToJson: false) String? password,
  }) = _SSHConfig;

  factory SSHConfig.fromJson(Map<String, dynamic> json) =>
      _$SSHConfigFromJson(json);
}
