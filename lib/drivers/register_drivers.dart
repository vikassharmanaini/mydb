import 'package:mydb/drivers/driver_registry.dart';
import 'package:mydb/drivers/mssql/mssql_driver.dart';
import 'package:mydb/drivers/mysql/mysql_driver.dart';
import 'package:mydb/drivers/postgres/postgres_driver.dart';
import 'package:mydb/drivers/sqlite/sqlite_driver.dart';
import 'package:mydb/models/database_type.dart';

/// Registers all built-in drivers. Invoke from [main] before [runApp].
void registerDrivers() {
  DriverRegistry.register(DatabaseType.postgres, PostgresDriver.new);
  DriverRegistry.register(DatabaseType.mysql, MySQLDriver.new);
  DriverRegistry.register(DatabaseType.sqlite, SQLiteDriver.new);
  DriverRegistry.register(DatabaseType.mssql, MssqlDriver.new);
}
