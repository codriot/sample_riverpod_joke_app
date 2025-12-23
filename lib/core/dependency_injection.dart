import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'config/env_config.dart';
import 'network/network_logger_interceptor.dart';
import 'utils/app_logger.dart';

import 'dependency_injection.config.dart';

/// GetIt service locator instance
/// Injectable ile otomatik olarak doldurulur
final getIt = GetIt.instance;

/// Dependency Injection setup
/// Injectable ile otomatik kod üretimi kullanıyor
/// @InjectableInit annotation'ı ile configure edilir
@InjectableInit(initializerName: 'init', preferRelativeImports: true, asExtension: true)
void setupDependencyInjection() {
  logger.d('Setting up dependencies with Injectable...');
  getIt.init();
  logger.d('Injectable setup completed');
}

/// Dio Module - Dio instance'ı üretir
/// @module annotation'ı ile Injectable'a harici dependency olduğunu bildiriyoruz
@module
abstract class DioModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.apiBaseUrl,
        connectTimeout: Duration(seconds: EnvConfig.connectTimeout),
        receiveTimeout: Duration(seconds: EnvConfig.receiveTimeout),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );

    // Network logger interceptor ekle
    dio.interceptors.add(NetworkLoggerInterceptor());

    // Debug mode'da ek logging
    if (EnvConfig.isDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, error: true, logPrint: (obj) => logger.d(obj)),
      );
    }

    logger.d('Dio configured with base URL: ${EnvConfig.apiBaseUrl}');
    return dio;
  }
}
/// Repository'yi al:
/// final repository = getIt<JokeRepository>();
/// 
/// Dio'yu al:
/// final dio = getIt<Dio>();
/// 
/// Test için mock register et:
/// getIt.registerSingleton<JokeRepository>(MockJokeRepository());
