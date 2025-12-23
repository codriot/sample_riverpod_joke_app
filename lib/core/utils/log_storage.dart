import 'dart:collection';

/// Log storage - Debug console için logları saklar
/// Singleton pattern ile sadece bir instance oluşturulur
class LogStorage {
  static final LogStorage _instance = LogStorage._internal();
  factory LogStorage() => _instance;
  LogStorage._internal();

  final _logs = Queue<LogEntry>();
  static const _maxLogs = 500; // Maksimum log sayısı

  /// Log ekle
  void addLog(LogEntry entry) {
    _logs.add(entry);

    // Maksimum log sayısını aşarsa en eskiyi sil
    if (_logs.length > _maxLogs) {
      _logs.removeFirst();
    }
  }

  /// Tüm logları al
  List<LogEntry> get logs => _logs.toList();

  /// Belirli seviyedeki logları al
  List<LogEntry> getLogsByLevel(LogLevel level) {
    return _logs.where((log) => log.level == level).toList();
  }

  /// Logları temizle
  void clear() {
    _logs.clear();
  }

  /// Log sayısı
  int get count => _logs.length;
}

/// Log entry model
class LogEntry {
  final DateTime timestamp;
  final LogLevel level;
  final String message;
  final dynamic error;
  final StackTrace? stackTrace;

  // Network için ek alanlar
  final String? method;
  final String? url;
  final int? statusCode;
  final Map<String, dynamic>? requestHeaders;
  final dynamic requestBody;
  final Map<String, dynamic>? responseHeaders;
  final dynamic responseBody;
  final Duration? duration;

  LogEntry({
    required this.timestamp,
    required this.level,
    required this.message,
    this.error,
    this.stackTrace,
    this.method,
    this.url,
    this.statusCode,
    this.requestHeaders,
    this.requestBody,
    this.responseHeaders,
    this.responseBody,
    this.duration,
  });

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write('[${level.emoji} ${level.name}] ');
    buffer.write('${timestamp.hour.toString().padLeft(2, '0')}:');
    buffer.write('${timestamp.minute.toString().padLeft(2, '0')}:');
    buffer.write('${timestamp.second.toString().padLeft(2, '0')} ');
    buffer.write(message);

    if (error != null) {
      buffer.write('\nError: $error');
    }

    return buffer.toString();
  }
}

/// Log levels
enum LogLevel {
  debug,
  info,
  warning,
  error,
  fatal,
  network;

  String get name {
    switch (this) {
      case LogLevel.debug:
        return 'DEBUG';
      case LogLevel.info:
        return 'INFO';
      case LogLevel.network:
        return 'NETWORK';
      case LogLevel.warning:
        return 'WARNING';
      case LogLevel.error:
        return 'ERROR';
      case LogLevel.fatal:
        return 'FATAL';
    }
  }

  String get emoji {
    switch (this) {
      case LogLevel.debug:
        return '🐛';
      case LogLevel.info:
        return 'ℹ️';
      case LogLevel.network:
        return '🌐';
      case LogLevel.warning:
        return '⚠️';
      case LogLevel.error:
        return '❌';
      case LogLevel.fatal:
        return '💀';
    }
  }
}
