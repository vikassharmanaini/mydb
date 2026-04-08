import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mydb/models/connection_profile.dart';

/// Persists [ConnectionProfile] JSON in an AES-encrypted Hive box (no passwords).
final class ConnectionProfileRepository {
  ConnectionProfileRepository._(this._box);

  static const String _boxName = 'connection_profiles';
  static const String _hiveKeyStorageKey = 'dbstudio.hive.connection_profiles_key';

  static bool _hiveInited = false;

  final Box<String> _box;

  static Future<void> _ensureHiveFlutter() async {
    if (_hiveInited) {
      return;
    }
    await Hive.initFlutter();
    _hiveInited = true;
  }

  /// Opens the encrypted box (generates and stores a 32-byte AES key on first run).
  static Future<ConnectionProfileRepository> open() async {
    await _ensureHiveFlutter();
    const FlutterSecureStorage secure = FlutterSecureStorage();
    String? keyB64 = await secure.read(key: _hiveKeyStorageKey);
    if (keyB64 == null || keyB64.isEmpty) {
      final List<int> bytes =
          List<int>.generate(32, (_) => Random.secure().nextInt(256));
      keyB64 = base64UrlEncode(bytes);
      await secure.write(key: _hiveKeyStorageKey, value: keyB64);
    }
    final List<int> keyBytes = base64Url.decode(keyB64);
    if (keyBytes.length != 32) {
      throw StateError('Invalid Hive encryption key length');
    }
    final Box<String> box = await Hive.openBox<String>(
      _boxName,
      encryptionCipher: HiveAesCipher(keyBytes),
    );
    return ConnectionProfileRepository._(box);
  }

  List<ConnectionProfile> loadAll() {
    final List<ConnectionProfile> out = <ConnectionProfile>[];
    for (final String raw in _box.values) {
      try {
        final Object? decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic>) {
          out.add(ConnectionProfile.fromJson(decoded));
        }
      } catch (_) {
        /* skip corrupt entry */
      }
    }
    out.sort(
      (ConnectionProfile a, ConnectionProfile b) =>
          a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );
    return out;
  }

  Future<void> save(ConnectionProfile profile) async {
    final String id = profile.id;
    final String json = jsonEncode(profile.toJson());
    await _box.put(id, json);
  }

  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  Future<void> dispose() async {
    await _box.close();
  }
}
