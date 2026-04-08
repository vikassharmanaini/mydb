import 'package:mydb/models/database_object.dart';
import 'package:mydb/models/schema_metadata.dart';
import 'package:mysql_client/mysql_client.dart';

/// `information_schema` queries for MySQL / MariaDB.
final class MySQLMetadata {
  MySQLMetadata._();

  static String quoteIdent(String name) {
    return '`${name.replaceAll('`', '``')}`';
  }

  static Future<List<SchemaInfo>> listSchemas(MySQLConnection c) async {
    final r = await c.execute('''
SELECT schema_name
FROM information_schema.schemata
WHERE schema_name NOT IN (
  'information_schema', 'performance_schema', 'mysql', 'sys'
)
ORDER BY schema_name
''');
    return r.rows
        .map((ResultSetRow row) => SchemaInfo(name: row.colAt(0)!))
        .toList();
  }

  static Future<List<TableInfo>> listTables(
    MySQLConnection c,
    String schema,
  ) async {
    final r = await c.execute(
      '''
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = :schema AND table_type = 'BASE TABLE'
ORDER BY table_name
''',
      <String, dynamic>{'schema': schema},
    );
    return r.rows
        .map(
          (ResultSetRow row) => TableInfo(
            schema: row.colAt(0)!,
            name: row.colAt(1)!,
          ),
        )
        .toList();
  }

  static Future<List<ColumnInfo>> listColumns(
    MySQLConnection c,
    String schema,
    String table,
  ) async {
    final r = await c.execute(
      '''
SELECT column_name, data_type, ordinal_position, is_nullable, column_default,
       (column_key = 'PRI') AS is_pk
FROM information_schema.columns
WHERE table_schema = :schema AND table_name = :table
ORDER BY ordinal_position
''',
      <String, dynamic>{'schema': schema, 'table': table},
    );
    return r.rows
        .map(
          (ResultSetRow row) => ColumnInfo(
            name: row.colAt(0)!,
            dataType: row.colAt(1)!,
            ordinalPosition: int.parse(row.colAt(2)!),
            nullable: row.colAt(3)!.toUpperCase() == 'YES',
            defaultValue: row.colAt(4),
            isPrimaryKey: row.colAt(5) == '1' || row.colAt(5) == 'true',
          ),
        )
        .toList();
  }

  static Future<List<IndexInfo>> listIndexes(
    MySQLConnection c,
    String schema,
    String table,
  ) async {
    final r = await c.execute(
      '''
SELECT index_name,
       (MAX(non_unique) = 0) AS is_unique,
       GROUP_CONCAT(column_name ORDER BY seq_in_index) AS cols
FROM information_schema.statistics
WHERE table_schema = :schema AND table_name = :table
  AND index_name != 'PRIMARY'
GROUP BY index_name
ORDER BY index_name
''',
      <String, dynamic>{'schema': schema, 'table': table},
    );
    return r.rows
        .map(
          (ResultSetRow row) {
            final raw = row.colAt(2);
            final cols = raw == null || raw.isEmpty
                ? <String>[]
                : raw.split(',').map((String s) => s.trim()).toList();
            return IndexInfo(
              name: row.colAt(0)!,
              unique: row.colAt(1) == '1' || row.colAt(1) == 'true',
              columnNames: cols,
            );
          },
        )
        .toList();
  }

  static Future<List<ForeignKeyInfo>> listForeignKeys(
    MySQLConnection c,
    String schema,
    String table,
  ) async {
    final r = await c.execute(
      '''
SELECT kcu.constraint_name,
       kcu.column_name,
       kcu.referenced_table_schema,
       kcu.referenced_table_name,
       kcu.referenced_column_name,
       rc.update_rule,
       rc.delete_rule
FROM information_schema.key_column_usage kcu
JOIN information_schema.referential_constraints rc
  ON rc.constraint_name = kcu.constraint_name
 AND rc.constraint_schema = kcu.table_schema
WHERE kcu.table_schema = :schema AND kcu.table_name = :table
  AND kcu.referenced_table_name IS NOT NULL
ORDER BY kcu.constraint_name, kcu.ordinal_position
''',
      <String, dynamic>{'schema': schema, 'table': table},
    );
    return r.rows
        .map(
          (ResultSetRow row) => ForeignKeyInfo(
            name: row.colAt(0)!,
            column: row.colAt(1)!,
            referencedSchema: row.colAt(2)!,
            referencedTable: row.colAt(3)!,
            referencedColumn: row.colAt(4)!,
            onUpdate: row.colAt(5),
            onDelete: row.colAt(6),
          ),
        )
        .toList();
  }

  static Future<List<ViewInfo>> listViews(
    MySQLConnection c,
    String schema,
  ) async {
    final r = await c.execute(
      '''
SELECT table_schema, table_name
FROM information_schema.views
WHERE table_schema = :schema
ORDER BY table_name
''',
      <String, dynamic>{'schema': schema},
    );
    return r.rows
        .map(
          (ResultSetRow row) => ViewInfo(
            schema: row.colAt(0)!,
            name: row.colAt(1)!,
          ),
        )
        .toList();
  }

  static Future<List<RoutineInfo>> listRoutines(
    MySQLConnection c,
    String schema,
  ) async {
    final r = await c.execute(
      '''
SELECT routine_schema, routine_name, routine_type,
       external_language, data_type
FROM information_schema.routines
WHERE routine_schema = :schema
ORDER BY routine_name
''',
      <String, dynamic>{'schema': schema},
    );
    return r.rows
        .map(
          (ResultSetRow row) {
            final dt = row.colAt(4);
            return RoutineInfo(
              schema: row.colAt(0)!,
              name: row.colAt(1)!,
              kind: row.colAt(2)!.toLowerCase(),
              language: row.colAt(3),
              returnType: dt == null || dt.isEmpty || dt == 'void' ? null : dt,
            );
          },
        )
        .toList();
  }

  static Future<String> generateDDL(MySQLConnection c, DatabaseObject object) {
    return switch (object) {
      DatabaseObjectSchema(:final name) => Future<String>.value(
          '-- Schema ${quoteIdent(name)}: use mysqldump for full DDL.',
        ),
      DatabaseObjectTable(:final schema, :final name) =>
        _showCreate(c, 'TABLE', schema, name),
      DatabaseObjectView(:final schema, :final name) =>
        _showCreate(c, 'VIEW', schema, name),
      DatabaseObjectIndex(:final schema, :final table, :final name) =>
        _indexDDL(c, schema, table, name),
      DatabaseObjectColumn() => Future<String>.value(
          '-- Column DDL not generated.',
        ),
      DatabaseObjectForeignKey() => Future<String>.value(
          '-- Foreign key DDL not generated.',
        ),
      DatabaseObjectSequence() => Future<String>.value(
          '-- Sequences are not used in MySQL.',
        ),
      DatabaseObjectTrigger() => Future<String>.value(
          '-- Trigger DDL not generated.',
        ),
      DatabaseObjectProcedure(:final schema, :final name) =>
        _showCreate(c, 'PROCEDURE', schema, name),
      DatabaseObjectFunction(:final schema, :final name) =>
        _showCreate(c, 'FUNCTION', schema, name),
    };
  }

  static Future<String> _showCreate(
    MySQLConnection c,
    String kind,
    String schema,
    String name,
  ) async {
    final qSchema = quoteIdent(schema);
    final qName = quoteIdent(name);
    final r = await c.execute('SHOW CREATE $kind $qSchema.$qName');
    if (r.numOfRows == 0) {
      return '-- $kind $qSchema.$qName not found.';
    }
    return _pickCreateDdl(r.rows.first);
  }

  static String _pickCreateDdl(ResultSetRow row) {
    for (final MapEntry<String, String?> e in row.assoc().entries) {
      if (e.key.toLowerCase().startsWith('create ')) {
        return e.value ?? '';
      }
    }
    return row.colAt(1) ?? row.colAt(0) ?? '-- (empty)';
  }

  static Future<String> _indexDDL(
    MySQLConnection c,
    String schema,
    String table,
    String name,
  ) async {
    final r = await c.execute(
      '''
SELECT index_name, non_unique, index_type, column_name, seq_in_index
FROM information_schema.statistics
WHERE table_schema = :schema AND table_name = :table AND index_name = :iname
ORDER BY seq_in_index
''',
      <String, dynamic>{
        'schema': schema,
        'table': table,
        'iname': name,
      },
    );
    if (r.numOfRows == 0) {
      return '-- Index ${quoteIdent(name)} not found.';
    }
    final cols = r.rows.map((ResultSetRow row) => row.colAt(3)!).toList();
    final first = r.rows.first;
    final unique = first.colAt(1) == '0';
    final type = first.colAt(2) ?? 'BTREE';
    final u = unique ? 'UNIQUE ' : '';
    return 'CREATE ${u}INDEX ${quoteIdent(name)} ON ${quoteIdent(schema)}.${quoteIdent(table)} (${cols.map(quoteIdent).join(', ')}) USING $type;';
  }
}
