import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'flavor_config.dart';

/// Environment configuration
/// .env dosyasından ve FlavorConfig'den değerleri okur
/// Farklı environment'lar için (dev, staging, prod) farklı değerler kullanılır
class EnvConfig {
  /// API base URL - Flavor'dan gelir
  static String get apiBaseUrl {
    if (FlavorConfig.isInitialized) {
      return FlavorConfig.instance.flavorValues.baseUrl;
    }
    return dotenv.env['API_BASE_URL'] ?? 'https://official-joke-api.appspot.com';
  }

  /// API timeout duration (seconds) - Flavor'dan gelir
  static int get apiTimeout {
    if (FlavorConfig.isInitialized) {
      return FlavorConfig.instance.flavorValues.apiTimeout;
    }
    return int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30') ?? 30;
  }

  /// Connect timeout (seconds) - Flavor'dan gelir
  static int get connectTimeout {
    if (FlavorConfig.isInitialized) {
      return FlavorConfig.instance.flavorValues.connectTimeout;
    }
    return int.tryParse(dotenv.env['CONNECT_TIMEOUT'] ?? '10') ?? 10;
  }

  /// Receive timeout (seconds) - Flavor'dan gelir
  static int get receiveTimeout {
    if (FlavorConfig.isInitialized) {
      return FlavorConfig.instance.flavorValues.receiveTimeout;
    }
    return int.tryParse(dotenv.env['RECEIVE_TIMEOUT'] ?? '15') ?? 15;
  }

  /// Environment name (development, staging, production)
  static String get environment {
    if (FlavorConfig.isInitialized) {
      return FlavorConfig.instance.flavor.name.toLowerCase();
    }
    return dotenv.env['ENVIRONMENT'] ?? 'development';
  }

  /// Debug mode enabled
  static bool get isDebugMode {
    if (FlavorConfig.isInitialized) {
      return FlavorConfig.instance.flavor.isDebug;
    }
    return environment == 'development';
  }

  /// Production mode
  static bool get isProduction {
    if (FlavorConfig.isInitialized) {
      return FlavorConfig.instance.flavor.isProduction;
    }
    return environment == 'production';
  }

  /// Staging mode
  static bool get isStaging {
    if (FlavorConfig.isInitialized) {
      return FlavorConfig.instance.flavor.isStaging;
    }
    return environment == 'staging';
  }

  /// API versiyonu
  static String get apiVersion => dotenv.env['API_VERSION'] ?? 'v1';

  /// Analytics enabled - Flavor'dan gelir
  static bool get analyticsEnabled {
    if (FlavorConfig.isInitialized) {
      return FlavorConfig.instance.flavorValues.analyticsEnabled;
    }
    return dotenv.env['ANALYTICS_ENABLED']?.toLowerCase() == 'true';
  }

  /// Crashlytics enabled - Flavor'dan gelir
  static bool get crashlyticsEnabled {
    if (FlavorConfig.isInitialized) {
      return FlavorConfig.instance.flavorValues.crashlyticsEnabled;
    }
    return dotenv.env['CRASHLYTICS_ENABLED']?.toLowerCase() == 'true';
  }

  /// Tüm config değerlerini logla (debug için)
  static void logConfig() {
    if (isDebugMode) {
      print('===== Environment Configuration =====');
      if (FlavorConfig.isInitialized) {
        print('Flavor: ${FlavorConfig.instance.flavor.name}');
      }
      print('Environment: $environment');
      print('API Base URL: $apiBaseUrl');
      print('API Timeout: $apiTimeout seconds');
      print('Connect Timeout: $connectTimeout seconds');
      print('Receive Timeout: $receiveTimeout seconds');
      print('Analytics: $analyticsEnabled');
      print('Crashlytics: $crashlyticsEnabled');
      print('=====================================');
    }
  }
}
