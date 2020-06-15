import 'package:Borhan_User/models/activity.dart';
import 'package:Borhan_User/models/user_nav.dart';
import 'package:Borhan_User/providers/shard_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifiers/activity_notifier.dart';
import 'activity_detail.dart';
import 'normal_donation.dart';
import 'dart:io' show Platform;


class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
   var _isLoading = false;
  var _isInit = true;
  List<Activity> _savedFav = [];
  final Set<String> _saved = Set<String>();

  var activityNotifier;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ActivityNotifier>(context)
          .fetchAndSetFavorites()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      Provider.of<ActivityNotifier>(context)
          .fetchAndSetFavorites()
          .then((_) => {
                _savedFav = Provider.of<ActivityNotifier>(context).favorites,
                if (_savedFav.length > 0)
                  {
                    _savedFav.forEach((element) {
                      _saved.add(element.name);
                    }),
                  }
              });

      activityNotifier = Provider.of<ActivityNotifier>(context);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => (Platform.isAndroid)
          ? AlertDialog(
              title: const Text('تسجيل دخول'),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: const Text('ليس الأن'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
                FlatButton(
                  child: const Text('نعم'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.pushNamed(context, '/Login');
                  },
                ),
              ],
            )
          : CupertinoAlertDialog(
              title: const Text('تسجيل دخول'),
              content: Text(message),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text('ليس الأن'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('نعم'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.pushNamed(context, '/Login');
                  },
                )
              ],
            ),
    );
  }

  Future<UserNav> loadSharedPrefs() async {
    UserNav user;
    try {
      SharedPref sharedPref = SharedPref();
      user = UserNav.fromJson(await sharedPref.read("user"));
    } catch (Excepetion) {
      // do something
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final body = new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'المفضلة',
          style: new TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[400],
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          :activityNotifier.favorites.length==0? 
           Center(
            child: const Text('لا يوجد أنشطة في المفضلة'),
          )
          :new Container(
              child: new Stack(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: ListView.builder(
                              itemCount: activityNotifier.favorites.length,
                              itemBuilder: (context, index) {
                           return ClipRRect(
                             borderRadius: BorderRadius.circular(20),
                             child: Card(
                               margin: EdgeInsets.all(5),
                               color: Colors.grey[400],
                               child: new ListTile(
                                 contentPadding: EdgeInsets.all(8.0),
                                 title: new Column(
                                   children: <Widget>[
                                     new Row(
                                       crossAxisAlignment:
                                           CrossAxisAlignment.center,
                                       children: <Widget>[
                                         new Container(
                                           height: 110.0,
                                           width: 110.0,
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
                                                               .favorites[
                                                                   index]
                                                               .image !=
                                                           null &&
                                                       activityNotifier
                                                               .favorites[
                                                                   index]
                                                               .image !=
                                                           ""
                                                   ? new NetworkImage(
                                                       activityNotifier
                                                           .favorites[
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
                                                     MainAxisAlignment.spaceBetween,
                                                 children: <Widget>[
                                                   new Text(
                                                     activityNotifier
                                                                 .favorites[
                                                                     index]
                                                                 .name !=
                                                             null
                                                         ? activityNotifier
                                                             .favorites[
                                                                 index]
                                                             .name
                                                         : 'no value',
                                                     style: new TextStyle(
                                                         fontSize: 22.0,
                                                         color: Colors.white,
                                                         fontWeight:
                                                             FontWeight
                                                                 .bold),
                                                   ),
                                                  //  Expanded(
                                                  //      child: _buildRow(
                                                  //          activityNotifier
                                                  //                  .activityList[
                                                  //              index])),
                                                    _buildRow(
                                                        activityNotifier
                                                                .favorites[
                                                            index]),
                                                 ],
                                               ),
                                               new Text(
                                                 activityNotifier
                                                     .favorites[index]
                                                     .description,
                                                     maxLines: 1,
                                                 style: new TextStyle(
                                                     fontSize: 18.0,
                                                     // height: 0.5,
                                                     color: Colors.white,
                                                     fontWeight:
                                                         FontWeight.normal),
                                               ),
                                               Row(
                                                 mainAxisAlignment:
                                                     MainAxisAlignment.start,
                                                 children: <Widget>[
                                                   RaisedButton(
                                                     color: Colors.grey[500],
                                                     shape:
                                                         RoundedRectangleBorder(
                                                       borderRadius:
                                                           new BorderRadius
                                                                   .circular(
                                                               8.0),
                                                     ),
                                                     onPressed: () async {
                                                       activityNotifier
                                                               .currentActivity =
                                                           activityNotifier
                                                                   .favorites[
                                                               index];

                                                       UserNav userLoad =
                                                           await loadSharedPrefs();
                                                       if (userLoad ==
                                                           null) {
                                                         _showErrorDialog(
                                                             "برجاء تسجيل الدخول أولا ");
                                                       } else {
                                                         Navigator.of(
                                                                 context)
                                                             .push(
                                                           MaterialPageRoute(
                                                             builder:
                                                                 (BuildContext
                                                                     context) {
                                                               return NormalDenotationScreen();
                                                             },
                                                           ),
                                                         );
                                                       }
                                                     },
                                                     child: Text(
                                                       'تبرع',
                                                       style: TextStyle(
                                                           fontSize: 20.0,
                                                           color:
                                                               Colors.black),
                                                     ),
                                                   ),
                                                   SizedBox(
                                                     width: 10,
                                                   ),
                                                   RaisedButton(
                                                     color: Colors.grey[500],
                                                     shape:
                                                         RoundedRectangleBorder(
                                                       borderRadius:
                                                           new BorderRadius
                                                                   .circular(
                                                               8.0),
                                                     ),
                                                     onPressed: () async {
                                                       activityNotifier
                                                               .currentActivity =
                                                           activityNotifier
                                                                   .favorites[
                                                               index];
                                                       Navigator.of(context).push(
                                                           MaterialPageRoute(
                                                               builder:
                                                                   (BuildContext
                                                                       context) {
                                                         return ActivityDetails();
                                                       }));
                                                     },
                                                     child: Text(
                                                       'تفاصيل ',
                                                       style: TextStyle(
                                                           fontSize: 20.0,
                                                           color:
                                                               Colors.black),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ],
                                           ),
                                         ),
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
          ),
          body,
        ],
      ),
    );
  }

  Widget _buildRow(Activity activity) {
    bool alreadySaved;

    alreadySaved = _saved.contains(activity.name);

     return InkWell(
      child: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.pink : Colors.white,
        size: 35.0,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(activity.name);
            Provider.of<ActivityNotifier>(context).deleteFavorite(activity);
          } else {
            _saved.add(activity.name);
            Provider.of<ActivityNotifier>(context).addFavorite(activity.name,
                activity.description, activity.image, activity.id);
          }
        });
      },
    );

  }
}



// class Favourite extends StatefulWidget {
//   @override
//   _FavouriteState createState() => _FavouriteState();
// }

// class _FavouriteState extends State<Favourite> {


//   var _isInit = true;
//   var activityNotifier;

//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//         activityNotifier = Provider.of<ActivityNotifier>(context);
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       appBar: new AppBar(
//         elevation: 0.3,
//         centerTitle: true,

//         title: const Text('المفضلة'),
//       ),
//       body: FutureBuilder(
//         future: Provider.of<ActivityNotifier>(context, listen: false)
//             .fetchAndSetFavorites(),
//         builder: (context, snapshot) =>
//         snapshot.connectionState == ConnectionState.waiting
//             ? Center(
//           child: CircularProgressIndicator(),
//         )
//             : Consumer<ActivityNotifier>(
//           child: Center(
//             child: const Text('لا يوجد أنشطة في المفضلة'),
//           ),
//           builder: (ctx, favourites, ch) =>
//           favourites.favorites.length <= 0
//               ? ch
//               : ListView.builder(
//             itemCount: favourites.favorites.length,
//             itemBuilder: (ctx, i) {
//               return ClipRRect(
//                 borderRadius: BorderRadius.circular(40),
//                 child: Card(
//                   margin: const  EdgeInsets.all(10),
//                   color: Colors.grey[400],
//                   child: new ListTile(
//                     contentPadding: EdgeInsets.all(8.0),
//                     title: new Column(
//                       children: <Widget>[
//                         new Row(
//                           crossAxisAlignment:
//                           CrossAxisAlignment.end,
//                           children: <Widget>[
//                             new Container(
//                               height: 120.0,
//                               width: 120.0,
//                               decoration: new BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.lightBlueAccent,
//                                 boxShadow: [
//                                   new BoxShadow(
//                                       color: Colors.blueGrey
//                                           .withAlpha(70),
//                                       offset: const Offset(
//                                           2.0, 2.0),
//                                       blurRadius: 2.0)
//                                 ],
//                                 image: new DecorationImage(
//                                   image: NetworkImage(favourites
//                                       .favorites[
//                                   i]
//                                       .image),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             new SizedBox(
//                               width: 10.0,
//                             ),
//                             new Expanded(
//                                 child: new Column(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.start,
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       children: <Widget>[
//                                         new Text(
//                                           favourites
//                                               .favorites[
//                                           i]
//                                               .name,
//                                           style: new TextStyle(
//                                               fontSize: 22.0,
//                                               color: Colors.white,
//                                               fontWeight:
//                                               FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                     new Text(
//                                       favourites
//                                           .favorites[i]
//                                           .description,
//                                       style: new TextStyle(
//                                           fontSize: 18.0,
//                                           color: Colors.white,
//                                           fontWeight:
//                                           FontWeight.normal),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       children: <Widget>[
//                                         RaisedButton(
//                                             color:
//                                             Colors.greenAccent,
//                                             shape:
//                                             RoundedRectangleBorder(
//                                               borderRadius:
//                                               new BorderRadius
//                                                   .circular(
//                                                   18.0),
//                                               side: BorderSide(
//                                                   color:
//                                                   Colors.black),
//                                             ),
//                                             onPressed: () {
//                                              activityNotifier
//                                                   .currentActivity =
//                                               favourites
//                                                   .activityList[
//                                               i];

//                                               Navigator.of(context).push(
//                                                   MaterialPageRoute(
//                                                       builder:
//                                                           (BuildContext
//                                                       context) {
//                                                         return NormalDenotationScreen();
//                                                       }));
//                                             },
//                                             child: const Text(
//                                               'تبرع الآن',
//                                               style: TextStyle(
//                                                   fontSize: 20.0,
//                                                   color:
//                                                   Colors.black),
//                                             )),
//                                       ],
//                                     ),
//                                   ],
//                                 )),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );

//             }
//           ),
//         ),

//       ),
//     );

//   }
// }

