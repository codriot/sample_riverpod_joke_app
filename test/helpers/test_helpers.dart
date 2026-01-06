/// Test Helper Utilities
/// Mock data ve test helper fonksiyonları
import '../../lib/domain/entities/joke.dart';

/// Mock joke data for testing
class MockJokeData {
  static const mockJoke1 = Joke(
    id: 1,
    setup: 'Why did the chicken cross the road?',
    punchline: 'To get to the other side!',
    category: 'general',
  );

  static const mockJoke2 = Joke(
    id: 2,
    setup: 'What do you call a fake noodle?',
    punchline: 'An impasta!',
    category: 'programming',
  );

  static const mockJoke3 = Joke(
    id: 3,
    setup: 'Why do programmers prefer dark mode?',
    punchline: 'Because light attracts bugs!',
    category: 'programming',
  );

  static List<Joke> get mockJokesList => [mockJoke1, mockJoke2, mockJoke3];

  static List<String> get mockCategories => ['general', 'programming'];
}
