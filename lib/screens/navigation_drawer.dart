import 'package:Borhan_User/models/user_nav.dart';
import 'package:Borhan_User/providers/shard_pref.dart';
import 'package:Borhan_User/providers/usersProvider.dart';
import 'package:Borhan_User/screens/chat_screen.dart';
import 'package:Borhan_User/screens/help_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

  UsersPtovider usersPtovider;
  UserNav userLoad ;

  void _showErrorDialog(String message) {
    print("alert");
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('تسجيل خروج'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('الغاء'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          FlatButton(
            child: Text('نعم'),
            onPressed: () {
              SharedPref sharedPref = SharedPref();
               sharedPref.remove("user");
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    ).then((value) =>  Navigator.of(context).pop());
  }

  @override
  void initState() {
    super.initState();
     usersPtovider =Provider.of<UsersPtovider>(context, listen: false);
     loadSharedPrefs();
  }
   loadSharedPrefs() async {
    try {
   
     SharedPref sharedPref = SharedPref();
     UserNav user = UserNav.fromJson(await sharedPref.read("user"));
    setState(() {
      userLoad = user;
    });
  } catch (Excepetion) {
    // do something
  }
}
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UsersPtovider>(context);
    return Drawer(
      child: new ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            // accountName: data.userData2.userName==null? Text("User Name ")
            // :Text( data.userData2.userName),
            // accountEmail: data.userData2.email==null? Text("User Email@MailServer.com ")
            // :Text( data.userData2.email),
            // currentAccountPicture: CircleAvatar(backgroundColor: Colors.black,
            // child: data.userData2.userName==null? Text("M"):Text(data.userData2.userName.substring(0,1)),

            ////////////////////////////////////////////////////
            accountName: userLoad==null? Text("User Name ")
            :Text( userLoad.userName),
            accountEmail: userLoad==null? Text("User Email@MailServer.com ")
            :Text( userLoad.email),
            currentAccountPicture: CircleAvatar(backgroundColor: Colors.black,
            child: userLoad==null? Text("M"):Text(userLoad.userName.substring(0,1)),
            ),
          ),
          new ListTile(
            title: new Text("الرئيسية"),
            leading: new Icon(Icons.home),
            onTap: ()=>Navigator.pushReplacementNamed(context, '/Home'),
          ),
          new ListTile(
            title: new Text("المفضلة"),
            leading: new Icon(Icons.favorite),
            onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/Favourite');
              },
          ),
          new ListTile(
            title: new Text("الإشعارات"),
            leading: new Icon(Icons.notifications),
             onTap: (){
                     Navigator.of(context).pop();
                     Navigator.pushNamed(context, '/Notifications');
                   }
             ,
          ),
          new ListTile(
            title: new Text("تبرعاتي"),
            leading: new Icon(Icons.drag_handle),
            onTap: (){ 
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/myDonations');
             },
          ),

          userLoad==null?
          new ListTile(
            title: new Text("تسجيل الدخول"),
            leading: new Icon(Icons.arrow_right),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/Login');
            },
          )
          : new ListTile(
            title: new Text("تسجيل خروج"),
            leading: new Icon(Icons.arrow_left),
            onTap: (){
                     _showErrorDialog("هل تريد تسجيل الخروج");
                    
                    },
          )
          ,
          // new ListTile(
          //   title: new Text("ملفي"),
          //   leading: new Icon(Icons.people),
          //   onTap: ()=>Navigator.pushNamed(context, '/Profile'),
          // ),
          Divider(),
          new ListTile(
            title: new Text("الدعم و المساعدة"),
            leading: new Icon(Icons.help),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HelpScreen()));
            },
          )
        ],
      ),
    );
  }
}
