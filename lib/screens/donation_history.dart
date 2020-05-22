import 'package:flutter/material.dart';

class DonationHistory extends StatefulWidget {
  // final String title;
  // DonationHistory(this.title)
  @override
  _DonationHistoryState createState() => _DonationHistoryState();
}

class _DonationHistoryState extends State<DonationHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("التبرعات السابقة"),
        
      ),
      body: Center(child: Text("Donation History")),
      
      
    );
  }
}