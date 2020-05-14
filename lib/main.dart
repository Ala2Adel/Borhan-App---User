import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp() ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State <MyApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
