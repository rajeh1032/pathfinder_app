import '../../domain/entities/auth_session.dart';

class AuthSessionModel {
  const AuthSessionModel({
    required this.accessToken,
    this.refreshToken,
  });

  final String accessToken;
  final String? refreshToken;

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final source = data is Map<String, dynamic> ? data : json;

    final accessToken = _readString(source, [
      'accessToken',
      'access_token',
      'token',
      'jwt',
    ]);

    if (accessToken == null || accessToken.isEmpty) {
      throw const FormatException('Missing access token in response');
    }

    return AuthSessionModel(
      accessToken: accessToken,
      refreshToken: _readString(source, ['refreshToken', 'refresh_token']),
    );
  }
  
  AuthSession toEntity() {
    return AuthSession(accessToken: accessToken, refreshToken: refreshToken);
  }

  static String? _readString(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is String) return value;
    }
    return null;
  }
}
