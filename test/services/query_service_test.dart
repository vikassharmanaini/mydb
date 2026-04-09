import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydb/drivers/connection_event.dart';
import 'package:mydb/drivers/driver_interface.dart';
import 'package:mydb/local_db/app_database.dart';
import 'package:mydb/models/database_type.dart';
import 'package:mydb/models/query_history_entry.dart';
import 'package:mydb/models/result_page.dart';
import 'package:mydb/services/query_service.dart';
import 'package:uuid/uuid.dart';

class _MockDriver extends Mock implements DatabaseDriver {}

void main() {
  late _MockDriver driver;
  late AppDatabase db;

  setUp(() {
    driver = _MockDriver();
    db = AppDatabase.memory();
    when(() => driver.type).thenReturn(DatabaseType.postgres);
    when(() => driver.isConnected).thenReturn(true);
    when(() => driver.events).thenAnswer(
      (_) => const Stream<ConnectionEvent>.empty(),
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('executeQuery writes history after successful stream', () async {
    when(() => driver.executeQuery(any(), pageSize: any(named: 'pageSize')))
        .thenAnswer(
      (_) => Stream<ResultPage>.value(
        const ResultPage(
          pageIndex: 0,
          pageSize: 500,
          columns: <String>['a'],
          rows: <List<dynamic>>[<dynamic>[1]],
          queryDuration: Duration.zero,
        ),
      ),
    );

    final QueryService svc = QueryService(
      driver: driver,
      connectionId: 'conn-a',
      historyDao: db.historyDao,
      uuid: const Uuid(),
    );

    final List<ResultPage> pages =
        await svc.executeQuery('SELECT 1').toList();
    expect(pages, hasLength(1));

    final List<QueryHistoryEntry> recent = await db.historyDao.listRecent();
    expect(recent, hasLength(1));
    expect(recent.single.sql, 'SELECT 1');
    expect(recent.single.success, isTrue);
    expect(recent.single.connectionId, 'conn-a');
  });

  test('executeQuery writes failure history when driver throws', () async {
    when(() => driver.executeQuery(any(), pageSize: any(named: 'pageSize')))
        .thenAnswer((_) => Stream<ResultPage>.error(Exception('boom')));

    final QueryService svc = QueryService(
      driver: driver,
      connectionId: 'conn-b',
      historyDao: db.historyDao,
      uuid: const Uuid(),
    );

    await expectLater(
      svc.executeQuery('BAD').drain<void>(),
      throwsException,
    );

    final List<QueryHistoryEntry> recent = await db.historyDao.listRecent();
    expect(recent, hasLength(1));
    expect(recent.single.success, isFalse);
    expect(recent.single.sql, 'BAD');
  });

  test('executeUpdate records history', () async {
    when(() => driver.executeUpdate(any())).thenAnswer((_) async => 3);

    final QueryService svc = QueryService(
      driver: driver,
      connectionId: 'conn-c',
      historyDao: db.historyDao,
      uuid: const Uuid(),
    );

    final int n = await svc.executeUpdate('DELETE FROM t WHERE 1=0');
    expect(n, 3);
    final List<QueryHistoryEntry> recent = await db.historyDao.listRecent();
    expect(recent, hasLength(1));
    expect(recent.single.success, isTrue);
  });

  test('recordHistory false skips dao', () async {
    when(() => driver.executeUpdate(any())).thenAnswer((_) async => 1);

    final QueryService svc = QueryService(
      driver: driver,
      connectionId: 'conn-d',
      historyDao: db.historyDao,
      recordHistory: false,
      uuid: const Uuid(),
    );

    await svc.executeUpdate('UPDATE x SET y=1');
    expect(await db.historyDao.listRecent(), isEmpty);
  });
}
