import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("User Name "),
            accountEmail: Text("User Email@MailServer.com "),
            currentAccountPicture: CircleAvatar(backgroundColor: Colors.black,child: Text("M"),),
          ),
          new ListTile(
            title: new Text("الرئيسية"),
            leading: new Icon(Icons.home),
            onTap: ()=>Navigator.pushNamed(context, '/Home'),
          ),
          new ListTile(
            title: new Text("المفضلة"),
            leading: new Icon(Icons.favorite),
            onTap: ()=>Navigator.pushNamed(context, '/Favourite'),
          ),
          new ListTile(
            title: new Text("الإشعارات"),
            leading: new Icon(Icons.notifications),
             onTap: ()=>Navigator.pushNamed(context, '/Notifications'),
          ),
          new ListTile(
            title: new Text("التبرعات السابقة"),
            leading: new Icon(Icons.drag_handle),
            onTap: ()=>Navigator.pushNamed(context, '/DonationHistory'),
          ),
          new ListTile(
            title: new Text("تسجيل الدخول"),
            leading: new Icon(Icons.arrow_right),
            onTap: ()=>Navigator.pushNamed(context, '/Login'),
          ),
          new ListTile(
            title: new Text("ملفي"),
            leading: new Icon(Icons.people),
            onTap: ()=>Navigator.pushNamed(context, '/Profile'),
          ),
          Divider(),
          new ListTile(
            title: new Text("الدعم و المساعدة"),
            leading: new Icon(Icons.help),
            onTap: ()=>Navigator.pushNamed(context, '/Support'),
          )
        ],
      ),
    );
  }
}
