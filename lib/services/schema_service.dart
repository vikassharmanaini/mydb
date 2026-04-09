import 'package:mydb/drivers/driver_interface.dart';
import 'package:mydb/models/schema_metadata.dart';
import 'package:mydb/services/schema_meta_cache.dart';

/// Fetches schema metadata through [DatabaseDriver] with [SchemaMetaCache].
final class SchemaService {
  SchemaService({
    required SchemaMetaCache cache,
    required DatabaseDriver? Function(String connectionId) driverLookup,
  })  : _cache = cache,
        _driverLookup = driverLookup;

  final SchemaMetaCache _cache;
  final DatabaseDriver? Function(String connectionId) _driverLookup;

  DatabaseDriver _require(String connectionId) {
    final DatabaseDriver? d = _driverLookup(connectionId);
    if (d == null) {
      throw StateError('No driver for connection $connectionId');
    }
    return d;
  }

  Future<List<SchemaInfo>> listSchemas(String connectionId) async {
    final List<SchemaInfo>? hit = _cache.getSchemas(connectionId);
    if (hit != null) {
      return hit;
    }
    final List<SchemaInfo> list = await _require(connectionId).listSchemas();
    _cache.putSchemas(connectionId, list);
    return list;
  }

  Future<List<TableInfo>> listTables(String connectionId, String schema) async {
    final List<TableInfo>? hit = _cache.getTables(connectionId, schema);
    if (hit != null) {
      return hit;
    }
    final List<TableInfo> list =
        await _require(connectionId).listTables(schema);
    _cache.putTables(connectionId, schema, list);
    return list;
  }

  Future<List<ColumnInfo>> listColumns(
    String connectionId,
    String schema,
    String table,
  ) async {
    final List<ColumnInfo>? hit =
        _cache.getColumns(connectionId, schema, table);
    if (hit != null) {
      return hit;
    }
    final List<ColumnInfo> list =
        await _require(connectionId).listColumns(schema, table);
    _cache.putColumns(connectionId, schema, table, list);
    return list;
  }

  void invalidate(String connectionId) => _cache.clear(connectionId);
}
