import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mydb/local_db/daos/history_dao.dart';
import 'package:mydb/local_db/daos/snippet_dao.dart';
import 'package:mydb/local_db/tables/query_history_table.dart';
import 'package:mydb/local_db/tables/snippets_table.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    final Directory dir = await getApplicationSupportDirectory();
    final File file = File(p.join(dir.path, 'dbstudio', 'app.db'));
    await file.parent.create(recursive: true);
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(
  tables: <Type>[QueryHistory, Snippets],
  daos: <Type>[HistoryDao, SnippetDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// In-memory database for tests.
  factory AppDatabase.memory() => AppDatabase(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Add incremental migrations when schemaVersion increases.
        },
      );
}
