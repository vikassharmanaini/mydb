// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_snapshot_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionSnapshotControllerHash() =>
    r'a227f1bf790c590939f52d55b421133e5c9b22c5';

/// Loads and persists [SessionState] for crash recovery / editor restore.
///
/// Copied from [SessionSnapshotController].
@ProviderFor(SessionSnapshotController)
final sessionSnapshotControllerProvider =
    AsyncNotifierProvider<SessionSnapshotController, SessionState>.internal(
  SessionSnapshotController.new,
  name: r'sessionSnapshotControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionSnapshotControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SessionSnapshotController = AsyncNotifier<SessionState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
