import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mydb/models/connection_pool_config.dart';
import 'package:mydb/models/database_type.dart';
import 'package:mydb/models/ssh_config.dart';
import 'package:mydb/models/ssl_config.dart';

part 'connection_profile.freezed.dart';
part 'connection_profile.g.dart';

@freezed
class ConnectionProfile with _$ConnectionProfile {
  const factory ConnectionProfile({
    required String id,
    required String name,
    required DatabaseType type,
    required String host,
    required int port,
    required String database,
    required String username,
    /// Filled in memory before [DatabaseDriver.connect]; never persisted to JSON.
    @JsonKey(includeFromJson: false, includeToJson: false) String? password,
    SSLConfig? ssl,
    SSHConfig? ssh,
    @Default(ConnectionPoolConfig()) ConnectionPoolConfig pool,
    @Default('#1565C0') String colorHex,
    required DateTime createdAt,
  }) = _ConnectionProfile;

  factory ConnectionProfile.fromJson(Map<String, dynamic> json) =>
      _$ConnectionProfileFromJson(json);
}
