import 'package:mydb/models/schema_metadata.dart';

/// In-memory metadata cache per live connection id.
final class SchemaMetaCache {
  final Map<String, List<SchemaInfo>> _schemas = <String, List<SchemaInfo>>{};
  final Map<String, Map<String, List<TableInfo>>> _tables =
      <String, Map<String, List<TableInfo>>>{};
  final Map<String, Map<String, Map<String, List<ColumnInfo>>>> _columns =
      <String, Map<String, Map<String, List<ColumnInfo>>>>{};

  List<SchemaInfo>? getSchemas(String connectionId) => _schemas[connectionId];

  void putSchemas(String connectionId, List<SchemaInfo> v) {
    _schemas[connectionId] = v;
  }

  List<TableInfo>? getTables(String connectionId, String schema) {
    return _tables[connectionId]?[schema];
  }

  void putTables(String connectionId, String schema, List<TableInfo> v) {
    _tables.putIfAbsent(connectionId, () => <String, List<TableInfo>>{})[schema] =
        v;
  }

  List<ColumnInfo>? getColumns(String connectionId, String schema, String table) {
    return _columns[connectionId]?[schema]?[table];
  }

  void putColumns(
    String connectionId,
    String schema,
    String table,
    List<ColumnInfo> v,
  ) {
    _columns
        .putIfAbsent(
          connectionId,
          () => <String, Map<String, List<ColumnInfo>>>{},
        )
        .putIfAbsent(schema, () => <String, List<ColumnInfo>>{})[table] = v;
  }

  void clear(String connectionId) {
    _schemas.remove(connectionId);
    _tables.remove(connectionId);
    _columns.remove(connectionId);
  }

  void clearAll() {
    _schemas.clear();
    _tables.clear();
    _columns.clear();
  }
}
