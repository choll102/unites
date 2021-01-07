import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/favorites.dart';
import 'screen/favorites.dart';
import 'screen/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Favorites(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Container(),
        routes: {
          HomePage.routeName: (_) => HomePage(),
          FavoritesPage.routeName: (_) => FavoritesPage(),
        },
        initialRoute: HomePage.routeName,
      ),
    );
  }
}
