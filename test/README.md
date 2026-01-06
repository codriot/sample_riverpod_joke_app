# Test Klasör Yapısı

Bu dizin projenin test yapısını içerir.

## Klasör Yapısı

### 📁 unit/
Unit testler - İzole edilmiş fonksiyon/class testleri
- Entities
- Use cases
- Repository implementations
- Utilities

### 📁 widget/
Widget testler - UI component testleri
- Widgets
- Screens (UI testleri)

### 📁 integration/
Integration testler - Uçtan uca testler
- Full flow tests
- API integration tests

### 📁 fixtures/
Test için kullanılacak mock data dosyaları
- JSON fixtures
- Mock data files

### 📁 mocks/
Mock classes ve test doubles
- Mock repositories
- Mock data sources
- Mock services

### 📁 helpers/
Test helper fonksiyonları ve utilities
- Common test utilities
- Test data generators

## Test Çalıştırma

```bash
# Tüm testleri çalıştır
flutter test

# Sadece unit testleri çalıştır
flutter test test/unit

# Sadece widget testleri çalıştır
flutter test test/widget

# Coverage raporu ile çalıştır
flutter test --coverage
```

## Test Yazma İlkeleri

1. **AAA Pattern**: Arrange, Act, Assert
2. **Given-When-Then**: BDD style
3. **FIRST**: Fast, Independent, Repeatable, Self-validating, Timely
4. **Mock External Dependencies**: API, Database, etc.
5. **Test Behavior, Not Implementation**

## Örnek Test Dosyaları

- `unit/joke_entity_test.dart` - Entity testi örneği
- `widget/joke_card_test.dart` - Widget testi örneği
- `helpers/test_helpers.dart` - Test helper utilities

## Coverage Hedefi

- Unit Tests: 80%+
- Widget Tests: 70%+
- Integration Tests: Key flows
