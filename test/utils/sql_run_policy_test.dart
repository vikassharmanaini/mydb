import 'package:flutter_test/flutter_test.dart';
import 'package:mydb/utils/sql_run_policy.dart';

void main() {
  group('sqlLooksLikeMultipleStatements', () {
    test('single statement without trailing content is false', () {
      expect(sqlLooksLikeMultipleStatements('SELECT 1'), isFalse);
      expect(sqlLooksLikeMultipleStatements('SELECT 1;'), isFalse);
    });

    test('two statements', () {
      expect(
        sqlLooksLikeMultipleStatements('SELECT 1; SELECT 2'),
        isTrue,
      );
    });
  });

  group('sqlPrefersExecuteUpdate', () {
    test('SELECT is false', () {
      expect(sqlPrefersExecuteUpdate('SELECT * FROM t'), isFalse);
    });

    test('INSERT without RETURNING is true', () {
      expect(sqlPrefersExecuteUpdate('INSERT INTO t VALUES (1)'), isTrue);
    });

    test('INSERT with RETURNING uses query path', () {
      expect(
        sqlPrefersExecuteUpdate('INSERT INTO t VALUES (1) RETURNING id'),
        isFalse,
      );
    });
  });
}
