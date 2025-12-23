import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/joke_providers.dart';
import '../widgets/joke_card.dart';
import '../widgets/shimmer_placeholders.dart';

/// Ana ekran - Esprileri listeler
class JokesScreen extends ConsumerWidget {
  const JokesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Kategorileri ve filtrelenmiş esprileri dinle
    final categoriesAsync = ref.watch(categoriesProvider);
    final jokesAsync = ref.watch(filteredJokesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎭 Espri Uygulaması'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Yenile butonu
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Provider'ı yeniden tetikle
              ref.invalidate(filteredJokesProvider);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Kategori filtreleme alanı
          categoriesAsync.when(
            data: (categories) {
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
            loading: () => const CategoryChipShimmer(),
            error: (error, stack) => const SizedBox.shrink(),
          ),

          const Divider(height: 1),

          // Espri listesi
          Expanded(
            child: jokesAsync.when(
              // Veri yüklendiğinde
              data: (jokes) {
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

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: jokes.length,
                  itemBuilder: (context, index) {
                    return JokeCard(joke: jokes[index]);
                  },
                );
              },
              // Yüklenirken - Shimmer placeholder
              loading: () => const JokesListShimmer(),
              // Hata oluştuğunda
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Hata: $error',
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
