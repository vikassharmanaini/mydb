import 'package:mydb/drivers/driver_interface.dart';
import 'package:mydb/local_db/app_database.dart';
import 'package:mydb/services/query_service.dart';
import 'package:mydb/state/connection_providers.dart';
import 'package:mydb/state/local_storage_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'query_providers.g.dart';

/// [QueryService] for an open connection, or `null` if [connectionId] is not live.
@Riverpod(keepAlive: true)
Future<QueryService?> queryServiceFor(
  QueryServiceForRef ref,
  String connectionId,
) async {
  final Set<String> live = ref.watch(liveConnectionsProvider);
  if (!live.contains(connectionId)) {
    return null;
  }
  final DatabaseDriver? driver =
      ref.read(liveConnectionsProvider.notifier).driver(connectionId);
  if (driver == null) {
    return null;
  }
  final AppDatabase db = await ref.watch(appDatabaseProvider.future);
  return QueryService(
    driver: driver,
    connectionId: connectionId,
    historyDao: db.historyDao,
  );
}
