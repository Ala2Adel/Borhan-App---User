import 'dart:async';
import 'package:Borhan_User/screens/onboardScreen.dart';
import 'package:Borhan_User/screens/overview_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
           builder: (BuildContext context) => OnboardScreen())));
            // builder: (BuildContext context) => OrgOverviewScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Image.asset(
            'assets/images/BorhanLogo3.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
