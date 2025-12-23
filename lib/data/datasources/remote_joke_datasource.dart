import 'package:dio/dio.dart';
import '../models/joke_model.dart';

/// Gerçek API'den veri çeken data source
/// Official Joke API kullanıyor: https://official-joke-api.appspot.com
class RemoteJokeDataSource {
  final Dio dio;
  static const String baseUrl = 'https://official-joke-api.appspot.com';

  RemoteJokeDataSource({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: baseUrl,
              connectTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 3),
            ),
          );

  /// Random bir espri getir
  Future<JokeModel> getRandomJoke() async {
    try {
      final response = await dio.get('/random_joke');
      return JokeModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('API hatası: ${e.message}');
    } catch (e) {
      throw Exception('Espri yüklenirken hata oluştu: $e');
    }
  }

  /// Birden fazla random espri getir (10 adet)
  Future<List<JokeModel>> getRandomJokes({int count = 10}) async {
    try {
      final response = await dio.get('/random_ten');
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => JokeModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('API hatası: ${e.message}');
    } catch (e) {
      throw Exception('Espriler yüklenirken hata oluştu: $e');
    }
  }

  /// Tüm esprileri getir
  Future<List<JokeModel>> getAllJokes() async {
    // API'den 10 random espri çek
    return await getRandomJokes(count: 10);
  }

  /// Kategoriye göre esprileri filtrele
  Future<List<JokeModel>> getJokesByCategory(String category) async {
    try {
      // Kategoriye göre endpoint'ler farklı olabilir
      // Şimdilik tüm esprileri çekip filtreliyoruz
      final jokes = await getRandomJokes(count: 20);
      return jokes.where((joke) => joke.category.toLowerCase() == category.toLowerCase()).toList();
    } catch (e) {
      throw Exception('Kategoriye göre espriler yüklenirken hata oluştu: $e');
    }
  }

  /// ID'ye göre espri getir
  Future<JokeModel?> getJokeById(int id) async {
    try {
      final response = await dio.get('/jokes/$id');
      return JokeModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      throw Exception('API hatası: ${e.message}');
    } catch (e) {
      throw Exception('Espri yüklenirken hata oluştu: $e');
    }
  }

  /// Kategorileri getir
  Future<List<String>> getCategories() async {
    try {
      // API'den 30 espri çekip kategorileri çıkar
      final jokes = await getRandomJokes(count: 30);
      final categories = jokes.map((joke) => joke.category).toSet().toList();
      return categories;
    } catch (e) {
      throw Exception('Kategoriler yüklenirken hata oluştu: $e');
    }
  }
}
