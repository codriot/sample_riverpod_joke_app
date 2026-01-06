import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_routes.dart';
import '../screens/splash_screen.dart';
import '../screens/jokes_screen.dart';
import '../widgets/debug_overlay.dart';

/// GoRouter yapılandırması
/// Tüm route'ları ve navigasyon kurallarını tanımlar
final goRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    // ShellRoute ile tüm sayfaları DebugOverlay ile wrap ediyoruz
    ShellRoute(
      builder: (context, state, child) => DebugOverlay(child: child),
      routes: [
        // Splash Screen - Ana sayfa
        GoRoute(path: AppRoutes.splash, name: AppRoutes.splashName, builder: (context, state) => const SplashScreen()),

        // Jokes Screen - Ana uygulama ekranı
        GoRoute(path: AppRoutes.jokes, name: AppRoutes.jokesName, builder: (context, state) => const JokesScreen()),
      ],
    ),
  ],

  // Hata sayfası
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text('Sayfa bulunamadı: ${state.uri}', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () => context.go(AppRoutes.splash), child: const Text('Ana Sayfaya Dön')),
        ],
      ),
    ),
  ),
);
