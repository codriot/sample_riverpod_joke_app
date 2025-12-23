import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../data/datasources/remote_joke_datasource.dart';
import '../data/repositories/joke_repository_impl.dart';
import '../domain/repositories/joke_repository.dart';

/// GetIt service locator instance
/// Tüm dependency'leri burada register ediyoruz
final getIt = GetIt.instance;

/// Dependency Injection setup
/// Uygulama başlangıcında çağrılmalı
void setupDependencyInjection() {
  // 1. Dio instance (Singleton)
  // Tek bir instance oluşturulur ve her yerde aynısı kullanılır
  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: 'https://official-joke-api.appspot.com',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    ),
  );

  // 2. Remote Data Source (Singleton)
  // Dio'yu inject ediyor
  getIt.registerSingleton<RemoteJokeDataSource>(
    RemoteJokeDataSource(dio: getIt<Dio>()),
  );

  // 3. Repository (Singleton)
  // Data source'u inject ediyor
  // Interface'e register ediyoruz, implementation'ı veriyoruz
  getIt.registerSingleton<JokeRepository>(
    JokeRepositoryImpl(getIt<RemoteJokeDataSource>()),
  );
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
