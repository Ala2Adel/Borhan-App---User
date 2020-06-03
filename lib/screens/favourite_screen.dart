import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/activity_notifier.dart';


class Favourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites screen'),
      ),
      body: Consumer<ActivityNotifier>(
        child: Center(
          child: const Text('Got no favorites yet'),
        ),
        builder: (ctx, favorites, ch) =>
            favorites.favorites.length <= 0 ? ch :
            ListView.builder(
              itemCount: favorites.favorites.length,
              itemBuilder: (ctx, i) => ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                  NetworkImage(favorites.favorites[i].image) ,),
              ),),
      ),
    );
  }
}
