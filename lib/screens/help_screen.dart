import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/screens/Help_organizations.dart';
import 'package:Borhan_User/screens/email_organization.dart';
import 'package:provider/provider.dart';

import '../screens/chat_screen.dart';
import '../screens/email_screen.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  static const routeName = '/help';

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
//  String currentUserId = '1212145f';
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Help/Support'),
      ),
      body: Center(
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
                  'بواسطة البريد الإلكتروني',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HelpOrganization()));
                },
                child: Text(
                  'بواسطة محادثة',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
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
    );
  }
}
