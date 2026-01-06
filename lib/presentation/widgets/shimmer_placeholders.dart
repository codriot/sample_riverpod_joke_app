import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Espri kartı için skeleton placeholder
class JokeCardShimmer extends StatelessWidget {
  const JokeCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
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
                Bone.button(width: 80, height: 20, borderRadius: BorderRadius.circular(12)),
                const Spacer(),
                Bone.icon(size: 16),
              ],
            ),

            const SizedBox(height: 12),

            // Setup placeholder (2 satır)
            Bone.multiText(lines: 2, fontSize: 16),

            const SizedBox(height: 12),

            // İpucu placeholder
            Center(child: Bone.text(width: 180, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

/// Kategori chip'leri için skeleton placeholder
class CategoryChipShimmer extends StatelessWidget {
  const CategoryChipShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Chip(label: Text('Category $index')),
            );
          },
        ),
      ),
    );
  }
}

/// Espri listesi için skeleton placeholder
class JokesListShimmer extends StatelessWidget {
  const JokesListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 6,
        itemBuilder: (context, index) {
          return const JokeCardShimmer();
        },
      ),
    );
  }
}
