import 'package:Borhan_User/notifiers/activity_notifier.dart';
import 'package:Borhan_User/notifiers/organization_notifier.dart';
import 'package:Borhan_User/screens/Donation_mainScreen.dart';
import 'package:Borhan_User/screens/favourite_screen.dart';
import 'package:Borhan_User/screens/navigation_drawer.dart';
import 'package:Borhan_User/screens/normal_donation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Donation.dart';

class OrganizationActivity extends StatefulWidget {
  var id;
  OrganizationActivity(this.id);
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<OrganizationActivity> {
  var _isLoading = false;
  var _isInit = true;
  Color _favIconColor = Colors.grey;

  @override
  void didChangeDependencies() {
    print("Org Screen" + widget.id);
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ActivityNotifier>(context)
          .fetchAndSetActivities(widget.id)
          .then((_) {
        setState(() {
          _isLoading = false;
          print('in screen activity view');
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveFavorite(){
    String pickedTitle = 'sss';
    String pickedDescription = 'fhsl';
    String pickedImage='hjh';
    Provider.of<ActivityNotifier>(context, listen:false).addFavorite(pickedTitle, pickedDescription, pickedImage);
   // Navigator.of(context).push(route)


    Navigator.of(context).push(
        MaterialPageRoute(
            builder:
                (BuildContext
            context) {
              return Favourite();
            }));
  }


  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final activityNotifier = Provider.of<ActivityNotifier>(context);

    final body = new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'الانشطة',
          style: new TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(58, 198, 198, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : new Container(
              child: new Stack(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.only(top: 10.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: ListView.builder(
                            itemCount: activityNotifier.activityList.length,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Card(
                                  margin: EdgeInsets.all(10),
                                  color: Colors.purple[400],
                                  child: new ListTile(
                                    contentPadding: EdgeInsets.all(8.0),
                                    title: new Column(
                                      children: <Widget>[
                                        new Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                  image: activityNotifier
                                                                  .activityList[
                                                                      index]
                                                                  .image !=
                                                              null &&
                                                          activityNotifier
                                                                  .activityList[
                                                                      index]
                                                                  .image !=
                                                              ""
                                                      ? new NetworkImage(
                                                          activityNotifier
                                                              .activityList[
                                                                  index]
                                                              .image)
                                                      : NetworkImage(
                                                          'https://img2.arabpng.com/20171128/5d2/gold-soccer-ball-png-clip-art-image-5a1d466b159ac0.0656563615118680110885.jpg'),
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
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    new Text(
                                                      activityNotifier
                                                                  .activityList[
                                                                      index]
                                                                  .name !=
                                                              null
                                                          ? activityNotifier
                                                              .activityList[
                                                                  index]
                                                              .name
                                                          : 'no value',
                                                      style: new TextStyle(
                                                          fontSize: 22.0,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Expanded(
                                                      child:
                                                            _buildRow(
                                                                activityNotifier
                                                                    .activityList[
                                                                        index]
                                                                    .name)

//                                                          IconButton(
//                                                        icon: Icon(
//                                                            Icons.favorite),
//                                                        color: _favIconColor,
//                                                        iconSize: 35.0,
//                                                        onPressed: () {
//                                                          setState(() {
//                                                            if (_favIconColor ==
//                                                                Colors.grey) {
//                                                              _favIconColor =
//                                                                  Colors.red;
//                                                            } else {
//                                                              _favIconColor =
//                                                                  Colors.grey;
//                                                            }
//                                                          });
//                                                        },
//                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                new Text(
                                                  activityNotifier
                                                      .activityList[index]
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
                                                          activityNotifier
                                                                  .currentActivity =
                                                              activityNotifier
                                                                      .activityList[
                                                                  index];

                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                            return NormalDenotationScreen();
                                                          }));
                                                        },
                                                        child: Text(
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
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );

    return new Container(
      decoration: new BoxDecoration(
        color: const Color(0xFF273A48),
      ),
      child: new Stack(
        children: <Widget>[
          new CustomPaint(
            size: new Size(_width, _height),
            //   painter: new Background(),
          ),
          body,
        ],
      ),
    );
  }

  final Set<String> _saved = Set<String>();
  Widget _buildRow(String pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      trailing: Icon(
        // Add the lines from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.pink : Colors.white,
        size: 35.0,
      ),
      onTap: () {
        setState(() {
          print(_saved);
          if (alreadySaved) {

            _saved.remove(pair);

            //_decrementCounter();
          } else {
            _saved.add(pair);
            _saveFavorite;

            //_incrementCounter();
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Favourite(fav: _saved)));
  }

//  void _pushSaved() {
//    Navigator.of(context).push(
//      MaterialPageRoute<void>(
//        builder:
//        (BuildContext context) {
//          final Iterable<ListTile> tiles = _saved.map(
//            (String pair) {
//              return ListTile(
//                title: Text(
//                  pair.toString(),
//                  style: new TextStyle(
//                    fontSize: 21.0,
//                    color: Colors.blueGrey,
//                    fontFamily: 'Arvo',
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
//              );
//            },
//          );
//          final List<Widget> divided = ListTile.divideTiles(
//            context: context,
//            tiles: tiles,
//          ).toList();
//
//          return Scaffold(
//            backgroundColor: Colors.black12,
//            appBar: new AppBar(
//              elevation: 0.3,
//              centerTitle: true,
//              backgroundColor: Colors.blueGrey,
//              title: new Text('Saved Suggestions'),
//            ),
//            body: ListView(children: divided),
//
//            //  new Favourite(ListView(children: divided));
//          );
//        },
//        //    Favourite( ListView (children: divided));
//      ),
//    );
//  }
}

