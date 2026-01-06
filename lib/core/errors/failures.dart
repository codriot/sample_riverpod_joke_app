import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
/// Büyük projelerde hata yönetimi için merkezi failure sistemi
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? details;

  const Failure({required this.message, this.statusCode, this.details});

  @override
  List<Object?> get props => [message, statusCode, details];
}

/// Server failure - API hatalarında kullanılır
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode, super.details});
}

/// Network failure - İnternet bağlantısı problemlerinde
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'İnternet bağlantınızı kontrol edin'});
}

/// Cache failure - Local storage hatalarında
class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Local veri okunamadı'});
}

/// Validation failure - Input validasyon hatalarında
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.details});
}

/// Timeout failure - İstek zaman aşımında
class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message = 'İstek zaman aşımına uğradı'});
}

/// Unexpected failure - Beklenmeyen hatalar için
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message = 'Beklenmeyen bir hata oluştu', super.details});
}
