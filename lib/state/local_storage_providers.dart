import 'package:mydb/local_db/app_database.dart';
import 'package:mydb/services/app_settings_repository.dart';
import 'package:mydb/services/session_restore_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_storage_providers.g.dart';

@Riverpod(keepAlive: true)
Future<AppDatabase> appDatabase(AppDatabaseRef ref) async {
  final AppDatabase db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}

@Riverpod(keepAlive: true)
Future<AppSettingsRepository> appSettingsRepository(
  AppSettingsRepositoryRef ref,
) async {
  return AppSettingsRepository.open();
}

@Riverpod(keepAlive: true)
Future<SessionRestoreService> sessionRestoreService(
  SessionRestoreServiceRef ref,
) async {
  return SessionRestoreService.open();
}
