import 'package:mydb/drivers/driver_registry.dart';
import 'package:mydb/models/connection_profile.dart';

/// Opens a short-lived driver connection to validate credentials / reachability.
Future<void> testConnectionProfile(ConnectionProfile profile) async {
  final driver = DriverRegistry.create(profile);
  try {
    await driver.connect(profile);
  } finally {
    await driver.disconnect();
  }
}
