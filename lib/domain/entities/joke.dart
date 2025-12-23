import 'package:equatable/equatable.dart';

/// Domain katmanındaki Joke entity'si
/// Bu katman iş mantığını temsil eder ve framework'lerden bağımsızdır
/// Equatable ile value equality otomatik sağlanır (==, hashCode)
class Joke extends Equatable {
  final int id;
  final String setup; // Espri sorusu
  final String punchline; // Espri cevabı
  final String category; // Espri kategorisi

  const Joke({required this.id, required this.setup, required this.punchline, required this.category});

  @override
  List<Object?> get props => [id, setup, punchline, category];

  @override
  String toString() => 'Joke(id: $id, setup: $setup, punchline: $punchline, category: $category)';
}
