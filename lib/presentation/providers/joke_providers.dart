import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/dependency_injection.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/joke.dart';
import '../../domain/repositories/joke_repository.dart';

/// Provider'lar - State Management için
/// Dependency Injection: GetIt ile yapılıyor
/// State Management: Riverpod ile yapılıyor
/// Error Handling: Either pattern ile yapılıyor

/// Repository'yi GetIt'ten al
/// GetIt service locator pattern kullanıyor
JokeRepository get _repository => getIt<JokeRepository>();

/// Tüm esprileri getiren provider
/// Either<Failure, List<Joke>> pattern ile error handling
/// AsyncValue ile loading, error ve data state'lerini otomatik yönetir
final jokesProvider = FutureProvider<Either<Failure, List<Joke>>>((ref) async {
  return await _repository.getAllJokes();
});

/// Kategorileri getiren provider
/// Either pattern ile error handling
final categoriesProvider = FutureProvider<Either<Failure, List<String>>>((ref) async {
  return await _repository.getCategories();
});

/// Seçili kategori için state provider
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

/// Filtrelenmiş esprileri getiren provider
/// Seçili kategoriye göre esprileri filtreler
/// Either pattern ile error handling
final filteredJokesProvider = FutureProvider<Either<Failure, List<Joke>>>((ref) async {
  final selectedCategory = ref.watch(selectedCategoryProvider);

  if (selectedCategory == null || selectedCategory == 'Tümü') {
    return await _repository.getAllJokes();
  } else {
    return await _repository.getJokesByCategory(selectedCategory);
  }
});
