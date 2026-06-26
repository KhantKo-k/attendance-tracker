import 'package:app_starter_kit_bloc/features/auth/domain/entities/auth_token_pair.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class SecureAuthTokenStorage implements TokenStorage<AuthTokenPair> {
  final FlutterSecureStorage _secureStorage;

  final String _accessTokenKey = 'accessToken';
  final String _refreshTokenKey = 'refreshToken';

  SecureAuthTokenStorage({required FlutterSecureStorage secureStorage})
    : _secureStorage = secureStorage;

  @override
  Future<AuthTokenPair?> read() async {
    final accessToken = await _secureStorage.read(key: _accessTokenKey);
    final refreshToken = await _secureStorage.read(key: _refreshTokenKey);
    if (accessToken == null || refreshToken == null) {
      return null;
    }
    return AuthTokenPair(accessToken: accessToken, refreshToken: refreshToken);
  }

  @override
  Future<void> write(AuthTokenPair authTokenPair) async {
    await _secureStorage.write(
      key: _accessTokenKey,
      value: authTokenPair.accessToken,
    );
    await _secureStorage.write(
      key: _refreshTokenKey,
      value: authTokenPair.refreshToken,
    );
  }

  @override
  Future<void> delete() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }
}
