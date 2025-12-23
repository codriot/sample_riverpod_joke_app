import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../data/datasources/remote_joke_datasource.dart';
import '../../data/repositories/joke_repository_impl.dart';
import '../../domain/entities/joke.dart';
import '../../domain/repositories/joke_repository.dart';

/// Provider'lar - Dependency Injection için
/// Riverpod ile bağımlılıkları yönetiyoruz

/// Dio instance provider
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://official-joke-api.appspot.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );
});

/// Data source provider - Gerçek API kullanıyor
final jokeDataSourceProvider = Provider<RemoteJokeDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return RemoteJokeDataSource(dio: dio);
});

/// Repository provider
/// DataSource'u inject ediyor
final jokeRepositoryProvider = Provider<JokeRepository>((ref) {
  final dataSource = ref.watch(jokeDataSourceProvider);
  return JokeRepositoryImpl(dataSource);
});

/// Tüm esprileri getiren provider
/// AsyncValue ile loading, error ve data state'lerini otomatik yönetir
final jokesProvider = FutureProvider<List<Joke>>((ref) async {
  final repository = ref.watch(jokeRepositoryProvider);
  return await repository.getAllJokes();
});

/// Kategorileri getiren provider
final categoriesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(jokeRepositoryProvider);
  return await repository.getCategories();
});

/// Seçili kategori için state provider
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

/// Filtrelenmiş esprileri getiren provider
/// Seçili kategoriye göre esprileri filtreler
final filteredJokesProvider = FutureProvider<List<Joke>>((ref) async {
  final repository = ref.watch(jokeRepositoryProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);

  if (selectedCategory == null || selectedCategory == 'Tümü') {
    return await repository.getAllJokes();
  } else {
    return await repository.getJokesByCategory(selectedCategory);
  }
});
