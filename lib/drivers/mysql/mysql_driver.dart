import 'package:mydb/drivers/stub_driver_base.dart';
import 'package:mydb/models/database_type.dart';

class MySQLDriver extends StubDatabaseDriver {
  MySQLDriver() : super(DatabaseType.mysql);
}
