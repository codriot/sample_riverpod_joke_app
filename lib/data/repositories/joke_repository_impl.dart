import '../../domain/entities/joke.dart';
import '../../domain/repositories/joke_repository.dart';
import '../datasources/remote_joke_datasource.dart';

/// Repository'nin implementation'ı
/// Domain katmanındaki interface'i implement eder ve data source'u kullanır
/// Bu sayede domain katmanı veri kaynağından bağımsız kalır
class JokeRepositoryImpl implements JokeRepository {
  final RemoteJokeDataSource dataSource;

  JokeRepositoryImpl(this.dataSource);

  @override
  Future<List<Joke>> getAllJokes() async {
    try {
      final jokeModels = await dataSource.getAllJokes();
      // Model'leri entity'lere dönüştür
      return jokeModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      // Gerçek uygulamada custom exception'lar kullanılabilir
      throw Exception('Espriler yüklenirken hata oluştu: $e');
    }
  }

  @override
  Future<List<Joke>> getJokesByCategory(String category) async {
    try {
      final jokeModels = await dataSource.getJokesByCategory(category);
      return jokeModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Kategoriye göre espriler yüklenirken hata oluştu: $e');
    }
  }

  @override
  Future<Joke?> getJokeById(int id) async {
    try {
      final jokeModel = await dataSource.getJokeById(id);
      return jokeModel?.toEntity();
    } catch (e) {
      throw Exception('Espri yüklenirken hata oluştu: $e');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      return await dataSource.getCategories();
    } catch (e) {
      throw Exception('Kategoriler yüklenirken hata oluştu: $e');
    }
  }
}
