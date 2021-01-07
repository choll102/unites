import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screen/home.dart';

Widget createHomeScreen() => ChangeNotifierProvider<Favorites>(
      create: (_) => Favorites(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );

void main() {
  group('Home Page Widgets Tests', () {
    testWidgets('Testing if ListView shows up', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Testing scrolling', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      expect(find.text('Colors 2'), findsOneWidget);

      await tester.fling(find.byType(ListView), Offset(0, 99), 99);

      await tester.pumpAndSettle();

      expect(find.text('Colors 100'), findsNothing); ///   throw erro support lake and yang lake
    });

    testWidgets('Testing IconButtons', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      expect(find.byIcon(Icons.favorite), findsNothing);

      await tester.tap(find.byIcon(Icons.favorite_border).first);

      await tester.pumpAndSettle(Duration(seconds: 1));

      expect(find.text('Added to favorites.'), findsOneWidget);

      expect(find.byIcon(Icons.favorite), findsWidgets);

      await tester.tap(find.byIcon(Icons.favorite).first);

      await tester.pumpAndSettle(Duration(seconds: 1));

      expect(find.text('Removed from favorites.'), findsOneWidget);

      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  });
}
