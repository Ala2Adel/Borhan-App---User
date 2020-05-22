import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  // final String title;
  // DonationHistory(this.title)
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("المفضلة"),
        
      ),
      body: Center(child: Text("Favourite Screen")),
      
      
    );
  }
}