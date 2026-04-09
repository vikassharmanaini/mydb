import 'dart:io';

import 'package:mydb/models/session_state.dart';
import 'package:mydb/services/app_data_paths.dart';
import 'package:path/path.dart' as p;

/// Saves and restores [SessionState] (open tabs / SQL) for crash recovery.
final class SessionRestoreService {
  SessionRestoreService._(this._file);

  final File _file;

  static Future<SessionRestoreService> open() async {
    final Directory dir = await dbStudioSupportDirectory();
    final File file = File(p.join(dir.path, 'session.json'));
    return SessionRestoreService._(file);
  }

  Future<SessionState> load() async {
    if (!await _file.exists()) {
      return const SessionState();
    }
    try {
      final String raw = await _file.readAsString();
      return SessionState.decode(raw);
    } catch (_) {
      return const SessionState();
    }
  }

  Future<void> save(SessionState state) async {
    await writeStringAtomic(_file, state.encode());
  }

  Future<void> clear() async {
    if (await _file.exists()) {
      await _file.delete();
    }
  }
}
