import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/dependency_injection.dart';
import '../../domain/entities/joke.dart';
import '../../domain/repositories/joke_repository.dart';

/// Provider'lar - State Management için
/// Dependency Injection: GetIt ile yapılıyor
/// State Management: Riverpod ile yapılıyor

/// Repository'yi GetIt'ten al
/// GetIt service locator pattern kullanıyor
JokeRepository get _repository => getIt<JokeRepository>();

/// Tüm esprileri getiren provider
/// AsyncValue ile loading, error ve data state'lerini otomatik yönetir
/// Repository GetIt'ten geliyor
final jokesProvider = FutureProvider<List<Joke>>((ref) async {
  return await _repository.getAllJokes();
});

/// Kategorileri getiren provider
/// Repository GetIt'ten geliyor
final categoriesProvider = FutureProvider<List<String>>((ref) async {
  return await _repository.getCategories();
});

/// Seçili kategori için state provider
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

/// Filtrelenmiş esprileri getiren provider
/// Seçili kategoriye göre esprileri filtreler
/// Repository GetIt'ten geliyor, selectedCategory Riverpod'dan
final filteredJokesProvider = FutureProvider<List<Joke>>((ref) async {
  final selectedCategory = ref.watch(selectedCategoryProvider);

  if (selectedCategory == null || selectedCategory == 'Tümü') {
    return await _repository.getAllJokes();
  } else {
    return await _repository.getJokesByCategory(selectedCategory);
  }
});
