import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/joke.dart';
import '../../domain/repositories/joke_repository.dart';
import '../datasources/remote_joke_datasource.dart';

/// Repository'nin implementation'ı
/// Domain katmanındaki interface'i implement eder ve data source'u kullanır
/// Bu sayede domain katmanı veri kaynağından bağımsız kalır
/// Exception'ları yakalayıp Failure'a dönüştürür
class JokeRepositoryImpl implements JokeRepository {
  final RemoteJokeDataSource dataSource;

  JokeRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Joke>>> getAllJokes() async {
    try {
      final jokeModels = await dataSource.getAllJokes();
      // Model'leri entity'lere dönüştür
      final jokes = jokeModels.map((model) => model.toEntity()).toList();
      return Right(jokes);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on TimeoutException catch (e) {
      return Left(TimeoutFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: 'Beklenmeyen hata: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Joke>>> getJokesByCategory(String category) async {
    try {
      final jokeModels = await dataSource.getJokesByCategory(category);
      final jokes = jokeModels.map((model) => model.toEntity()).toList();
      return Right(jokes);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: 'Beklenmeyen hata: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Joke>> getJokeById(int id) async {
    try {
      final jokeModel = await dataSource.getJokeById(id);
      if (jokeModel == null) {
        return Left(ServerFailure(message: 'Espri bulunamadı', statusCode: 404));
      }
      return Right(jokeModel.toEntity());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: 'Beklenmeyen hata: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await dataSource.getCategories();
      return Right(categories);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: 'Beklenmeyen hata: ${e.toString()}'));
    }
  }

  /// DioException'ları Failure'a dönüştür
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure();

      case DioExceptionType.connectionError:
        return const NetworkFailure();

      case DioExceptionType.badResponse:
        return ServerFailure(
          message: 'Sunucu hatası: ${error.response?.statusMessage ?? 'Bilinmeyen hata'}',
          statusCode: error.response?.statusCode,
        );

      case DioExceptionType.cancel:
        return const UnexpectedFailure(message: 'İstek iptal edildi');

      default:
        return UnexpectedFailure(message: error.message ?? 'Bilinmeyen bir hata oluştu');
    }
  }
}
