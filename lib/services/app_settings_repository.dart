import 'dart:convert';
import 'dart:io';

import 'package:mydb/models/app_settings.dart';
import 'package:mydb/services/app_data_paths.dart';
import 'package:path/path.dart' as p;

/// Persists [AppSettings] as JSON under the app support `dbstudio/` folder.
final class AppSettingsRepository {
  AppSettingsRepository._(this._file);

  final File _file;

  static Future<AppSettingsRepository> open() async {
    final Directory dir = await dbStudioSupportDirectory();
    final File file = File(p.join(dir.path, 'settings.json'));
    return AppSettingsRepository._(file);
  }

  Future<AppSettings> load() async {
    if (!await _file.exists()) {
      return const AppSettings();
    }
    try {
      final String raw = await _file.readAsString();
      final Object? decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return AppSettings.fromJson(decoded);
      }
    } catch (_) {
      /* corrupt or empty */
    }
    return const AppSettings();
  }

  Future<void> save(AppSettings settings) async {
    final String text =
        const JsonEncoder.withIndent('  ').convert(settings.toJson());
    await writeStringAtomic(_file, text);
  }
}
