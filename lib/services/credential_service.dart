import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// OS keychain / encrypted prefs for per-connection secrets (passwords only).
final class CredentialService {
  CredentialService();

  static const String _keyPrefix = 'dbstudio.cred.';

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  String _passwordKey(String connectionId) => '$_keyPrefix$connectionId.password';

  Future<void> storePassword(String connectionId, String password) {
    return _storage.write(key: _passwordKey(connectionId), value: password);
  }

  Future<String?> readPassword(String connectionId) {
    return _storage.read(key: _passwordKey(connectionId));
  }

  Future<void> deletePassword(String connectionId) {
    return _storage.delete(key: _passwordKey(connectionId));
  }
}
