import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screen/favorites.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Sample'),
        actions: [
          FlatButton.icon(
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, FavoritesPage.routeName);
            },
            icon: Icon(Icons.favorite_border),
            label: Text('Favorites'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 100,  /// support lake
        cacheExtent: 20,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => ItemTile(index),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final int itemNo;

  const ItemTile(this.itemNo);

  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<Favorites>(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
        ),
        title: Text('Colors $itemNo', key: Key('text_$itemNo')),
        trailing: IconButton(
          key: Key('icon_$itemNo'),
          icon: favoritesList.items.contains(itemNo) ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          onPressed: () {
            !favoritesList.items.contains(itemNo) ? favoritesList.add(itemNo) : favoritesList.remove(itemNo);

            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(favoritesList.items.contains(itemNo) ? 'Added to favorites.' : 'Removed from favorites.'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
