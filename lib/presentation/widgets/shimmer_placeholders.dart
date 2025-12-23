import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Espri kartı için shimmer placeholder
class JokeCardShimmer extends StatelessWidget {
  const JokeCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme'den shimmer renkleri al
    final baseColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlightColor = Theme.of(context).colorScheme.surface;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kategori placeholder
            Row(
              children: [
                Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    width: 80,
                    height: 20,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const Spacer(),
                Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Icon(Icons.visibility_off, size: 16, color: highlightColor),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Setup placeholder (3 satır)
            Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(4)),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 16,
                    decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(4)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // İpucu placeholder
            Center(
              child: Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: Container(
                  width: 180,
                  height: 12,
                  decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Kategori chip'leri için shimmer placeholder
class CategoryChipShimmer extends StatelessWidget {
  const CategoryChipShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme'den shimmer renkleri al
    final baseColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlightColor = Theme.of(context).colorScheme.surface;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                width: 80 + (index * 10.0),
                height: 32,
                decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(20)),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Espri listesi için shimmer placeholder
class JokesListShimmer extends StatelessWidget {
  const JokesListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return const JokeCardShimmer();
      },
    );
  }
}
