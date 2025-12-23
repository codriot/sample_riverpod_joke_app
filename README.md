# Espri Uygulaması - Clean Architecture & Riverpod

Bu proje, Flutter'da **Clean Architecture** ve **Riverpod** state management kullanımını öğrenmek için hazırlanmış bir demo uygulamadır.

## 📚 Mimari Yapı

Proje 3 ana katmandan oluşur:

### 1. Domain Layer (`lib/domain/`)
- **Entities**: İş mantığındaki temel nesneler
  - `Joke`: Espri entity'si
- **Repositories**: Veri operasyonları için interface'ler
  - `JokeRepository`: Repository kontratı

**Özellikler:**
- Framework'lerden bağımsız
- Pure Dart kodu
- İş mantığını içerir

### 2. Data Layer (`lib/data/`)
- **Models**: Veri transfer objeleri
  - `JokeModel`: JSON dönüşümlerini içeren model
- **Data Sources**: Veri kaynakları
  - `MockJokeDataSource`: Mock veri sağlayıcı
- **Repositories**: Repository implementasyonları
  - `JokeRepositoryImpl`: Repository interface'inin implementasyonu

**Özellikler:**
- Domain layer'daki interface'leri implement eder
- Veri kaynaklarıyla iletişim kurar
- Model ↔ Entity dönüşümlerini yapar

### 3. Presentation Layer (`lib/presentation/`)
- **Providers**: Riverpod provider'ları
  - Dependency injection
  - State management
  - Veri akışı yönetimi
- **Screens**: UI ekranları
  - `JokesScreen`: Ana espri listesi ekranı
- **Widgets**: Tekrar kullanılabilir UI bileşenleri
  - `JokeCard`: Espri kartı widget'ı

**Özellikler:**
- Riverpod ile state management
- Consumer widget'ları kullanır
- UI/UX odaklıdır

## 🎯 Clean Architecture Prensipleri

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│  (UI, Providers, State Management)      │
└──────────────┬──────────────────────────┘
               │
               ↓
┌─────────────────────────────────────────┐
│           Domain Layer                  │
│    (Entities, Repository Interfaces)    │
└──────────────┬──────────────────────────┘
               │
               ↓
┌─────────────────────────────────────────┐
│            Data Layer                   │
│  (Models, Data Sources, Repo Impl)      │
└─────────────────────────────────────────┘
```

**Dependency Rule:** Bağımlılıklar her zaman içe doğru akar. Domain layer hiçbir şeye bağımlı değildir!

## 🔄 Riverpod Provider'ları

1. **Provider**: Dependency injection için
   ```dart
   final jokeRepositoryProvider = Provider<JokeRepository>((ref) {...});
   ```

2. **FutureProvider**: Asenkron veri için
   ```dart
   final jokesProvider = FutureProvider<List<Joke>>((ref) async {...});
   ```

3. **StateProvider**: Basit state yönetimi için
   ```dart
   final selectedCategoryProvider = StateProvider<String?>((ref) => null);
   ```

## 🚀 Nasıl Çalıştırılır

```bash
# Bağımlılıkları yükle
flutter pub get

# Uygulamayı çalıştır
flutter run
```

## ✨ Özellikler

- ✅ Esprileri listeleme
- ✅ Kategoriye göre filtreleme
- ✅ Cevabı göster/gizle animasyonu
- ✅ Pull-to-refresh
- ✅ Loading ve error state'leri
- ✅ Mock data ile çalışma

## 📖 Öğrenme Notları

### Clean Architecture Avantajları:
- ✅ Test edilebilir kod
- ✅ Bağımsız katmanlar
- ✅ Kolay değiştirilebilir veri kaynakları
- ✅ İş mantığının framework'den ayrılması

### Riverpod Avantajları:
- ✅ Compile-time safety
- ✅ Provider'ları birleştirme
- ✅ Otomatik disposal
- ✅ Testing desteği
- ✅ AsyncValue ile state yönetimi

## 🎓 Sonraki Adımlar

Bu yapıyı öğrendikten sonra:
1. Gerçek API entegrasyonu ekleyin (data source değiştirin)
2. Local database ekleyin (Hive, SQLite)
3. Use case'ler ekleyin (domain layer)
4. Error handling geliştirin
5. Unit test'ler yazın
6. Integration test'ler ekleyin

## 📝 Notlar

- Mock data 1 saniyelik gecikme ile yüklenir (gerçek API simülasyonu)
- Kategoriler otomatik olarak oluşturulur
- Her espri kartına tıklayarak cevabı görebilirsiniz

