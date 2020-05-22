import 'package:flutter/material.dart';

class Support extends StatefulWidget {
  // final String title;
  // DonationHistory(this.title)
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الدعم والمساعدة"),
        
      ),
      body: Center(child: Text("Support Screen")),
      
      
    );
  }
}