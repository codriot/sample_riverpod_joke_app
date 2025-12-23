import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../data/datasources/remote_joke_datasource.dart';
import '../data/repositories/joke_repository_impl.dart';
import '../domain/repositories/joke_repository.dart';
import 'config/env_config.dart';
import 'utils/app_logger.dart';

/// GetIt service locator instance
/// Tüm dependency'leri burada register ediyoruz
final getIt = GetIt.instance;

/// Dependency Injection setup
/// Uygulama başlangıcında çağrılmalı
/// Environment config'den değerleri alıyor
void setupDependencyInjection() {
  logger.d('Setting up dependencies...');

  // 1. Dio instance (Singleton)
  // Environment config'den timeout değerleri alınıyor
  // Tek bir instance oluşturulur ve her yerde aynısı kullanılır
  getIt.registerSingleton<Dio>(
    Dio(
        BaseOptions(
          baseUrl: EnvConfig.apiBaseUrl,
          connectTimeout: Duration(seconds: EnvConfig.connectTimeout),
          receiveTimeout: Duration(seconds: EnvConfig.receiveTimeout),
          headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        ),
      )
      ..interceptors.add(
        LogInterceptor(
          requestBody: EnvConfig.isDebugMode,
          responseBody: EnvConfig.isDebugMode,
          error: true,
          logPrint: (obj) => logger.d(obj),
        ),
      ),
  );
  logger.d('Dio configured with base URL: ${EnvConfig.apiBaseUrl}');

  // 2. Remote Data Source (Singleton)
  // Dio'yu inject ediyor
  getIt.registerSingleton<RemoteJokeDataSource>(RemoteJokeDataSource(dio: getIt<Dio>()));
  logger.d('RemoteJokeDataSource registered');

  // 3. Repository (Singleton)
  // Data source'u inject ediyor
  // Interface'e register ediyoruz, implementation'ı veriyoruz
  getIt.registerSingleton<JokeRepository>(JokeRepositoryImpl(getIt<RemoteJokeDataSource>()));
  logger.d('JokeRepository registered');

  logger.i('✅ All dependencies registered successfully');
}

/// Kullanım örnekleri:
/// 
/// Repository'yi al:
/// final repository = getIt<JokeRepository>();
/// 
/// Dio'yu al:
/// final dio = getIt<Dio>();
/// 
/// Test için mock register et:
/// getIt.registerSingleton<JokeRepository>(MockJokeRepository());
