import 'package:mydb/models/app_settings.dart';
import 'package:mydb/services/app_settings_repository.dart';
import 'package:mydb/state/local_storage_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_controller.g.dart';

/// Loaded from [AppSettingsRepository]; persists on each update.
@Riverpod(keepAlive: true)
class AppSettingsController extends _$AppSettingsController {
  @override
  Future<AppSettings> build() async {
    final AppSettingsRepository repo =
        await ref.watch(appSettingsRepositoryProvider.future);
    return repo.load();
  }

  Future<void> replace(AppSettings next) async {
    final AppSettingsRepository repo =
        await ref.read(appSettingsRepositoryProvider.future);
    state = AsyncData<AppSettings>(next);
    await repo.save(next);
  }

  Future<void> setDarkMode(bool darkMode) async {
    final AppSettings base = state.asData?.value ?? await future;
    await replace(base.copyWith(darkMode: darkMode));
  }

  Future<void> setEditorFontSize(double size) async {
    final AppSettings base = state.asData?.value ?? await future;
    await replace(base.copyWith(editorFontSize: size));
  }

  Future<void> patch(AppSettings Function(AppSettings s) fn) async {
    final AppSettings base = state.asData?.value ?? await future;
    await replace(fn(base));
  }
}
