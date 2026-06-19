import 'package:injectable/injectable.dart';

import '../../../../../core/storage/token_storage.dart';
import '../../models/auth_session_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheSession(AuthSessionModel session);
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this._tokenStorage);

  final TokenStorage _tokenStorage;

  @override
  Future<void> cacheSession(AuthSessionModel session) async {
    await _tokenStorage.saveAccessToken(session.accessToken);

    final refreshToken = session.refreshToken;
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _tokenStorage.saveRefreshToken(refreshToken);
    }
  }
}
