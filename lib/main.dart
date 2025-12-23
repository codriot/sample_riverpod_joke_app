import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/dependency_injection.dart';
import 'core/config/env_config.dart';
import 'core/config/flavor_config.dart';
import 'core/models/flavor.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_logger.dart';
import 'presentation/routes/app_router.dart';

/// Clean Architecture ile GetIt + Riverpod kullanan Espri Uygulaması
///
/// Mimari Katmanlar:
/// 1. Domain Layer (lib/domain/) - İş mantığı ve entity'ler
/// 2. Data Layer (lib/data/) - Veri kaynakları ve repository implementasyonları
/// 3. Presentation Layer (lib/presentation/) - UI ve state management
///
/// Dependency Injection: GetIt (Service Locator Pattern)
/// State Management: Riverpod (Provider Pattern)
/// Routing: GoRouter
/// Error Handling: Either Pattern (dartz)
/// Code Generation: Freezed + JSON Serializable
/// Logging: Logger
/// Environment: flutter_dotenv + Flavor Config
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Flavor'ı belirle (--dart-define=FLAVOR=production ile override edilebilir)
  const flavorString = String.fromEnvironment('FLAVOR', defaultValue: 'development');
  final Flavor flavor = Flavor.values.firstWhere(
    (f) => f.name.toLowerCase() == flavorString.toLowerCase(),
    orElse: () => Flavor.development,
  );

  // Flavor'ı initialize et
  FlavorConfig.initialize(flavor);
  logger.i('🎯 Flavor initialized: ${flavor.name}');

  // Environment variables'ı yükle (opsiyonel - flavor ile birlikte kullanılabilir)
  try {
    String envFile = '.env';
    if (flavor == Flavor.production) {
      envFile = '.env.production';
    } else if (flavor == Flavor.staging) {
      envFile = '.env.staging';
    }
    await dotenv.load(fileName: envFile);
    logger.i('Environment file loaded: $envFile');
  } catch (e) {
    logger.w('Could not load .env file, using flavor defaults: $e');
  }

  // Config bilgilerini logla
  EnvConfig.logConfig();

  // GetIt ile dependency injection setup
  setupDependencyInjection();
  logger.i('Dependency injection configured');

  runApp(
    // ProviderScope: Riverpod'un tüm provider'larını uygulamaya sağlar
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final flavor = FlavorConfig.instance.flavor;

    return MaterialApp.router(
      title: flavor.appTitle,
      debugShowCheckedModeBanner: flavor.isDebug,

      // Theme - Merkezi theme yönetimi
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Sistem ayarlarına göre
      // Routing - GoRouter yapılandırması
      routerConfig: goRouter,
    );
  }
}
