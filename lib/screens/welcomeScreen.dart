//import 'dart:async';
//import 'package:Borhan_User/screens/login_screen.dart';
//import 'package:Borhan_User/screens/overview_screen.dart';
//import 'package:flutter/material.dart';
//
//import 'onboardScreen.dart';
//
//class SplashScreen extends StatefulWidget {
//  @override
//  _SplashScreenState createState() => _SplashScreenState();
//}
//
//class _SplashScreenState extends State<SplashScreen> {
//  @override
//  void initState() {
//    super.initState();
//
//    Timer(
//        Duration(seconds: 4),
//        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
//            builder: (BuildContext context) => OrgOverviewScreen())));
////    Timer(
////        Duration(seconds: 4),
////            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
////            builder: (BuildContext context) => LoginScreen())));  //OrgOverviewScreen()
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      // backgroundColor: Color.fromRGBO(43, 41, 104, 0.5),
//      backgroundColor: Colors.purple[400],
//      body: Padding(
//        padding: const EdgeInsets.all(15),
//        child: Center(
//          child: Image.asset(
//            'assets/images/BorhanLogo2.png',
//            // width: MediaQuery.of(context).size.width,
//            // height: MediaQuery.of(context).size.height,
//            fit: BoxFit.fill,
//          ),
//        ),
//      ),
//    );
//  }
//}


import 'dart:async';

import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'overview_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
      String asset = 'assets/images/HexaRotation.flr';
      var _size = MediaQuery.of(context).size;

      return SplashScreen.callback(
        name: asset,
        onSuccess: (_){
          
          Navigator.of(context).push(MaterialPageRoute(builder:(context) => OrgOverviewScreen() ));
        },
        onError: (e,s) {},
        height: _size.height,
        startAnimation: '0',
        endAnimation: '20',
        loopAnimation: 'untitled',

        backgroundColor: Colors.purple[100],
        until: () => Future.delayed(Duration(milliseconds: 30)),

      );
  }
}