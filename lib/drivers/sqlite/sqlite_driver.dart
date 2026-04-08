import 'package:mydb/drivers/stub_driver_base.dart';
import 'package:mydb/models/database_type.dart';

class SQLiteDriver extends StubDatabaseDriver {
  SQLiteDriver() : super(DatabaseType.sqlite);
}
