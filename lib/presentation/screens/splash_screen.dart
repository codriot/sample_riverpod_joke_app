import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_routes.dart';
import 'dart:async';

/// Splash Screen - Uygulama açılış ekranı
/// 3 saniye animasyonlu logo gösterir sonra ana ekrana geçer
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Animasyon controller'ı oluştur
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));

    // Fade animasyonu (opacity) - Logo için
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Scale animasyonu (minik büyüme) - Daha az büyüme
    _scaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Slide animasyonu (soldan sağa) - Metin için
    _slideAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    // Animasyonu başlat
    _animationController.forward();

    // 3 saniye sonra ana ekrana geç
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(AppRoutes.jokes);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo (Emoji) - Minik scale animasyonu
                Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10)),
                        ],
                      ),
                      child: const Center(child: Text('🎭', style: TextStyle(fontSize: 64))),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Uygulama adı - Soldan sağa slide animasyonu
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: (_slideAnimation.value + 1.0).clamp(0.0, 1.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFFE0E0E0), // Açık gümüş
                            Color(0xFFFFFFFF), // Beyaz
                            Color(0xFFC0C0C0), // Gümüş
                            Color(0xFFE8E8E8), // Açık gri
                          ],
                          stops: [0.0, 0.3, 0.6, 1.0],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: const Text(
                          'Espri Uygulaması',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                            shadows: [Shadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 4)],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Alt başlık - Soldan sağa slide animasyonu (gecikmeli)
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: ((_slideAnimation.value * 0.8) + 1.0).clamp(0.0, 1.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFFD0D0D0), Color(0xFFFFFFFF), Color(0xFFB8B8B8)],
                          stops: [0.0, 0.5, 1.0],
                        ).createShader(bounds),
                        child: Text(
                          'Clean Architecture & Riverpod',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            letterSpacing: 0.8,
                            shadows: [
                              Shadow(color: Colors.black.withOpacity(0.3), offset: const Offset(1, 1), blurRadius: 2),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
