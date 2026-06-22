import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, {this.statusCode});

  factory AppException.fromDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return AppException('connectionTimeout'.trFallback());
    }

    if (error.type == DioExceptionType.connectionError) {
      return AppException('noInternetConnection'.trFallback());
    }

    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    String? serverMessage;
    if (data is Map<String, dynamic>) {
      serverMessage = data['message'] as String? ?? data['error'] as String?;
    }

    switch (statusCode) {
      case 400:
        return AppException(serverMessage ?? 'validationFailed'.trFallback(),
            statusCode: 400);
      case 401:
        return AppException(serverMessage ?? 'sessionExpired'.trFallback(),
            statusCode: 401);
      case 404:
        return AppException(serverMessage ?? 'notFound'.trFallback(),
            statusCode: 404);
      case 409:
        return AppException(serverMessage ?? 'conflict'.trFallback(),
            statusCode: 409);
      case 413:
        return AppException(serverMessage ?? 'fileTooLarge'.trFallback(),
            statusCode: 413);
      case 415:
        return AppException(serverMessage ?? 'unsupportedFileType'.trFallback(),
            statusCode: 415);
      case 429:
        return AppException(serverMessage ?? 'tooManyRequests'.trFallback(),
            statusCode: 429);
      default:
        return AppException(
          serverMessage ?? 'somethingWentWrong'.trFallback(),
          statusCode: statusCode,
        );
    }
  }

  @override
  String toString() => message;
}

// Small helper extension so this file doesn't hard-depend on easy_localization
// context. Replace with `.tr()` calls directly if you prefer localized
// strings resolved at the call site instead.
extension _TrFallback on String {
  String trFallback() => this;
}
