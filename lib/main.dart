import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/screens/jokes_screen.dart';

/// Clean Architecture ile Riverpod kullanan Espri Uygulaması
///
/// Mimari Katmanlar:
/// 1. Domain Layer (lib/domain/) - İş mantığı ve entity'ler
/// 2. Data Layer (lib/data/) - Veri kaynakları ve repository implementasyonları
/// 3. Presentation Layer (lib/presentation/) - UI ve state management
void main() {
  runApp(
    // ProviderScope: Riverpod'un tüm provider'larını uygulamaya sağlar
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Espri Uygulaması - Clean Architecture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.light),
        useMaterial3: true,
        cardTheme: const CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
      ),
      home: const JokesScreen(),
    );
  }
}
