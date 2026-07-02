import 'package:dio/dio.dart';

import '../errors/error_messages.dart';
import '../errors/failures.dart';

class DioErrorHandler {
  const DioErrorHandler._();

  static Failure handle(DioException error) {
    final responseData = error.response?.data;
    final statusCode = error.response?.statusCode;
    final validationMessage = _validationMessage(responseData);

    if (statusCode == 400 && validationMessage != null) {
      return ValidationFailure(validationMessage);
    }
    if (statusCode == 401) {
      return UnauthorizedFailure(
        _message(responseData) ?? ErrorMessages.unauthorized,
      );
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

    if (validationMessage != null) {
      return ValidationFailure(validationMessage);
    }

    final message =
        _message(responseData) ?? error.message ?? ErrorMessages.server;
    if (statusCode != null && statusCode >= 400 && statusCode < 500) {
      return ValidationFailure(message);
    }

    return ServerFailure(message);
  }

  static String? _message(dynamic data) {
    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message.trim();
      }
      final error = data['error'];
      if (error is Map<String, dynamic>) {
        final nestedMessage = error['message'];
        if (nestedMessage is String && nestedMessage.trim().isNotEmpty) {
          return nestedMessage.trim();
        }
      }
    }
    return null;
  }

  static String? _validationMessage(dynamic data) {
    if (data is! Map<String, dynamic>) return null;

    final code = _errorCode(data);
    if (code != 'VALIDATION_ERROR') return null;

    final details = _validationDetails(data);
    final message = _message(data);
    if (details != null && details.isNotEmpty) {
      if (message != null && message.isNotEmpty) {
        return '$message: $details';
      }
      return details;
    }

    return message;
  }

  static String? _errorCode(Map<String, dynamic> data) {
    final topCode = data['code'];
    if (topCode is String && topCode.trim().isNotEmpty) {
      return topCode.trim();
    }

    final error = data['error'];
    if (error is Map<String, dynamic>) {
      final nestedCode = error['code'];
      if (nestedCode is String && nestedCode.trim().isNotEmpty) {
        return nestedCode.trim();
      }
    }

    return null;
  }

  static String? _validationDetails(Map<String, dynamic> data) {
    final details = data['details'];
    final topLevel = _detailsToText(details);
    if (topLevel != null && topLevel.isNotEmpty) {
      return topLevel;
    }

    final error = data['error'];
    if (error is Map<String, dynamic>) {
      return _detailsToText(error['details']);
    }

    return null;
  }

  static String? _detailsToText(dynamic details) {
    if (details is List) {
      final parts = <String>[];
      for (final item in details) {
        if (item is Map<String, dynamic>) {
          final message = item['message'];
          final path = item['path'];
          final messageText =
              message is String ? message.trim() : message?.toString().trim();
          final pathText =
              path is String ? path.trim() : path?.toString().trim();

          if (messageText != null && messageText.isNotEmpty) {
            if (pathText != null && pathText.isNotEmpty) {
              parts.add('$pathText: $messageText');
            } else {
              parts.add(messageText);
            }
          }
        }
      }
      return parts.join(' • ');
    }

    if (details is String && details.trim().isNotEmpty) {
      return details.trim();
    }

    return null;
  }
}
