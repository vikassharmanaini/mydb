import 'package:mydb/models/session_state.dart';
import 'package:mydb/services/session_restore_service.dart';
import 'package:mydb/state/local_storage_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_snapshot_controller.g.dart';

/// Loads and persists [SessionState] for crash recovery / editor restore.
@Riverpod(keepAlive: true)
class SessionSnapshotController extends _$SessionSnapshotController {
  @override
  Future<SessionState> build() async {
    final SessionRestoreService svc =
        await ref.watch(sessionRestoreServiceProvider.future);
    return svc.load();
  }

  Future<void> persist(SessionState next) async {
    final SessionRestoreService svc =
        await ref.read(sessionRestoreServiceProvider.future);
    await svc.save(next);
    state = AsyncData<SessionState>(next);
  }

  /// Updates scratch buffer for the query workspace (per connection).
  Future<void> updateScratch({
    required String sql,
    required String? connectionId,
  }) async {
    final SessionState current = state.asData?.value ?? await future;
    await persist(
      SessionState(
        tabs: current.tabs,
        activeTabId: current.activeTabId,
        scratchSql: sql,
        scratchConnectionId: connectionId,
      ),
    );
  }

  /// Replaces editor tabs for [connectionId] and updates scratch for that connection.
  Future<void> mergeConnectionEditorTabs({
    required String connectionId,
    required List<EditorTabSnapshot> tabs,
    required String? activeTabId,
    required String scratchSql,
  }) async {
    final SessionState current = state.asData?.value ?? await future;
    final List<EditorTabSnapshot> others = current.tabs
        .where((EditorTabSnapshot t) => t.connectionId != connectionId)
        .toList();
    await persist(
      SessionState(
        tabs: <EditorTabSnapshot>[...others, ...tabs],
        activeTabId: activeTabId,
        scratchSql: scratchSql,
        scratchConnectionId: connectionId,
      ),
    );
  }
}
