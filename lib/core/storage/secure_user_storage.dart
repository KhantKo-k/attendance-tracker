import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// Persists the authenticated user payload in secure storage.
@injectable
class SecureUserStorage {
  SecureUserStorage({required FlutterSecureStorage secureStorage})
    : _secureStorage = secureStorage;

  static const _userSessionKey = 'authenticated_user_session';

  final FlutterSecureStorage _secureStorage;

  Future<String?> read() => _secureStorage.read(key: _userSessionKey);

  Future<void> write(String value) =>
      _secureStorage.write(key: _userSessionKey, value: value);

  Future<void> delete() => _secureStorage.delete(key: _userSessionKey);
}
