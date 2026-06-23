import 'package:dio/dio.dart';

import '../app/app_config.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(BaseOptions(
      baseUrl: '${AppConfig.baseUrl}/api',
      connectTimeout: AppConfig.connectTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
    ));

    return dio;
  }
}
