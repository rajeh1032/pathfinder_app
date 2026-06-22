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
    final user = data is Map<String, dynamic> ? data['user'] : null;
    final sources = [
      json,
      if (data is Map<String, dynamic>) data,
      if (user is Map<String, dynamic>) user,
    ];

    final accessToken = _readStringFromSources(sources, [
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
      refreshToken: _readStringFromSources(
        sources,
        ['refreshToken', 'refresh_token'],
      ),
    );
  }

  AuthSession toEntity() {
    return AuthSession(accessToken: accessToken, refreshToken: refreshToken);
  }

  static String? _readStringFromSources(
    List<Map<String, dynamic>> sources,
    List<String> keys,
  ) {
    for (final source in sources) {
      final value = _readString(source, keys);
      if (value != null && value.isNotEmpty) return value;
    }
    return null;
  }

  static String? _readString(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is String) return value;
    }
    return null;
  }
}
