import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/joke.dart';

/// Domain katmanındaki repository interface'i
/// Bu abstract sınıf veri katmanının implement etmesi gereken kontratı tanımlar
/// Clean Architecture'da dependency rule'a göre domain katmanı hiçbir şeye bağımlı olmaz
/// Either<Failure, Success> pattern ile error handling yapılır
abstract class JokeRepository {
  /// Tüm esprileri getirir
  /// Left: Hata durumu (Failure), Right: Başarı durumu (List<Joke>)
  Future<Either<Failure, List<Joke>>> getAllJokes();

  /// Kategoriye göre esprileri filtreler
  Future<Either<Failure, List<Joke>>> getJokesByCategory(String category);

  /// ID'ye göre tek bir espri getirir
  Future<Either<Failure, Joke>> getJokeById(int id);

  /// Mevcut kategorilerin listesini getirir
  Future<Either<Failure, List<String>>> getCategories();
}
