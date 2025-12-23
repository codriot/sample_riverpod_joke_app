import '../models/joke_model.dart';

/// Mock veri kaynağı sınıfı
/// Gerçek uygulamada bu bir API client veya local database olabilir
class MockJokeDataSource {
  /// Mock espri verileri
  static final List<JokeModel> _mockJokes = [
    const JokeModel(
      id: 1,
      setup: 'Programcı neden karanlıktan korkar?',
      punchline: 'Çünkü ışık açılınca bug\'lar görünür!',
      category: 'programlama',
    ),
    const JokeModel(
      id: 2,
      setup: 'Flutter geliştiricisi ne içer?',
      punchline: 'Hot Reload kahve!',
      category: 'programlama',
    ),
    const JokeModel(
      id: 3,
      setup: 'Riverpod provider\'ı neden mutlu?',
      punchline: 'Çünkü her zaman state\'ini biliyor!',
      category: 'programlama',
    ),
    const JokeModel(
      id: 4,
      setup: 'Neden elma ağaçları iyi programcı olamaz?',
      punchline: 'Çünkü hep branch yaratırlar!',
      category: 'genel',
    ),
    const JokeModel(
      id: 5,
      setup: 'Balık bilgisayar kullanabilir mi?',
      punchline: 'Evet ama sadece stream\'lerde!',
      category: 'genel',
    ),
    const JokeModel(
      id: 6,
      setup: 'Widget neden terapiste gitti?',
      punchline: 'Çünkü parent sorunları vardı!',
      category: 'programlama',
    ),
    const JokeModel(
      id: 7,
      setup: 'Async fonksiyon neden geç kaldı?',
      punchline: 'await ediyordu!',
      category: 'programlama',
    ),
    const JokeModel(
      id: 8,
      setup: 'JSON neden konuşamıyor?',
      punchline: 'Çünkü parse edilmesi gerekiyor!',
      category: 'programlama',
    ),
  ];

  /// Tüm esprileri getir (API call simülasyonu için 1 saniye gecikme)
  Future<List<JokeModel>> getAllJokes() async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockJokes;
  }

  /// Kategoriye göre esprileri filtrele
  Future<List<JokeModel>> getJokesByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockJokes.where((joke) => joke.category.toLowerCase() == category.toLowerCase()).toList();
  }

  /// ID'ye göre espri getir
  Future<JokeModel?> getJokeById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockJokes.firstWhere((joke) => joke.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Kategorileri getir
  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockJokes.map((joke) => joke.category).toSet().toList();
  }
}
