import 'package:mydb/drivers/driver_interface.dart';
import 'package:mydb/drivers/driver_registry.dart';
import 'package:mydb/models/connection_profile.dart';
import 'package:mydb/services/connection_profile_repository.dart';
import 'package:mydb/services/credential_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connection_providers.g.dart';

@Riverpod(keepAlive: true)
Future<CredentialService> credentialService(CredentialServiceRef ref) async {
  return CredentialService();
}

@Riverpod(keepAlive: true)
Future<ConnectionProfileRepository> connectionProfileRepository(
  ConnectionProfileRepositoryRef ref,
) async {
  return ConnectionProfileRepository.open();
}

/// Saved connection profiles (passwords are never stored in Hive).
@Riverpod(keepAlive: true)
class SavedConnectionProfiles extends _$SavedConnectionProfiles {
  @override
  Future<List<ConnectionProfile>> build() async {
    final ConnectionProfileRepository repo =
        await ref.watch(connectionProfileRepositoryProvider.future);
    return repo.loadAll();
  }

  Future<void> upsert(ConnectionProfile profile) async {
    final ConnectionProfileRepository repo =
        await ref.read(connectionProfileRepositoryProvider.future);
    final ConnectionProfile clean = profile.copyWith(password: null);
    final List<ConnectionProfile> current =
        state.asData?.value ?? await future;
    final List<ConnectionProfile> next = <ConnectionProfile>[
      for (final ConnectionProfile p in current)
        if (p.id != clean.id) p,
      clean,
    ];
    state = AsyncData<List<ConnectionProfile>>(next);
    await repo.save(clean);
  }

  Future<void> remove(String id) async {
    final ConnectionProfileRepository repo =
        await ref.read(connectionProfileRepositoryProvider.future);
    final CredentialService cred =
        await ref.read(credentialServiceProvider.future);
    final List<ConnectionProfile> current =
        state.asData?.value ?? await future;
    state = AsyncData<List<ConnectionProfile>>(
      current.where((ConnectionProfile p) => p.id != id).toList(),
    );
    await repo.delete(id);
    await cred.deletePassword(id);
  }

  ConnectionProfile? byId(String id) {
    final List<ConnectionProfile>? list = state.asData?.value;
    if (list == null) {
      return null;
    }
    for (final ConnectionProfile p in list) {
      if (p.id == id) {
        return p;
      }
    }
    return null;
  }
}

/// Open [DatabaseDriver] instances keyed by profile id.
@Riverpod(keepAlive: true)
class LiveConnections extends _$LiveConnections {
  final Map<String, DatabaseDriver> _drivers = <String, DatabaseDriver>{};

  @override
  Set<String> build() => <String>{};

  void _publish() => state = Set<String>.from(_drivers.keys);

  /// Opens a driver from [profile] (include [ConnectionProfile.password] when required).
  Future<void> connect(ConnectionProfile profile) async {
    if (_drivers.containsKey(profile.id)) {
      return;
    }
    final DatabaseDriver driver = DriverRegistry.create(profile);
    await driver.connect(profile);
    _drivers[profile.id] = driver;
    _publish();
  }

  Future<void> disconnect(String id) async {
    final DatabaseDriver? d = _drivers.remove(id);
    if (d != null) {
      await d.disconnect();
    }
    _publish();
  }

  DatabaseDriver? driver(String id) => _drivers[id];

  bool isConnected(String id) => _drivers.containsKey(id);
}

/// Currently highlighted connection in the shell (for future editor/query UI).
@Riverpod(keepAlive: true)
class SelectedConnectionId extends _$SelectedConnectionId {
  @override
  String? build() => null;

  void select(String? id) => state = id;
}
