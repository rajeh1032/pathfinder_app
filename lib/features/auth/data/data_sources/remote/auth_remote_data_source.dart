import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/auth_session_model.dart';
import '../../models/register_model.dart'; 
abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  });

  // إضافة ميثود الـ register في الـ Interface
  Future<AuthSessionModel> register({
    required RegisterRegistrationModel registrationModel,
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
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      data: {
        'email': email,
        'password': password,
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
  }) async {
    // 1. إرسال الـ Request للـ Endpoint الخاص بالـ Register الممرر من الـ ApiEndpoints
    final response = await _apiClient.post(
      ApiEndpoints.register, // تأكد من إضافة الـ path ده جوه الـ ApiEndpoints عندك
      data: registrationModel.toJson(), // تحويل الموديل لـ Map
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      // 2. عمل parse للـ AuthSessionModel عشان نستخرج الـ tokens (AccessToken / RefreshToken)
      return AuthSessionModel.fromJson(data);
    }

    throw const FormatException('Invalid register response');
  }
}