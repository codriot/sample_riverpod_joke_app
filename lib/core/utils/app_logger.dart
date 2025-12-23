import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

/// Global logger instance
/// Büyük projelerde tüm log işlemleri merkezi olarak yönetilir
/// Development'ta verbose, production'da sadece error logları
class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;

  late final Logger _logger;

  AppLogger._internal() {
    _logger = Logger(
      filter: _CustomLogFilter(),
      printer: PrettyPrinter(
        methodCount: 2, // Stack trace'de kaç method gösterilsin
        errorMethodCount: 8, // Error'larda daha fazla stack trace
        lineLength: 120, // Terminal genişliği
        colors: true, // Renkli log (terminal destekliyorsa)
        printEmojis: true, // Log seviyelerine emoji ekle
        printTime: true, // Zaman damgası göster
      ),
      output: _CustomLogOutput(),
    );
  }

  /// Debug level log
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Info level log
  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Warning level log
  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Error level log
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Fatal error log (WTF = What a Terrible Failure)
  void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}

/// Custom log filter
/// Development mode'da tüm logları göster
/// Production mode'da sadece warning ve üzeri
class _CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    // Production'da sadece warning, error ve fatal logları göster
    if (kReleaseMode) {
      return event.level.index >= Level.warning.index;
    }
    // Development'ta tüm logları göster
    return true;
  }
}

/// Custom log output
/// İleride Firebase Crashlytics, Sentry vb. eklenebilir
class _CustomLogOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      // Debug console'a yaz
      // ignore: avoid_print
      print(line);

      // Burada ileride:
      // - Firebase Crashlytics'e gönder (error ve fatal için)
      // - Sentry'ye gönder
      // - Local dosyaya yaz (son 1000 log mesajı)
      // - Analytics event olarak gönder
    }
  }
}

/// Global logger instance - kolay erişim için
final logger = AppLogger();
