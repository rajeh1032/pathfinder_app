import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/app_config.dart';
import '../../network/api_interceptor.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(ApiInterceptor apiInterceptor) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: AppConfig.connectTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
      ),
    );
    dio.interceptors.addAll([
      apiInterceptor,
      PrettyDioLogger(requestHeader: true, requestBody: true),
    ]);
    return dio;
  }
}
