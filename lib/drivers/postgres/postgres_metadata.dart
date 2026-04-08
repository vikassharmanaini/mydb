import 'package:mydb/models/database_object.dart';
import 'package:mydb/models/schema_metadata.dart';
import 'package:postgres/postgres.dart' as pg;

/// Catalog queries for PostgreSQL (information_schema + pg_catalog).
final class PostgresMetadata {
  PostgresMetadata._();

  static String quoteIdent(String name) {
    return '"${name.replaceAll('"', '""')}"';
  }

  static Future<List<SchemaInfo>> listSchemas(pg.Session s) async {
    final r = await s.execute('''
SELECT schema_name
FROM information_schema.schemata
WHERE schema_name NOT IN ('pg_catalog', 'information_schema')
  AND schema_name NOT LIKE 'pg_toast%%'
ORDER BY schema_name
''');
    return r
        .map(
          (pg.ResultRow row) => SchemaInfo(name: row[0]! as String),
        )
        .toList();
  }

  static Future<List<TableInfo>> listTables(pg.Session s, String schema) async {
    final r = await s.execute(
      pg.Sql.named(
        '''
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = @schema AND table_type = 'BASE TABLE'
ORDER BY table_name
''',
      ),
      parameters: <String, Object?>{'schema': schema},
    );
    return r
        .map(
          (pg.ResultRow row) => TableInfo(
            schema: row[0]! as String,
            name: row[1]! as String,
          ),
        )
        .toList();
  }

  static Future<List<ColumnInfo>> listColumns(
    pg.Session s,
    String schema,
    String table,
  ) async {
    final r = await s.execute(
      pg.Sql.named(
        '''
SELECT column_name, data_type, ordinal_position, is_nullable,
       column_default, COALESCE(
         (SELECT true FROM information_schema.table_constraints tc
          JOIN information_schema.key_column_usage kcu
            ON tc.constraint_name = kcu.constraint_name
           AND tc.table_schema = kcu.table_schema
          WHERE tc.constraint_type = 'PRIMARY KEY'
            AND tc.table_schema = c.table_schema
            AND tc.table_name = c.table_name
            AND kcu.column_name = c.column_name
          LIMIT 1), false) AS is_pk
FROM information_schema.columns c
WHERE table_schema = @schema AND table_name = @table
ORDER BY ordinal_position
''',
      ),
      parameters: <String, Object?>{'schema': schema, 'table': table},
    );
    return r
        .map(
          (pg.ResultRow row) => ColumnInfo(
            name: row[0]! as String,
            dataType: row[1]! as String,
            ordinalPosition: (row[2] as num).toInt(),
            nullable: (row[3] as String).toUpperCase() == 'YES',
            defaultValue: row[4] as String?,
            isPrimaryKey: row[5]! as bool,
          ),
        )
        .toList();
  }

  static Future<List<IndexInfo>> listIndexes(
    pg.Session s,
    String schema,
    String table,
  ) async {
    final r = await s.execute(
      pg.Sql.named(
        '''
SELECT indexname, indexdef
FROM pg_indexes
WHERE schemaname = @schema AND tablename = @table
ORDER BY indexname
''',
      ),
      parameters: <String, Object?>{'schema': schema, 'table': table},
    );
    return r
        .map(
          (pg.ResultRow row) {
            final def = row[1]! as String;
            final upper = def.toUpperCase();
            final isPk = upper.contains('PRIMARY KEY');
            if (isPk) {
              return null;
            }
            return IndexInfo(
              name: row[0]! as String,
              unique: upper.startsWith('CREATE UNIQUE'),
              columnNames: _parseIndexColumnsFromDef(def),
            );
          },
        )
        .whereType<IndexInfo>()
        .toList();
  }

  /// Best-effort parse of column list from [pg_indexes.indexdef].
  static List<String> _parseIndexColumnsFromDef(String def) {
    final m = RegExp(r'\(([^)]+)\)\s*$').firstMatch(def);
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
    pg.Session s,
    String schema,
    String table,
  ) async {
    final r = await s.execute(
      pg.Sql.named(
        '''
SELECT tc.constraint_name,
       kcu.column_name,
       ccu.table_schema,
       ccu.table_name,
       ccu.column_name,
       rc.update_rule,
       rc.delete_rule
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
  ON tc.constraint_name = kcu.constraint_name
 AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage ccu
  ON ccu.constraint_name = tc.constraint_name
 AND ccu.table_schema = tc.table_schema
JOIN information_schema.referential_constraints rc
  ON rc.constraint_name = tc.constraint_name
 AND rc.constraint_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = @schema AND tc.table_name = @table
ORDER BY tc.constraint_name, kcu.ordinal_position
''',
      ),
      parameters: <String, Object?>{'schema': schema, 'table': table},
    );
    return r
        .map(
          (pg.ResultRow row) => ForeignKeyInfo(
            name: row[0]! as String,
            column: row[1]! as String,
            referencedSchema: row[2]! as String,
            referencedTable: row[3]! as String,
            referencedColumn: row[4]! as String,
            onUpdate: row[5] as String?,
            onDelete: row[6] as String?,
          ),
        )
        .toList();
  }

  static Future<List<ViewInfo>> listViews(pg.Session s, String schema) async {
    final r = await s.execute(
      pg.Sql.named(
        '''
SELECT table_schema, table_name
FROM information_schema.views
WHERE table_schema = @schema
ORDER BY table_name
''',
      ),
      parameters: <String, Object?>{'schema': schema},
    );
    return r
        .map(
          (pg.ResultRow row) => ViewInfo(
            schema: row[0]! as String,
            name: row[1]! as String,
          ),
        )
        .toList();
  }

  static Future<List<RoutineInfo>> listRoutines(
    pg.Session s,
    String schema,
  ) async {
    final r = await s.execute(
      pg.Sql.named(
        '''
SELECT routine_schema, routine_name, routine_type, external_language, data_type
FROM information_schema.routines
WHERE routine_schema = @schema
ORDER BY routine_name
''',
      ),
      parameters: <String, Object?>{'schema': schema},
    );
    return r
        .map(
          (pg.ResultRow row) {
            final dataType = row[4] as String?;
            return RoutineInfo(
              schema: row[0]! as String,
              name: row[1]! as String,
              kind: (row[2] as String).toLowerCase(),
              language: row[3] as String?,
              returnType:
                  dataType == null || dataType == 'void' ? null : dataType,
            );
          },
        )
        .toList();
  }

  static Future<String> generateDDL(pg.Session s, DatabaseObject object) {
    return switch (object) {
      DatabaseObjectSchema(:final name) => Future<String>.value(
          '-- Schema ${quoteIdent(name)}: DDL not generated.',
        ),
      DatabaseObjectTable(:final schema, :final name) =>
        _tableDDL(s, schema, name),
      DatabaseObjectView(:final schema, :final name) =>
        _viewDDL(s, schema, name),
      DatabaseObjectColumn() => Future<String>.value(
          '-- Column DDL not generated.',
        ),
      DatabaseObjectIndex(:final schema, :final table, :final name) =>
        _indexDDL(s, schema, table, name),
      DatabaseObjectForeignKey() => Future<String>.value(
          '-- Foreign key DDL not generated.',
        ),
      DatabaseObjectSequence(:final schema, :final name) => Future<String>.value(
          '-- Sequence ${quoteIdent(schema)}.${quoteIdent(name)}: not generated.',
        ),
      DatabaseObjectTrigger() => Future<String>.value(
          '-- Trigger DDL not generated.',
        ),
      DatabaseObjectProcedure() => Future<String>.value(
          '-- Procedure DDL not generated.',
        ),
      DatabaseObjectFunction() => Future<String>.value(
          '-- Function DDL not generated.',
        ),
    };
  }

  static Future<String> _tableDDL(
    pg.Session s,
    String schema,
    String name,
  ) async {
    final cols = await listColumns(s, schema, name);
    if (cols.isEmpty) {
      return '-- Table ${quoteIdent(schema)}.${quoteIdent(name)} not found or no columns.';
    }
    final sb = StringBuffer()
      ..writeln(
        'CREATE TABLE ${quoteIdent(schema)}.${quoteIdent(name)} (',
      );
    for (var i = 0; i < cols.length; i++) {
      final c = cols[i];
      final line =
          '  ${quoteIdent(c.name)} ${c.dataType}${c.nullable ? '' : ' NOT NULL'}';
      final suffix = i < cols.length - 1 ? ',' : '';
      sb.writeln('$line$suffix');
    }
    sb.writeln(');');
    return sb.toString();
  }

  static Future<String> _viewDDL(
    pg.Session s,
    String schema,
    String name,
  ) async {
    final r = await s.execute(
      pg.Sql.named(
        '''
SELECT definition FROM pg_views
WHERE schemaname = @schema AND viewname = @name
''',
      ),
      parameters: <String, Object?>{'schema': schema, 'name': name},
    );
    if (r.isEmpty) {
      return '-- View ${quoteIdent(schema)}.${quoteIdent(name)} not found.';
    }
    final def = r.first[0]! as String;
    return 'CREATE OR REPLACE VIEW ${quoteIdent(schema)}.${quoteIdent(name)} AS\n$def';
  }

  static Future<String> _indexDDL(
    pg.Session s,
    String schema,
    String table,
    String name,
  ) async {
    final r = await s.execute(
      pg.Sql.named(
        '''
SELECT indexdef FROM pg_indexes
WHERE schemaname = @schema AND tablename = @table AND indexname = @name
''',
      ),
      parameters: <String, Object?>{
        'schema': schema,
        'table': table,
        'name': name,
      },
    );
    if (r.isEmpty) {
      return '-- Index ${quoteIdent(name)} not found.';
    }
    return r.first[0]! as String;
  }
}
