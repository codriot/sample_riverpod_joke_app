/// Widget test example for JokeCard
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample/domain/entities/joke.dart';
import 'package:sample/presentation/widgets/joke_card.dart';

void main() {
  group('JokeCard Widget', () {
    const testJoke = Joke(
      id: 1,
      setup: 'Why did the chicken cross the road?',
      punchline: 'To get to the other side!',
      category: 'general',
    );

    testWidgets('should display joke setup', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: JokeCard(joke: testJoke)),
        ),
      );

      expect(find.text(testJoke.setup), findsOneWidget);
    });

    testWidgets('should show punchline when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: JokeCard(joke: testJoke)),
        ),
      );

      // Initially, punchline should not be visible
      expect(find.text(testJoke.punchline), findsNothing);

      // Tap the card
      await tester.tap(find.byType(Card));
      await tester.pumpAndSettle();

      // Now punchline should be visible
      expect(find.text(testJoke.punchline), findsOneWidget);
    });

    testWidgets('should display category', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: JokeCard(joke: testJoke)),
        ),
      );

      expect(find.text(testJoke.category), findsOneWidget);
    });
  });
}
