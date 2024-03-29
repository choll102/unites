import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screen/favorites.dart';

Favorites favoritesList;

Widget createFavoritesScreen() => ChangeNotifierProvider(
      create: (_) {
        favoritesList = Favorites();
        return favoritesList;
      },
      child: MaterialApp(home: FavoritesPage()),
    );

void addItems() {
  for (int i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

void main() {
  group('favorites widget', () {
    testWidgets('Test if listview shows up', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());

      addItems();

      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Testing remove button', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());

      addItems();

      await tester.pumpAndSettle();

      var totalItems = tester.widgetList(find.byIcon(Icons.close)).length;

      await tester.tap(find.byIcon(Icons.close).first);

      await tester.pumpAndSettle();

      expect(tester.widgetList(find.byIcon(Icons.close)).length, lessThan(totalItems));

      expect(find.text('Removed from favorites.'), findsOneWidget);
    });
  });
}
