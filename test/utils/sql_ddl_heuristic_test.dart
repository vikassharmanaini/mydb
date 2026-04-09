import 'package:flutter_test/flutter_test.dart';
import 'package:mydb/utils/sql_ddl_heuristic.dart';

void main() {
  test('detects DDL-ish statements', () {
    expect(sqlLooksLikeDdl('ALTER TABLE t ADD COLUMN x int'), isTrue);
    expect(sqlLooksLikeDdl('create index i on t(a)'), isTrue);
    expect(sqlLooksLikeDdl('SELECT * FROM t'), isFalse);
  });
}
