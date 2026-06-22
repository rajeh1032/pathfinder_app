
import 'package:dio/dio.dart';

import '../app/app_config.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(BaseOptions(
      baseUrl: '${AppConfig.baseUrl}/api',
      connectTimeout: AppConfig.connectTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          const testToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1MTlmNTBkNC1iMWE4LTQ3ZDktYmJmNi0wODhhM2ZiOGM4ZTMiLCJlbWFpbCI6InN0dWRlbnRAZXhhbXBsZS5jb20iLCJyb2xlIjoidXNlciIsImlhdCI6MTc4MTYzMTMzMiwiZXhwIjoxNzgxNzE3NzMyfQ.VLdRVFBrWW57uXPaVhs3Go4ukEKaaiqiUgpCvzX3nxg';
          options.headers['Authorization'] = 'Bearer $testToken';
          return handler.next(options);
        },
      ),
    );

    return dio;
  }
}