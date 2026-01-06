import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../domain/entities/joke.dart';

/// Tek bir espriyi gösteren card widget'ı
class JokeCard extends StatefulWidget {
  final Joke joke;

  const JokeCard({super.key, required this.joke});

  @override
  State<JokeCard> createState() => _JokeCardState();
}

class _JokeCardState extends State<JokeCard> {
  bool _showPunchline = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          setState(() {
            _showPunchline = !_showPunchline;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kategori etiketi
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.joke.category.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(_showPunchline ? Icons.visibility : Icons.visibility_off, size: 16, color: Colors.grey),
                ],
              ),

              const SizedBox(height: 12),

              // Espri sorusu
              Text(widget.joke.setup, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.4)),

              // Punchline (cevap)
              AnimatedCrossFade(
                firstChild: const SizedBox(height: 12),
                secondChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 8),
                    Text(
                      widget.joke.punchline,
                      style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).colorScheme.primary,
                        height: 1.4,
                      ),
                    ).animate().slideY(duration: 300.ms),
                  ],
                ),
                crossFadeState: _showPunchline ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),

              // Tıklama için ipucu
              if (!_showPunchline) ...[
                const SizedBox(height: 8),
                Center(
                  child: Text('👆 Cevabı görmek için tıkla', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
