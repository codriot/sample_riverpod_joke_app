# Flavor Sistemi Kullanım Kılavuzu

## 📋 Genel Bakış

Proje artık 3 farklı flavor (environment) desteği ile çalışıyor:
- **Development** 🔧
- **Staging** 🧪  
- **Production** 🚀

## 📁 Oluşturulan Dosyalar

### 1. `lib/core/models/flavor.dart`
Flavor enum tanımı ve yardımcı metodlar:
- `Flavor.development`, `Flavor.staging`, `Flavor.production`
- Her flavor için özel app title
- Debug mode kontrolleri

### 2. `lib/core/config/flavor_values.dart`
Her flavor için özel konfigürasyon değerleri:
- Base URL
- Timeout değerleri
- Analytics/Crashlytics ayarları

### 3. `lib/core/config/flavor_config.dart`
Singleton flavor yönetimi:
- FlavorConfig.initialize()
- FlavorConfig.instance
- Flavor-specific değerlere erişim

## 🚀 Kullanım

### Farklı Flavor'larla Çalıştırma

```bash
# Development (default)
flutter run

# Staging
flutter run --dart-define=FLAVOR=staging

# Production
flutter run --dart-define=FLAVOR=production
```

### Build Alma

```bash
# Development APK
flutter build apk --dart-define=FLAVOR=development

# Staging APK
flutter build apk --dart-define=FLAVOR=staging

# Production APK (release)
flutter build apk --release --dart-define=FLAVOR=production
```

### iOS Build

```bash
# Development
flutter build ios --dart-define=FLAVOR=development

# Production
flutter build ios --release --dart-define=FLAVOR=production
```

## 💡 Kodda Kullanım

### Flavor'a göre değer okuma

```dart
// Mevcut flavor'ı al
final flavor = FlavorConfig.instance.flavor;

// Flavor kontrolü
if (flavor.isProduction) {
  // Production-specific kod
}

if (flavor.isDebug) {
  // Debug-specific kod
}

// Flavor değerlerine erişim
final baseUrl = FlavorConfig.instance.flavorValues.baseUrl;
final analyticsEnabled = FlavorConfig.instance.flavorValues.analyticsEnabled;
```

### EnvConfig ile Entegrasyon

```dart
// EnvConfig otomatik olarak FlavorConfig'den değerleri alır
final apiUrl = EnvConfig.apiBaseUrl;
final timeout = EnvConfig.apiTimeout;
final isDebug = EnvConfig.isDebugMode;
```

## ⚙️ Özelleştirme

### Yeni Değer Eklemek

`lib/core/config/flavor_values.dart` dosyasına yeni field ekle:

```dart
final class FlavorValues {
  final String baseUrl;
  final String apiKey; // Yeni field
  
  const FlavorValues({
    required this.baseUrl,
    required this.apiKey,
  });

  static const development = FlavorValues(
    baseUrl: 'https://dev-api.example.com',
    apiKey: 'dev-key-123',
  );
  
  static const production = FlavorValues(
    baseUrl: 'https://api.example.com',
    apiKey: 'prod-key-xyz',
  );
}
```

### VS Code Launch Configuration

`.vscode/launch.json` dosyası oluştur:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Development",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define=FLAVOR=development"]
    },
    {
      "name": "Staging",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define=FLAVOR=staging"]
    },
    {
      "name": "Production",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define=FLAVOR=production"]
    }
  ]
}
```

## 🎯 Avantajlar

1. ✅ **Tek Codebase**: Aynı kod farklı ortamlar için
2. ✅ **Type-Safe**: Compile-time kontroller
3. ✅ **Kolay Geçiş**: Tek parametre ile ortam değiştir
4. ✅ **Güvenlik**: Production API keys development'ta kullanılmaz
5. ✅ **Debug Friendly**: Development'ta extra özellikler
6. ✅ **CI/CD Ready**: Otomasyonla entegre

## 📝 Notlar

- `.env` dosyaları hala kullanılabilir (opsiyonel)
- Flavor önceliklidir, sonra .env değerleri
- App title flavor'a göre değişir ([DEV], [STG])
- Debug banner sadece development'ta görünür
