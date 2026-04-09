import 'package:flutter_test/flutter_test.dart';
import 'package:mydb/local_db/app_database.dart';
import 'package:mydb/models/database_type.dart';
import 'package:mydb/models/query_history_entry.dart';
import 'package:mydb/models/snippet.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.memory();
  });

  tearDown(() async {
    await db.close();
  });

  test('HistoryDao insert, listRecent, searchSql, delete', () async {
    final QueryHistoryEntry e = QueryHistoryEntry(
      id: 'h1',
      connectionId: 'c1',
      databaseType: DatabaseType.postgres,
      sql: 'SELECT * FROM users WHERE name LIKE "%foo%"',
      executedAt: DateTime.utc(2026, 4, 1, 12),
      durationMs: 42,
      success: true,
    );
    await db.historyDao.insertEntry(e);
    final List<QueryHistoryEntry> all = await db.historyDao.listRecent();
    expect(all, hasLength(1));
    expect(all.single.sql, e.sql);

    final List<QueryHistoryEntry> filtered =
        await db.historyDao.listRecent(connectionId: 'c1');
    expect(filtered, hasLength(1));

    final List<QueryHistoryEntry> other =
        await db.historyDao.listRecent(connectionId: 'none');
    expect(other, isEmpty);

    final List<QueryHistoryEntry> found =
        await db.historyDao.searchSql('users');
    expect(found, hasLength(1));

    await db.historyDao.deleteEntry('h1');
    expect(await db.historyDao.listRecent(), isEmpty);
  });

  test('SnippetDao upsert, list, search, delete', () async {
    final Snippet s = Snippet(
      id: 's1',
      title: 'List users',
      sql: 'SELECT * FROM users;',
      tags: <String>['demo', 'select'],
      updatedAt: DateTime.utc(2026, 4, 2),
    );
    await db.snippetDao.upsert(s);
    expect(await db.snippetDao.getById('s1'), isNotNull);

    final List<Snippet> all = await db.snippetDao.listAll();
    expect(all, hasLength(1));
    expect(all.single.tags, s.tags);

    final List<Snippet> hitsBefore =
        await db.snippetDao.search('List');
    expect(hitsBefore, hasLength(1));

    await db.snippetDao.upsert(
      s.copyWith(title: 'Updated', sql: 'SELECT 1;', tags: <String>['x']),
    );
    final Snippet? updated = await db.snippetDao.getById('s1');
    expect(updated?.title, 'Updated');

    final List<Snippet> hits = await db.snippetDao.search('Updated');
    expect(hits, hasLength(1));

    await db.snippetDao.deleteSnippet('s1');
    expect(await db.snippetDao.listAll(), isEmpty);
  });
}
