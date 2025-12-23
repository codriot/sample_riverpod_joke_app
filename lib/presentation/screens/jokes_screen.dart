import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import '../../core/errors/failures.dart';
import '../providers/joke_providers.dart';
import '../widgets/joke_card.dart';
import '../widgets/shimmer_placeholders.dart';

/// Ana ekran - Esprileri listeler
/// Either pattern ile error handling yapılıyor
class JokesScreen extends ConsumerStatefulWidget {
  const JokesScreen({super.key});

  @override
  ConsumerState<JokesScreen> createState() => _JokesScreenState();
}

class _JokesScreenState extends ConsumerState<JokesScreen> {
  Future<void> _handleRefresh() async {
    ref.invalidate(filteredJokesProvider);
    ref.invalidate(categoriesProvider);
    await ref.read(filteredJokesProvider.future);
  }

  /// Failure mesajını kullanıcı dostu hale getir
  String _getErrorMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'İnternet bağlantınızı kontrol edin';
    } else if (failure is TimeoutFailure) {
      return 'İstek zaman aşımına uğradı';
    } else if (failure is ServerFailure) {
      return 'Sunucu hatası: ${failure.message}';
    } else {
      return failure.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Kategorileri ve filtrelenmiş esprileri dinle
    final categoriesAsync = ref.watch(categoriesProvider);
    final jokesAsync = ref.watch(filteredJokesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎭 Espri Uygulaması'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Kategori filtreleme alanı
          categoriesAsync.when(
            data: (either) {
              return either.fold(
                // Left: Hata durumu
                (failure) => const SizedBox.shrink(),
                // Right: Başarılı veri
                (categories) {
                  final allCategories = ['Tümü', ...categories];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: allCategories.length,
                      itemBuilder: (context, index) {
                        final category = allCategories[index];
                        final isSelected = selectedCategory == null ? category == 'Tümü' : selectedCategory == category;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (category == 'Tümü') {
                                ref.read(selectedCategoryProvider.notifier).state = null;
                              } else {
                                ref.read(selectedCategoryProvider.notifier).state = category;
                              }
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
            loading: () => const CategoryChipShimmer(),
            error: (error, stack) => const SizedBox.shrink(),
          ),

          const Divider(height: 1),

          // Espri listesi
          Expanded(
            child: jokesAsync.when(
              // Veri yüklendiğinde - Either pattern handle et
              data: (either) {
                return either.fold(
                  // Left: Hata durumu
                  (failure) {
                    final errorMessage = _getErrorMessage(failure);
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 64, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            errorMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red, fontSize: 16),
                          ),
                          if (failure.statusCode != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Hata Kodu: ${failure.statusCode}',
                              style: TextStyle(color: Colors.red.withOpacity(0.7), fontSize: 14),
                            ),
                          ],
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              ref.invalidate(filteredJokesProvider);
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Tekrar Dene'),
                          ),
                        ],
                      ),
                    );
                  },
                  // Right: Başarılı veri
                  (jokes) {
                    if (jokes.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.sentiment_dissatisfied, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('Bu kategoride espri bulunamadı', style: TextStyle(fontSize: 16, color: Colors.grey)),
                          ],
                        ),
                      );
                    }

                    // CustomMaterialIndicator ile Lottie animasyonu
                    return CustomMaterialIndicator(
                      onRefresh: _handleRefresh,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      indicatorBuilder: (context, controller) {
                        return Lottie.asset(
                          'assets/lottie/Loading animation blue.json',
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                        );
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: jokes.length,
                        itemBuilder: (context, index) {
                          return JokeCard(joke: jokes[index]);
                        },
                      ),
                    );
                  },
                );
              },
              // Yüklenirken - Shimmer placeholder
              loading: () => const JokesListShimmer(),
              // Riverpod seviyesinde hata (nadir)
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Beklenmeyen hata: $error',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        ref.invalidate(filteredJokesProvider);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Tekrar Dene'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
