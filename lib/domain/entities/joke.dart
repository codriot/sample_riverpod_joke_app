/// Domain katmanındaki Joke entity'si
/// Bu katman iş mantığını temsil eder ve framework'lerden bağımsızdır
class Joke {
  final int id;
  final String setup; // Espri sorusu
  final String punchline; // Espri cevabı
  final String category; // Espri kategorisi

  const Joke({required this.id, required this.setup, required this.punchline, required this.category});

  @override
  String toString() => 'Joke(id: $id, setup: $setup, punchline: $punchline)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Joke && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
