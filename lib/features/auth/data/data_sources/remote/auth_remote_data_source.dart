import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/auth_session_model.dart';
import '../../models/register_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login({
    required String email,
    required String password,
    String? fcmToken,
    String? platform,
  });

  Future<AuthSessionModel> register({
    required RegisterRegistrationModel registrationModel,
    String? fcmToken,
    String? platform,
  });
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<AuthSessionModel> login({
    required String email,
    required String password,
    String? fcmToken,
    String? platform,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      data: {
        'email': email,
        'password': password,
        if (fcmToken != null && platform != null) ...{
          'fcmToken': fcmToken,
          'platform': platform,
        },
      },
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return AuthSessionModel.fromJson(data);
    }

    throw const FormatException('Invalid login response');
  }

  @override
  Future<AuthSessionModel> register({
    required RegisterRegistrationModel registrationModel,
    String? fcmToken,
    String? platform,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.register,
      data: {
        ...registrationModel.toJson(),
        if (fcmToken != null && platform != null) ...{
          'fcmToken': fcmToken,
          'platform': platform,
        },
      },
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return AuthSessionModel.fromJson(data);
    }

    throw const FormatException('Invalid register response');
  }
}
