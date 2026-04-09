import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:mydb/local_db/app_database.dart';
import 'package:mydb/local_db/tables/snippets_table.dart';
import 'package:mydb/models/snippet.dart';

part 'snippet_dao.g.dart';

@DriftAccessor(tables: <Type>[Snippets])
class SnippetDao extends DatabaseAccessor<AppDatabase> with _$SnippetDaoMixin {
  SnippetDao(super.db);

  static Snippet _rowToSnippet(SnippetRow row) {
    List<String> tags = <String>[];
    try {
      final Object? decoded = jsonDecode(row.tagsJson);
      if (decoded is List<dynamic>) {
        tags = decoded.map((dynamic e) => e.toString()).toList();
      }
    } catch (_) {
      tags = <String>[];
    }
    return Snippet(
      id: row.id,
      title: row.title,
      sql: row.sql,
      tags: tags,
      updatedAt: row.updatedAt,
    );
  }

  Future<List<Snippet>> listAll() async {
    final List<SnippetRow> rows = await (select(snippets)
          ..orderBy(<OrderClauseGenerator<$SnippetsTable>>[
            ($SnippetsTable t) => OrderingTerm.desc(t.updatedAt),
          ]))
        .get();
    return rows.map(_rowToSnippet).toList();
  }

  Future<Snippet?> getById(String id) async {
    final SnippetRow? row = await (select(snippets)
          ..where(($SnippetsTable t) => t.id.equals(id))
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : _rowToSnippet(row);
  }

  Future<void> upsert(Snippet snippet) async {
    final String tagsJson = jsonEncode(snippet.tags);
    await into(snippets).insert(
      SnippetsCompanion.insert(
        id: snippet.id,
        title: snippet.title,
        sql: snippet.sql,
        tagsJson: Value<String>(tagsJson),
        updatedAt: snippet.updatedAt,
      ),
      onConflict: DoUpdate(
        ($SnippetsTable _) => SnippetsCompanion(
          title: Value<String>(snippet.title),
          sql: Value<String>(snippet.sql),
          tagsJson: Value<String>(tagsJson),
          updatedAt: Value<DateTime>(snippet.updatedAt),
        ),
      ),
    );
  }

  Future<int> deleteSnippet(String id) async {
    return (await (delete(snippets)..where(($SnippetsTable t) => t.id.equals(id)))
        .go());
  }

  /// Matches [query] as substring of title or tags JSON.
  Future<List<Snippet>> search(String query) async {
    final String q = query.trim();
    if (q.isEmpty) {
      return listAll();
    }
    final String pattern = '%${_escapeLikePattern(q)}%';
    final List<SnippetRow> rows = await (select(snippets)
          ..where(
            ($SnippetsTable t) =>
                t.title.like(pattern) | t.tagsJson.like(pattern),
          )
          ..orderBy(<OrderClauseGenerator<$SnippetsTable>>[
            ($SnippetsTable t) => OrderingTerm.desc(t.updatedAt),
          ]))
        .get();
    return rows.map(_rowToSnippet).toList();
  }

  static String _escapeLikePattern(String raw) {
    return raw
        .replaceAll(r'\', r'\\')
        .replaceAll('%', r'\%')
        .replaceAll('_', r'\_');
  }
}
