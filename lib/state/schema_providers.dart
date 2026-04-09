import 'package:mydb/models/schema_metadata.dart';
import 'package:mydb/services/schema_meta_cache.dart';
import 'package:mydb/services/schema_service.dart';
import 'package:mydb/state/connection_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schema_providers.g.dart';

@Riverpod(keepAlive: true)
SchemaMetaCache schemaMetaCache(SchemaMetaCacheRef ref) {
  return SchemaMetaCache();
}

@Riverpod(keepAlive: true)
SchemaService schemaService(SchemaServiceRef ref) {
  final SchemaMetaCache cache = ref.watch(schemaMetaCacheProvider);
  return SchemaService(
    cache: cache,
    driverLookup: (String id) =>
        ref.read(liveConnectionsProvider.notifier).driver(id),
  );
}

/// Schemas for the object tree (cached inside [SchemaService]).
@Riverpod(keepAlive: true)
Future<List<SchemaInfo>> explorerSchemas(
  ExplorerSchemasRef ref,
  String connectionId,
) async {
  final SchemaService svc = ref.watch(schemaServiceProvider);
  return svc.listSchemas(connectionId);
}

/// Tables under a schema; cache key is `connectionId|schema`.
@Riverpod(keepAlive: true)
Future<List<TableInfo>> explorerTables(
  ExplorerTablesRef ref,
  String cacheKey,
) async {
  final int sep = cacheKey.indexOf('|');
  if (sep <= 0 || sep >= cacheKey.length - 1) {
    return <TableInfo>[];
  }
  final String connectionId = cacheKey.substring(0, sep);
  final String schema = cacheKey.substring(sep + 1);
  final SchemaService svc = ref.watch(schemaServiceProvider);
  return svc.listTables(connectionId, schema);
}

/// Keywords for autocomplete: schema + table names (best-effort).
@Riverpod(keepAlive: true)
Future<List<String>> schemaKeywords(
  SchemaKeywordsRef ref,
  String connectionId,
) async {
  final List<SchemaInfo> schemas =
      await ref.watch(explorerSchemasProvider(connectionId).future);
  final SchemaService svc = ref.watch(schemaServiceProvider);
  final List<String> out = <String>[];
  for (final SchemaInfo s in schemas) {
    out.add(s.name);
    final List<TableInfo> tables =
        await svc.listTables(connectionId, s.name);
    for (final TableInfo t in tables) {
      out.add(t.name);
    }
  }
  return out;
}
