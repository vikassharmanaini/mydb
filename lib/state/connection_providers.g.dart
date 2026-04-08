// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$savedConnectionProfilesHash() =>
    r'f7cbbc93b43a478c1a160b328afc51899a19c341';

/// Saved connection profiles (passwords are never stored here).
///
/// Copied from [SavedConnectionProfiles].
@ProviderFor(SavedConnectionProfiles)
final savedConnectionProfilesProvider =
    NotifierProvider<SavedConnectionProfiles, List<ConnectionProfile>>.internal(
  SavedConnectionProfiles.new,
  name: r'savedConnectionProfilesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$savedConnectionProfilesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SavedConnectionProfiles = Notifier<List<ConnectionProfile>>;
String _$liveConnectionsHash() => r'e57e32947230c20cc14d7b01a18752a453bf14e0';

/// Open [DatabaseDriver] instances keyed by profile id.
///
/// Copied from [LiveConnections].
@ProviderFor(LiveConnections)
final liveConnectionsProvider =
    NotifierProvider<LiveConnections, Set<String>>.internal(
  LiveConnections.new,
  name: r'liveConnectionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$liveConnectionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LiveConnections = Notifier<Set<String>>;
String _$selectedConnectionIdHash() =>
    r'95501f70e7cd30a798865106d0a34f8de846eaf9';

/// Currently highlighted connection in the shell (for future editor/query UI).
///
/// Copied from [SelectedConnectionId].
@ProviderFor(SelectedConnectionId)
final selectedConnectionIdProvider =
    NotifierProvider<SelectedConnectionId, String?>.internal(
  SelectedConnectionId.new,
  name: r'selectedConnectionIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedConnectionIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedConnectionId = Notifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
