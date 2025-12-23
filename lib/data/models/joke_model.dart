import '../../domain/entities/joke.dart';

/// Data katmanındaki model sınıfı
/// Domain entity'sinden farklı olarak JSON dönüşümü gibi veri işlemleri içerir
class JokeModel {
  final int id;
  final String setup;
  final String punchline;
  final String category;

  const JokeModel({required this.id, required this.setup, required this.punchline, required this.category});

  /// Model'den domain entity'sine dönüşüm
  Joke toEntity() {
    return Joke(id: id, setup: setup, punchline: punchline, category: category);
  }

  /// JSON'dan model oluşturma (API entegrasyonu için)
  factory JokeModel.fromJson(Map<String, dynamic> json) {
    return JokeModel(
      id: json['id'] as int,
      setup: json['setup'] as String,
      punchline: json['punchline'] as String,
      category: json['type'] as String, // API'de 'type' olarak geliyor
    );
  }

  /// Model'i JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {'id': id, 'setup': setup, 'punchline': punchline, 'category': category};
  }
}
