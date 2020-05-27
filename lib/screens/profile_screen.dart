import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  // final String title;
  // DonationHistory(this.title)
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("المفضلة"),
        
      ),
      body: Center(child: Text("Profile Screen")),
      
      
    );
  }
}