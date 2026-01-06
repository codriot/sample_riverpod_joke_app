/// Unit test example for Joke entity
import 'package:flutter_test/flutter_test.dart';
import 'package:sample/domain/entities/joke.dart';

void main() {
  group('Joke Entity', () {
    const testJoke = Joke(id: 1, setup: 'Test setup', punchline: 'Test punchline', category: 'test');

    test('should create a joke with correct properties', () {
      expect(testJoke.id, 1);
      expect(testJoke.setup, 'Test setup');
      expect(testJoke.punchline, 'Test punchline');
      expect(testJoke.category, 'test');
    });

    test('should support value equality (Equatable)', () {
      const joke1 = Joke(id: 1, setup: 'Setup', punchline: 'Punchline', category: 'general');

      const joke2 = Joke(id: 1, setup: 'Setup', punchline: 'Punchline', category: 'general');

      expect(joke1, equals(joke2));
    });

    test('should have different hash codes for different jokes', () {
      const joke1 = Joke(id: 1, setup: 'Setup 1', punchline: 'Punchline 1', category: 'general');

      const joke2 = Joke(id: 2, setup: 'Setup 2', punchline: 'Punchline 2', category: 'general');

      expect(joke1.hashCode, isNot(equals(joke2.hashCode)));
    });

    test('should generate correct string representation', () {
      final string = testJoke.toString();
      expect(string, contains('id'));
      expect(string, contains('setup'));
      expect(string, contains('punchline'));
      expect(string, contains('category'));
    });
  });
}
