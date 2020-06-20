import 'package:Borhan_User/models/user_nav.dart';
import 'package:Borhan_User/providers/shard_pref.dart';
import 'package:Borhan_User/providers/usersProvider.dart';
import 'package:Borhan_User/screens/help_screen.dart';
import 'package:Borhan_User/screens/login_screen.dart';
import 'package:Borhan_User/screens/my_donation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import '../app_localizations.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  UsersPtovider usersPtovider;
  UserNav userLoad;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => (Platform.isAndroid)
          ? AlertDialog(
              title:
                  Text(AppLocalizations.of(context).translate('logout_string')),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text(AppLocalizations.of(context).translate('cancel')),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
                FlatButton(
                  child: Text(
                      AppLocalizations.of(context).translate('yes_string')),
                  onPressed: () {
                    SharedPref sharedPref = SharedPref();
                    sharedPref.remove("user");
                    LoginScreen.googleSignIn.disconnect();
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            )
          : CupertinoAlertDialog(
              title:
                  Text(AppLocalizations.of(context).translate('logout_string')),
              content: Text(message),
              actions: <Widget>[
                CupertinoDialogAction(
                    child:
                        Text(AppLocalizations.of(context).translate('cancel')),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    }),
                CupertinoDialogAction(
                    child: Text(
                        AppLocalizations.of(context).translate('yes_string')),
                    onPressed: () {
                      SharedPref sharedPref = SharedPref();
                      sharedPref.remove("user");
                      Navigator.of(ctx).pop();
                    })
              ],
            ),
    ).then((value) => Navigator.of(context).pop());
  }

  void _showErrorDialogLogin(String message) {
    print("alert");
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
                    Navigator.pushNamed(ctx, '/Login');
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
                  child: Text(
                      AppLocalizations.of(context).translate('not_now_string')),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
                CupertinoDialogAction(
                  child: Text(
                      AppLocalizations.of(context).translate('yes_string')),
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
      setState(() {
        userLoad = user;
      });
    } catch (Excepetion) {
      // do something
    }
    return user;
  }

  @override
  void initState() {
    super.initState();

    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: userLoad == null
                ? Text(
                    AppLocalizations.of(context).translate('welcome_string'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17, height: 0.5),
                  )
                : Text(
                    userLoad.userName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
            accountEmail: userLoad == null
                ? InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/Login');
                    },
                    child: Text(
                      AppLocalizations.of(context)
                          .translate("Login_Signup_string"),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )
                : Text(userLoad.email,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
              child: userLoad == null
                  ? Icon(
                      Icons.perm_identity,
                      size: 40,
                    )
                  : Text(userLoad.userName.substring(0, 1)),
            ),
          ),
          new ListTile(
            title: Text(
              AppLocalizations.of(context).translate("Home_String"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            leading: new Icon(Icons.home),
            onTap: () => Navigator.pushReplacementNamed(context, '/Home'),
          ),
          new ListTile(
            title: Text(
              AppLocalizations.of(context).translate("favorites_string"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            leading: new Icon(Icons.favorite),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/Favourite');
            },
          ),
          // new ListTile(
          //   title: const Text(
          //     "الإشعارات",
          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          //   ),
          //   leading: Icon(Icons.notifications),
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Navigator.pushNamed(context, '/Notifications');
          //   },
          // ),
          new ListTile(
            title: Text(
              AppLocalizations.of(context).translate("Mydonations_String"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            leading: new Icon(Icons.drag_handle),
            onTap: () async {
              UserNav userLoad = await loadSharedPrefs();
              Navigator.pop(context);
              if (userLoad == null) {
                _showErrorDialogLogin("الرجاء التسجيل قبل الدخول");
              } else {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return MyDonationsScreen();
                }));
              }
            },
          ),
          new ListTile(
            title: Text(
              AppLocalizations.of(context).translate("External_Donations"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            leading: new Icon(Icons.account_balance_wallet),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/ExternalDonation');
            },
          ),
          if (userLoad != null)
            new ListTile(
              title: Text(
                AppLocalizations.of(context).translate("logout_string"),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              leading:
                  new Icon(Icons.exit_to_app), // FontAwesomeIcons.signOutAlt
              onTap: () {
                _showErrorDialog(
                    AppLocalizations.of(context).translate('logout_sure'));
              },
            ),
          Divider(),
          new ListTile(
            title: Text(
              AppLocalizations.of(context).translate("help and support"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            leading: new Icon(Icons.help),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HelpScreen()));
            },
          )
        ],
      ),
    );
  }
}
