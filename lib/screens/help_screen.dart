import 'package:Borhan_User/models/user_nav.dart';

import 'package:Borhan_User/providers/shard_pref.dart';
import 'package:Borhan_User/screens/Help_organizations.dart';
import 'package:Borhan_User/screens/email_organization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class HelpScreen extends StatefulWidget {
  static const routeName = '/help';

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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
                    }),
                CupertinoDialogAction(
                    child: const Text('نعم'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.pushNamed(context, '/Login');
                    })
              ],
            ),
    );
  }

  Future<UserNav> loadSharedPrefs() async {
    UserNav user;
    try {
      SharedPref sharedPref = SharedPref();
      user = UserNav.fromJson(await sharedPref.read("user"));
    } catch (error) {
      // do something
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المساعدة'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmailOrganization()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 8 / 9,
                  height: MediaQuery.of(context).size.height * 1/3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.green[100],
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blueGrey.withAlpha(100),
                          offset: const Offset(3.0, 10.0),
                          blurRadius: 10.0)
                    ],
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        'assets/images/email.png',
                      ),
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0))),
                          height: 35.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  child: Text('بواسطة البريد الإلكتروني',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
//              SizedBox(
//                width: MediaQuery.of(context).size.width * 8 / 9,
//                child: RaisedButton(
//                  onPressed: () {
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => EmailOrganization()));
//                  },
//                  child: const Text(
//                    'بواسطة البريد الإلكتروني',
//                    style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 18.0,
//                        fontWeight: FontWeight.bold),
//                  ),
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(30),
//                  ),
//                  padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
//                  color: Theme.of(context).primaryColor,
//                  textColor: Theme.of(context).primaryTextTheme.button.color,
//                ),
//              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
              ),
              InkWell(
                onTap: () async {
                  UserNav userLoad = await loadSharedPrefs();
                  if (userLoad == null) {
                    _showErrorDialog("برجاء تسجيل الدخول أولا");
                  } else {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return HelpOrganization();
                        }));
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 8 / 9,
                  height: MediaQuery.of(context).size.height * 1/3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.green[100],
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blueGrey.withAlpha(100),
                          offset: const Offset(3.0, 10.0),
                          blurRadius: 10.0)
                    ],
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          'assets/images/chat.png'
                      ),
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0))),
                          height: 35.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  child: Text('بواسطة محادثة',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
              ),
//              SizedBox(
//                width: MediaQuery.of(context).size.width * 8 / 9,
//                child: RaisedButton(
//                  onPressed: () async {
//                    UserNav userLoad = await loadSharedPrefs();
//                    if (userLoad == null) {
//                      _showErrorDialog("برجاء تسجيل الدخول أولا");
//                    } else {
//                      Navigator.of(context).push(
//                          MaterialPageRoute(builder: (BuildContext context) {
//                        return HelpOrganization();
//                      }));
//                    }
//                  },
//                  child: const Text(
//                    'بواسطة محادثة',
//                    style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 18.0,
//                        fontWeight: FontWeight.bold),
//                  ),
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(30),
//                  ),
//                  padding: const EdgeInsets.symmetric(
//                      horizontal: 2.0, vertical: 2.0),
//                  color: Theme.of(context).primaryColor,
//                  textColor: Theme.of(context).primaryTextTheme.button.color,
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }
}
