// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$credentialServiceHash() => r'a9ee7b798833653c676da3d7dacefa02b7cad153';

/// See also [credentialService].
@ProviderFor(credentialService)
final credentialServiceProvider = FutureProvider<CredentialService>.internal(
  credentialService,
  name: r'credentialServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$credentialServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CredentialServiceRef = FutureProviderRef<CredentialService>;
String _$connectionProfileRepositoryHash() =>
    r'92c1e8ce36f5949001c4f331ab9927654c4b85b7';

/// See also [connectionProfileRepository].
@ProviderFor(connectionProfileRepository)
final connectionProfileRepositoryProvider =
    FutureProvider<ConnectionProfileRepository>.internal(
  connectionProfileRepository,
  name: r'connectionProfileRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$connectionProfileRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectionProfileRepositoryRef
    = FutureProviderRef<ConnectionProfileRepository>;
String _$savedConnectionProfilesHash() =>
    r'25b517901cbaeb7961e8c654bf8f7253641a60a3';

/// Saved connection profiles (passwords are never stored in Hive).
///
/// Copied from [SavedConnectionProfiles].
@ProviderFor(SavedConnectionProfiles)
final savedConnectionProfilesProvider = AsyncNotifierProvider<
    SavedConnectionProfiles, List<ConnectionProfile>>.internal(
  SavedConnectionProfiles.new,
  name: r'savedConnectionProfilesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$savedConnectionProfilesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SavedConnectionProfiles = AsyncNotifier<List<ConnectionProfile>>;
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
