import 'package:mydb/drivers/driver_interface.dart';
import 'package:mydb/drivers/driver_registry.dart';
import 'package:mydb/models/connection_profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connection_providers.g.dart';

/// Saved connection profiles (passwords are never stored here).
@Riverpod(keepAlive: true)
class SavedConnectionProfiles extends _$SavedConnectionProfiles {
  @override
  List<ConnectionProfile> build() => <ConnectionProfile>[];

  void upsert(ConnectionProfile profile) {
    final ConnectionProfile withoutSecret = profile.copyWith(password: null);
    state = <ConnectionProfile>[
      for (final ConnectionProfile p in state)
        if (p.id != withoutSecret.id) p,
      withoutSecret,
    ];
  }

  void remove(String id) {
    state = state.where((ConnectionProfile p) => p.id != id).toList();
  }

  ConnectionProfile? byId(String id) {
    for (final ConnectionProfile p in state) {
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
