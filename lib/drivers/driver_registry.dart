import 'package:mydb/drivers/driver_interface.dart';
import 'package:mydb/models/connection_profile.dart';
import 'package:mydb/models/database_type.dart';

typedef DriverFactory = DatabaseDriver Function();

class DriverNotFoundException implements Exception {
  DriverNotFoundException(this.type);

  final DatabaseType type;

  @override
  String toString() => 'DriverNotFoundException: no driver for ${type.name}';
}

/// Registers and instantiates drivers by [DatabaseType].
class DriverRegistry {
  DriverRegistry._();

  static final Map<DatabaseType, DriverFactory> _drivers =
      <DatabaseType, DriverFactory>{};

  /// Call from [main] before runApp.
  static void register(DatabaseType type, DriverFactory factory) {
    _drivers[type] = factory;
  }

  static DatabaseDriver create(ConnectionProfile profile) {
    final factory = _drivers[profile.type];
    if (factory == null) {
      throw DriverNotFoundException(profile.type);
    }
    return factory();
  }

  static bool isRegistered(DatabaseType type) => _drivers.containsKey(type);
}
