import 'package:Borhan_User/models/user_nav.dart';
import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/providers/shard_pref.dart';
import 'package:Borhan_User/screens/Help_organizations.dart';
import 'package:Borhan_User/screens/email_organization.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  static const routeName = '/help';

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
//  String currentUserId = '1212145f';
 void _showErrorDialog(String message) {
    print("alert");
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const  Text('تسجيل دخول'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: const  Text('ليس الأن'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          FlatButton(
            child: const  Text('نعم'),
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
    final data = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        title: const  Text('المساعدة'),
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
                  child: const  Text(
                    'بواسطة البريد الإلكتروني',
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
                  onPressed: ()async {

                  UserNav userLoad = await loadSharedPrefs();
                    if(userLoad==null){
                      print("user is not here");
                      _showErrorDialog("برجاء تسجيل الدخول أولا");
                     }else{
                       print("user is  here");
                       Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                      return HelpOrganization();
                    }));
                     }
                   
                  },
                  child: const Text(
                    'بواسطة محادثة',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
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
