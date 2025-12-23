import '../entities/joke.dart';

/// Domain katmanındaki repository interface'i
/// Bu abstract sınıf veri katmanının implement etmesi gereken kontratı tanımlar
/// Clean Architecture'da dependency rule'a göre domain katmanı hiçbir şeye bağımlı olmaz
abstract class JokeRepository {
  /// Tüm esprileri getirir
  Future<List<Joke>> getAllJokes();

  /// Kategoriye göre esprileri filtreler
  Future<List<Joke>> getJokesByCategory(String category);

  /// ID'ye göre tek bir espri getirir
  Future<Joke?> getJokeById(int id);

  /// Mevcut kategorilerin listesini getirir
  Future<List<String>> getCategories();
}
