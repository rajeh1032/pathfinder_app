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
    if (statusCode == 400 || statusCode == 422) {
      return const ValidationFailure('courses.validationError');
    }
    if (error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return const NetworkFailure(ErrorMessages.network);
    }
    return ServerFailure(error.message ?? ErrorMessages.server);
  }
}
