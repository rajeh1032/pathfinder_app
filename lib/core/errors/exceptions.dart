class AppException implements Exception {
  const AppException(this.message);

  final String message;
}

class ServerException extends AppException {
  const ServerException(super.message);
}

class CacheException extends AppException {
  const CacheException(super.message);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message);
}
