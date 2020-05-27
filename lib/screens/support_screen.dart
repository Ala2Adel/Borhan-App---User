import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
List<String> _email = [] ;

class Support extends StatefulWidget {

  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = (prefs.getStringList('email')??'');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الدعم والمساعدة"),

      ),

      body: Center(child: Text("Notification History")),
//      ListView(
//        children: <Widget>[
//
//          Text(''+ _email.toString(), style: new TextStyle(
//          color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
//          )],
//
//      )
    );
  }
}