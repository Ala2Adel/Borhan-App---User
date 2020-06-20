import 'package:Borhan_User/Animation/FadeAnimation.dart';
import 'package:Borhan_User/models/user_nav.dart';
import 'package:Borhan_User/notifiers/activity_notifier.dart';
import 'package:Borhan_User/providers/shard_pref.dart';
import 'package:Borhan_User/screens/normal_donation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localizations.dart';

class ActivityDetails extends StatefulWidget {
  @override
  _ActivityDetailsState createState() => _ActivityDetailsState();
}

class _ActivityDetailsState extends State<ActivityDetails> {
  bool isFirstTime = true;
  String myTitle = "default title";
  ActivityNotifier activityNotifier;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context).translate('login_string')),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child:
                Text(AppLocalizations.of(context).translate('not_now_string')),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('yes_string')),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.pushNamed(context, '/Login');
            },
          ),
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
    if (isFirstTime) {
      activityNotifier = Provider.of<ActivityNotifier>(context, listen: false);
      isFirstTime = false;
    }
    return Scaffold(
      body: nested(),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(0),
                      topLeft: Radius.circular(20)),
                  color: Colors.deepPurple.withOpacity(0.75),
                ),
                child: Text(
                  ' الوصف',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            color: Colors.grey[600],
                            blurRadius: 2.0,
                            offset: Offset(4, 2))
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FadeAnimation(
              1.7,
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(196, 135, 198, .3),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      )
                    ],
                  ),
                  child: Text(
                    activityNotifier.currentActivity.description,
                    //'وَأَطْعِمُوا الطَّعَامَ، وَصِلُوا الْأَرْحَامَ، وَصَلُّوا بِاللَّيْلِ وَالنَّاسُ نِيَامٌ تَدْخُلُوا الْجَنَّةَ بِسَلَامٍ',
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            FadeAnimation(
              1.9,
              Builder(
                builder: (ctx) => InkWell(
                  onTap: () async {
                    UserNav userLoad = await loadSharedPrefs();
                    if (userLoad == null) {
                      _showErrorDialog(AppLocalizations.of(context)
                          .translate('Please_signin_first_string'));
                    } else {
                      print("user is  here");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return NormalDenotationScreen();
                          },
                        ),
                      );
                    }
                  }, // handle your onTap here
                  child: Center(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 2 / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromRGBO(49, 39, 79, 1),
                      ),
                      child: Center(
                        child: Text(
                          "تبرع الأن",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
          ],
        ),
      ),
    );
  }

  nested() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              backgroundColor: Colors.blue,
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 4 / 9,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    color: Colors.blue.withOpacity(0.75),
                  ),
                  child: Text(
                    activityNotifier.currentActivity.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                background: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              activityNotifier.currentActivity.image,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    //    Positioned(
                    //   child:
                    //  ),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: body(),
    );
  }
}
