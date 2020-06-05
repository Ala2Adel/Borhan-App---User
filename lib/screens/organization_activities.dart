import 'package:Borhan_User/models/activity.dart';
import 'package:Borhan_User/notifiers/activity_notifier.dart';
import 'package:Borhan_User/screens/favourite_screen.dart';
import 'package:Borhan_User/screens/normal_donation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizationActivity extends StatefulWidget {
  final id;

  OrganizationActivity(this.id);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<OrganizationActivity> {
  var _isLoading = false;
  var _isInit = true;
  List<Activity> _savedFav = [];
  final Set<String> _saved = Set<String>();

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
      Provider.of<ActivityNotifier>(context)
          .fetchAndSetFavorites()
          .then((_) => {
                _savedFav = Provider.of<ActivityNotifier>(context).favorites,
                print(_savedFav),
                print('saved'),
      if(_savedFav.length >0){
          _savedFav.forEach((element)
      {
        _saved.add(element.name);
      }),
    }
              });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

//  void _saveFavorite(){
//    String pickedTitle = 'sss';
//    String pickedDescription = 'fhsl';
//    String pickedImage='hjh';
//    Provider.of<ActivityNotifier>(context, listen:false).addFavorite(pickedTitle, pickedDescription, pickedImage);
//    // Navigator.of(context).push(route)
//
//
//    Navigator.of(context).push(
//        MaterialPageRoute(
//            builder:
//                (BuildContext
//            context) {
//              return Favourite();
//            }));
//  }

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
                                                        child: _buildRow(
                                                            activityNotifier
                                                                    .activityList[
                                                                index])
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


  Widget _buildRow(Activity activity) {
    bool alreadySaved;

//    if(_savedFav.length >0){
//      _savedFav.forEach((element) {
//        _saved.add(element.name);
//      });
//    }

    print('*********************************************************');
    print(_saved);
    print('*********************************************************');
    alreadySaved = _saved.contains(activity.name);
    print("Already Saved is " + alreadySaved.toString());

    print('pair');
    print(activity);
    return ListTile(
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.pink : Colors.white,
        size: 35.0,
      ),
      onTap: () {
        setState(() {
          print(_saved);
          if (alreadySaved) {
              _saved.remove(activity.name);
            Provider.of<ActivityNotifier>(context).deleteFavorite(activity);

          } else {
              _saved.add(activity.name);
            Provider.of<ActivityNotifier>(context).addFavorite(activity.name,
                activity.description, activity.image, activity.id);
//            _saveFavorite;

          }
        });
      },
    );
  }

//  Widget _buildRow(String pair) {
//    bool alreadySaved = false;
//
//    if(_savedFav.length >0){
//      _savedFav.forEach((element) {
//        _saved.add(element.name);
//      });
//    }
//
//    alreadySaved = _saved.contains(pair);
//
//    print('pair');
//    print(pair);
//    return ListTile(
//      trailing: Icon(
//        alreadySaved ? Icons.favorite : Icons.favorite_border,
//        color: alreadySaved ? Colors.pink : Colors.white,
//        size: 35.0,
//      ),
//      onTap: () {
//        setState(() {
//          print(_saved);
//          if (alreadySaved) {
//            _saved.remove(pair);
//            //_decrementCounter();
//          } else {
//            _saved.add(pair);
//            Provider.of<ActivityNotifier>(context).addFavorite(pair,
//                'pickedDescription', 'pickedImage');
////            _saveFavorite;
//
//            //_incrementCounter();
//          }
//        });
//      },
//    );
//  }


/*
  *
  var _saved;
    print('pair');
    if(_savedFav){
      for(int i =0;i<_savedFav.length;i++)
        {
          print(_savedFav[i].name);
          print('***********************************');
          _saved = _savedFav[i].name;
        }
    }
  * */

////////////////////////////////////////////////////
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

