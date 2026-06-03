import 'package:injectable/injectable.dart';

import 'cache_keys.dart';
import 'secure_storage.dart';

@lazySingleton
class TokenStorage {
  const TokenStorage(this._secureStorage);

  final SecureStorage _secureStorage;

  Future<void> saveAccessToken(String token) {
    return _secureStorage.write(CacheKeys.accessToken, token);
  }

  Future<String?> getAccessToken() {
    return _secureStorage.read(CacheKeys.accessToken);
  }

  Future<void> saveRefreshToken(String token) {
    return _secureStorage.write(CacheKeys.refreshToken, token);
  }

  Future<String?> getRefreshToken() {
    return _secureStorage.read(CacheKeys.refreshToken);
  }

  Future<void> clearTokens() async {
    await _secureStorage.delete(CacheKeys.accessToken);
    await _secureStorage.delete(CacheKeys.refreshToken);
  }
}
