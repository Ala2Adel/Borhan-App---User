import 'dart:async';
import 'package:Borhan_User/screens/login_screen.dart';
import 'package:Borhan_User/screens/overview_screen.dart';
import 'package:flutter/material.dart';

import 'onboardScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => OrgOverviewScreen())));
//    Timer(
//        Duration(seconds: 4),
//            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
//            builder: (BuildContext context) => LoginScreen())));  //OrgOverviewScreen()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(43, 41, 104, 0.5),
      backgroundColor: Colors.purple[400],
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Image.asset(
            'assets/images/borhan-alireza.jpg',
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
