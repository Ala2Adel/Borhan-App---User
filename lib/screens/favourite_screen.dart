import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifiers/activity_notifier.dart';
import 'normal_donation.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: new AppBar(
        elevation: 0.3,
        centerTitle: true,

        title: const Text('المفضلة'),
      ),
      body: FutureBuilder(
        future: Provider.of<ActivityNotifier>(context, listen: false)
            .fetchAndSetFavorites(),
        builder: (context, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Consumer<ActivityNotifier>(
          child: Center(
            child: const Text('لا يوجد أنشطة في المفضلة'),
          ),
          builder: (ctx, favourites, ch) =>
          favourites.favorites.length <= 0
              ? ch
              : ListView.builder(
            itemCount: favourites.favorites.length,
            itemBuilder: (ctx, i) {


              return ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Card(
                  margin: const  EdgeInsets.all(10),
                  color: Colors.grey[400],
                  child: new ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: new Column(
                      children: <Widget>[
                        new Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.end,
                          children: <Widget>[
                            new Container(
                              height: 120.0,
                              width: 120.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.lightBlueAccent,
                                boxShadow: [
                                  new BoxShadow(
                                      color: Colors.blueGrey
                                          .withAlpha(70),
                                      offset: const Offset(
                                          2.0, 2.0),
                                      blurRadius: 2.0)
                                ],
                                image: new DecorationImage(
                                  image: NetworkImage(favourites
                                      .favorites[
                                  i]
                                      .image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            new SizedBox(
                              width: 10.0,
                            ),
                            new Expanded(
                                child: new Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: <Widget>[
                                        new Text(
                                          favourites
                                              .favorites[
                                          i]
                                              .name,
                                          style: new TextStyle(
                                              fontSize: 22.0,
                                              color: Colors.white,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    new Text(
                                      favourites
                                          .favorites[i]
                                          .description,
                                      style: new TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                          fontWeight:
                                          FontWeight.normal),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: <Widget>[
                                        RaisedButton(
                                            color:
                                            Colors.greenAccent,
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius
                                                  .circular(
                                                  18.0),
                                              side: BorderSide(
                                                  color:
                                                  Colors.black),
                                            ),
                                            onPressed: () {
                                              favourites
                                                  .currentActivity =
                                              favourites
                                                  .activityList[
                                              i];

                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (BuildContext
                                                      context) {
                                                        return NormalDenotationScreen();
                                                      }));
                                            },
                                            child: const Text(
                                              'تبرع الآن',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color:
                                                  Colors.black),
                                            )),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );

            }
          ),
        ),

      ),
    );

  }
}

