import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/joke.dart';

part 'joke_model.freezed.dart';
part 'joke_model.g.dart';

/// Data katmanındaki model sınıfı
/// Freezed ile immutable, copyWith, equality, serialization otomatik oluşturulur
@freezed
class JokeModel with _$JokeModel {
  const factory JokeModel({
    required int id,
    required String setup,
    required String punchline,
    @JsonKey(name: 'type') required String category, // API'de 'type' olarak geliyor
  }) = _JokeModel;

  /// Private constructor for methods
  const JokeModel._();

  /// JSON'dan model oluşturma (json_serializable otomatik generate eder)
  factory JokeModel.fromJson(Map<String, dynamic> json) => _$JokeModelFromJson(json);

  /// Model'den domain entity'sine dönüşüm
  Joke toEntity() {
    return Joke(id: id, setup: setup, punchline: punchline, category: category);
  }
}
