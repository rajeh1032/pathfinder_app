import 'package:dio/dio.dart';

import '../errors/error_messages.dart';
import '../errors/failures.dart';

class DioErrorHandler {
  const DioErrorHandler._();

  static Failure handle(DioException error) {
    final statusCode = error.response?.statusCode;
    if (statusCode == 401) {
      return const UnauthorizedFailure(ErrorMessages.unauthorized);
    }
    if (error.type == DioExceptionType.connectionError) {
      return const NetworkFailure(ErrorMessages.network);
    }
    return ServerFailure(error.message ?? ErrorMessages.server);
  }
}
