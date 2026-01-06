# Patrol Test Kılavuzu

Bu proje Patrol framework'ünü kullanarak integration testler içermektedir.

## Kurulum

1. Bağımlılıkları yükleyin:
```bash
flutter pub get
```

2. Patrol CLI'yı global olarak yükleyin (opsiyonel ama önerilir):
```bash
dart pub global activate patrol_cli
```

## Testleri Çalıştırma

### Yöntem 1: Patrol CLI ile (Önerilen)

```bash
# Android'de çalıştır
patrol test -t integration_test/app_test.dart

# iOS'ta çalıştır
patrol test -t integration_test/app_test.dart --device ios

# Belirli bir cihazda çalıştır
patrol test -t integration_test/app_test.dart --device <device-id>
```

### Yöntem 2: Flutter ile

```bash
# Android
flutter test integration_test/app_test.dart

# iOS
flutter test integration_test/app_test.dart --device <ios-device-id>
```

### Yöntem 3: VS Code / Android Studio

IDE'nizin test runner'ını kullanarak `integration_test/app_test.dart` dosyasını açın ve test butonlarına tıklayın.

## Patrol Özellikleri

### 1. Temel Finder'lar
```dart
// Text bulma
$(#myText).tap()

// Icon bulma
$(Icons.add).tap()

// Type'a göre bulma
$(FloatingActionButton).tap()

// Key ile bulma
$(Key('myButton')).tap()

// Index ile bulma
$(#myWidget).at(0).tap()
```

### 2. İşlemler
```dart
// Tap
await $(#button).tap()

// Enter text
await $(TextField).enterText('Hello')

// Scroll
await $(ListView).scroll(dy: -200)

// Drag
await $(#widget).drag(Offset(100, 0))

// Wait until visible
await $.waitUntilVisible($(#widget))

// Wait until exists
await $.waitUntilExists($(#widget))
```

### 3. Native İşlemler
```dart
// Permission handling
await $.native.grantPermissionWhenInUse()
await $.native.grantPermissionOnlyThisTime()
await $.native.denyPermission()

// Navigation
await $.native.pressHome()
await $.native.pressBack()
await $.native.openApp()

// Notifications
await $.native.openNotifications()
await $.native.closeNotifications()
await $.native.tapOnNotificationBySelector(Selector(text: 'My Notification'))

// System UI
await $.native.openQuickSettings()
await $.native.closeQuickSettings()

// Dialer
await $.native.openUrl('tel:123456789')
```

### 4. Doğrulamalar
```dart
// Widget var mı?
expect($(#myWidget), findsOneWidget)
expect($(#myWidget), findsNothing)
expect($(#myWidget), findsAtLeastNWidgets(2))

// Text doğrulama
expect($(#myText).text, 'Expected Text')

// Visibility kontrolü
expect($(#myWidget).visible, isTrue)
```

## Native Setup (İsteğe Bağlı)

Native özellikleri kullanmak için (permission handling, native dialogs, vs.):

### Android
```bash
patrol build android
```

### iOS
```bash
patrol build ios
```

Bu komutlar native setup'ı otomatik yapacaktır.

## Best Practices

1. **Test İzolasyonu**: Her test birbirinden bağımsız olmalı
2. **Açıklayıcı İsimler**: Test isimlerini açık ve anlaşılır yazın
3. **Setup/Teardown**: Gerekirse `setUp()` ve `tearDown()` kullanın
4. **Bekleme**: Widget'ların görünmesini bekleyin (`waitUntilVisible`)
5. **Native Testler**: Native özellikler için gerçek cihaz kullanın (emulator sınırlıdır)

## Hata Ayıklama

```bash
# Verbose mod
patrol test -t integration_test/app_test.dart --verbose

# Sadece belirli bir testi çalıştır
patrol test -t integration_test/app_test.dart --name "Uygulama açılışı"

# Video kaydı
patrol test -t integration_test/app_test.dart --record
```

## Daha Fazla Bilgi

- [Patrol Documentation](https://patrol.leancode.co/)
- [Patrol GitHub](https://github.com/leancodepl/patrol)
- [Patrol Examples](https://github.com/leancodepl/patrol/tree/master/packages/patrol/example)
