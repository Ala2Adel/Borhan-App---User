import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/activity_notifier.dart';


class Favourite extends StatefulWidget {
  //var fav;
   Set<String> fav = Set<String>();
  Favourite({this.fav});
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = widget.fav.map(
          (String pair) {
        return ListTile(
          title: Text(
            pair.toString(),
            style: new TextStyle(
              fontSize: 21.0,
              color: Colors.blueGrey,
              fontFamily: 'Arvo',
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: new AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: new Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),

      //  new Favourite(ListView(children: divided));
    );

  }
}

/*

        (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (String pair) {
              return ListTile(
                title: Text(
                  pair.toString(),
                  style: new TextStyle(
                    fontSize: 21.0,
                    color: Colors.blueGrey,
                    fontFamily: 'Arvo',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            backgroundColor: Colors.black12,
            appBar: new AppBar(
              elevation: 0.3,
              centerTitle: true,
              backgroundColor: Colors.blueGrey,
              title: new Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),

            //  new Favourite(ListView(children: divided));
          );
        },

 */