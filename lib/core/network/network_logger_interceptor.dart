import 'package:dio/dio.dart';
import '../utils/log_storage.dart';

/// Dio Interceptor - Network isteklerini loglar
/// Debug console'da network isteklerini görmek için kullanılır
class NetworkLoggerInterceptor extends Interceptor {
  final _logStorage = LogStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final timestamp = DateTime.now();

    // Request'i logla
    _logStorage.addLog(
      LogEntry(
        timestamp: timestamp,
        level: LogLevel.network,
        message: '${options.method} ${options.path}',
        method: options.method,
        url: options.uri.toString(),
        requestHeaders: options.headers.map((key, value) => MapEntry(key, value)),
        requestBody: options.data,
      ),
    );

    // Request başlangıç zamanını extra'ya ekle
    options.extra['request_start_time'] = timestamp;

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final startTime = response.requestOptions.extra['request_start_time'] as DateTime?;
    final duration = startTime != null ? DateTime.now().difference(startTime) : null;

    // Response'u logla
    _logStorage.addLog(
      LogEntry(
        timestamp: DateTime.now(),
        level: LogLevel.network,
        message: '${response.requestOptions.method} ${response.requestOptions.path} - ${response.statusCode}',
        method: response.requestOptions.method,
        url: response.requestOptions.uri.toString(),
        statusCode: response.statusCode,
        requestHeaders: response.requestOptions.headers.map((key, value) => MapEntry(key, value)),
        requestBody: response.requestOptions.data,
        responseHeaders: response.headers.map.map((key, value) => MapEntry(key, value.join(', '))),
        responseBody: response.data,
        duration: duration,
      ),
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final startTime = err.requestOptions.extra['request_start_time'] as DateTime?;
    final duration = startTime != null ? DateTime.now().difference(startTime) : null;

    // Error'u logla
    _logStorage.addLog(
      LogEntry(
        timestamp: DateTime.now(),
        level: LogLevel.network,
        message: '${err.requestOptions.method} ${err.requestOptions.path} - ERROR',
        method: err.requestOptions.method,
        url: err.requestOptions.uri.toString(),
        statusCode: err.response?.statusCode,
        requestHeaders: err.requestOptions.headers.map((key, value) => MapEntry(key, value)),
        requestBody: err.requestOptions.data,
        responseHeaders: err.response?.headers.map.map((key, value) => MapEntry(key, value.join(', '))),
        responseBody: err.response?.data,
        error: err.message,
        duration: duration,
      ),
    );

    super.onError(err, handler);
  }
}
