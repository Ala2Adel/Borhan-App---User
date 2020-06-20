import 'package:Borhan_User/models/user_nav.dart';

import 'package:Borhan_User/providers/shard_pref.dart';
import 'package:Borhan_User/screens/Help_organizations.dart';
import 'package:Borhan_User/screens/email_organization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import '../app_localizations.dart';

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
              title:
                  Text(AppLocalizations.of(context).translate('login_string')),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                      AppLocalizations.of(context).translate('not_now_string')),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
                FlatButton(
                  child: Text(
                      AppLocalizations.of(context).translate('yes_string')),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.pushNamed(context, '/Login');
                  },
                ),
              ],
            )
          : CupertinoAlertDialog(
              title:
                  Text(AppLocalizations.of(context).translate('login_string')),
              content: Text(message),
              actions: <Widget>[
                CupertinoDialogAction(
                    child: Text(AppLocalizations.of(context)
                        .translate('not_now_string')),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    }),
                CupertinoDialogAction(
                    child: Text(
                        AppLocalizations.of(context).translate('yes_string')),
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
    } catch (Excepetion) {
      // do something
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('help')),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 250,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmailOrganization()));
                  },
                  child: Text(
                    AppLocalizations.of(context).translate('Email_Support'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryTextTheme.button.color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
              ),
              SizedBox(
                width: 250,
                child: RaisedButton(
                  onPressed: () async {
                    UserNav userLoad = await loadSharedPrefs();
                    if (userLoad == null) {
                      _showErrorDialog(AppLocalizations.of(context)
                          .translate('Please_signin_first_string'));
                    } else {
                      print("user is  here");
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return HelpOrganization();
                      }));
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context).translate('chat_support'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 8.0),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryTextTheme.button.color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
