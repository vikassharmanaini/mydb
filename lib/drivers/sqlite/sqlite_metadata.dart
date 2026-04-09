import 'package:mydb/models/database_object.dart';
import 'package:mydb/models/schema_metadata.dart';
import 'package:sqlite3/sqlite3.dart';

/// Catalog helpers for SQLite (`pragma`, `sqlite_master`).
final class SQLiteMetadata {
  SQLiteMetadata._();

  static final RegExp _safeIdent = RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$');

  static void _assertSafeIdent(String name, String label) {
    if (!_safeIdent.hasMatch(name)) {
      throw ArgumentError.value(name, label, 'invalid SQLite identifier');
    }
  }

  static String quoteIdent(String name) {
    _assertSafeIdent(name, 'name');
    return '"${name.replaceAll('"', '""')}"';
  }

  static String _sqlStringLiteral(String s) => "'${s.replaceAll("'", "''")}'";

  static Future<List<SchemaInfo>> listSchemas(Database db) async {
    final rs = db.select('PRAGMA database_list');
    return rs
        .map(
          (Row row) => SchemaInfo(name: row['name']! as String),
        )
        .toList();
  }

  static Future<List<TableInfo>> listTables(Database db, String schema) async {
    _assertSafeIdent(schema, 'schema');
    final q = quoteIdent(schema);
    final rs = db.select('''
SELECT name FROM $q.sqlite_master
WHERE type = 'table' AND name NOT LIKE 'sqlite_%'
ORDER BY name
''');
    return rs
        .map(
          (Row row) => TableInfo(schema: schema, name: row['name']! as String),
        )
        .toList();
  }

  static Future<List<ColumnInfo>> listColumns(
    Database db,
    String schema,
    String table,
  ) async {
    _assertSafeIdent(schema, 'schema');
    _assertSafeIdent(table, 'table');
    final rs = db.select(
      'PRAGMA ${quoteIdent(schema)}.table_info(${_sqlStringLiteral(table)})',
    );
    return rs
        .map(
          (Row row) => ColumnInfo(
            name: row['name']! as String,
            dataType: row['type']! as String,
            ordinalPosition: (row['cid']! as int) + 1,
            nullable: (row['notnull']! as int) == 0,
            defaultValue: row['dflt_value'] as String?,
            isPrimaryKey: (row['pk']! as int) != 0,
          ),
        )
        .toList();
  }

  static Future<List<IndexInfo>> listIndexes(
    Database db,
    String schema,
    String table,
  ) async {
    _assertSafeIdent(schema, 'schema');
    _assertSafeIdent(table, 'table');
    final q = quoteIdent(schema);
    final rs = db.select(
      '''
SELECT name, sql FROM $q.sqlite_master
WHERE type = 'index' AND tbl_name = ? AND sql IS NOT NULL
ORDER BY name
''',
      <Object?>[table],
    );
    return rs
        .map(
          (Row row) {
            final sql = row['sql'] as String? ?? '';
            return IndexInfo(
              name: row['name']! as String,
              unique: sql.toUpperCase().contains('UNIQUE'),
              columnNames: _parseIndexColumnsFromSql(sql),
            );
          },
        )
        .toList();
  }

  static List<String> _parseIndexColumnsFromSql(String sql) {
    final m = RegExp(r'\(([^)]+)\)\s*$').firstMatch(sql);
    if (m == null) {
      return <String>[];
    }
    return m
        .group(1)!
        .split(',')
        .map((String c) => c.trim().split(' ').first.replaceAll('"', ''))
        .where((String c) => c.isNotEmpty)
        .toList();
  }

  static Future<List<ForeignKeyInfo>> listForeignKeys(
    Database db,
    String schema,
    String table,
  ) async {
    _assertSafeIdent(schema, 'schema');
    _assertSafeIdent(table, 'table');
    final rs = db.select(
      'PRAGMA ${quoteIdent(schema)}.foreign_key_list(${_sqlStringLiteral(table)})',
    );
    return rs
        .map(
          (Row row) => ForeignKeyInfo(
            name: 'fk_${row['id']}',
            column: row['from']! as String,
            referencedSchema: schema,
            referencedTable: row['table']! as String,
            referencedColumn: row['to']! as String,
            onUpdate: row['on_update'] as String?,
            onDelete: row['on_delete'] as String?,
          ),
        )
        .toList();
  }

  static Future<List<ViewInfo>> listViews(Database db, String schema) async {
    _assertSafeIdent(schema, 'schema');
    final q = quoteIdent(schema);
    final rs = db.select('''
SELECT name FROM $q.sqlite_master
WHERE type = 'view'
ORDER BY name
''');
    return rs
        .map(
          (Row row) => ViewInfo(schema: schema, name: row['name']! as String),
        )
        .toList();
  }

  static Future<List<RoutineInfo>> listRoutines(
    Database db,
    String schema,
  ) async {
    return Future<List<RoutineInfo>>.value(<RoutineInfo>[]);
  }

  static Future<String> generateDDL(Database db, DatabaseObject object) {
    return switch (object) {
      DatabaseObjectSchema(:final name) => Future<String>.value(
          '-- Schema ${quoteIdent(name)}: attach databases managed separately.',
        ),
      DatabaseObjectTable(:final schema, :final name) =>
        _ddlFromMaster(db, schema, name, 'table'),
      DatabaseObjectView(:final schema, :final name) =>
        _ddlFromMaster(db, schema, name, 'view'),
      DatabaseObjectIndex(:final schema, :final table, :final name) =>
        _ddlFromMaster(db, schema, name, 'index', forTable: table),
      DatabaseObjectColumn() => Future<String>.value(
          '-- Column DDL not generated.',
        ),
      DatabaseObjectForeignKey() => Future<String>.value(
          '-- Foreign key DDL not generated.',
        ),
      DatabaseObjectSequence() => Future<String>.value(
          '-- SQLite uses AUTOINCREMENT instead of sequences.',
        ),
      DatabaseObjectTrigger(:final schema, :final table, :final name) =>
        _ddlFromMaster(db, schema, name, 'trigger', forTable: table),
      DatabaseObjectProcedure() => Future<String>.value(
          '-- SQLite does not support stored procedures.',
        ),
      DatabaseObjectFunction() => Future<String>.value(
          '-- SQLite does not support stored functions.',
        ),
    };
  }

  static Future<String> _ddlFromMaster(
    Database db,
    String schema,
    String name,
    String type, {
    String? forTable,
  }) async {
    _assertSafeIdent(schema, 'schema');
    _assertSafeIdent(name, 'name');
    final q = quoteIdent(schema);
    final ResultSet rs;
    if (forTable != null) {
      _assertSafeIdent(forTable, 'forTable');
      rs = db.select(
        '''
SELECT sql FROM $q.sqlite_master
WHERE type = ? AND name = ? AND tbl_name = ?
''',
        <Object?>[type, name, forTable],
      );
    } else {
      rs = db.select(
        '''
SELECT sql FROM $q.sqlite_master
WHERE type = ? AND name = ?
''',
        <Object?>[type, name],
      );
    }
    if (rs.isEmpty) {
      return '-- Object $type ${quoteIdent(name)} not found.';
    }
    final sql = rs.first['sql'] as String?;
    if (sql == null || sql.isEmpty) {
      return '-- No SQL text for ${quoteIdent(name)} (e.g. implicit primary key).';
    }
    return sql;
  }
}
