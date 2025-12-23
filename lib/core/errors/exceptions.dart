/// Base class for all exceptions in the application
/// Exception'lar data layer'da throw edilir, repository'de yakalanıp Failure'a dönüştürülür
class AppException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? details;

  const AppException({required this.message, this.statusCode, this.details});

  @override
  String toString() => 'AppException: $message (statusCode: $statusCode)';
}

/// API'den gelen hata yanıtları için
class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode, super.details});
}

/// Network bağlantı hataları için
class NetworkException extends AppException {
  const NetworkException({super.message = 'Network connection failed'});
}

/// Cache okuma/yazma hataları için
class CacheException extends AppException {
  const CacheException({super.message = 'Cache operation failed'});
}

/// Timeout hataları için
class TimeoutException extends AppException {
  const TimeoutException({super.message = 'Request timeout'});
}

/// JSON parsing hataları için
class ParseException extends AppException {
  const ParseException({super.message = 'Failed to parse response', super.details});
}
