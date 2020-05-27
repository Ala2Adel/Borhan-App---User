import 'package:flutter/material.dart';

//class Favourite extends StatefulWidget {
//  // final String title;
//  // DonationHistory(this.title)
//  @override
//  _FavouriteState createState() => _FavouriteState();
//}
//
//class _FavouriteState extends State<Favourite> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("المفضلة"),
//
//      ),
//      body: Center(child: Text("Favourite Screen")),
//
//    );
//  }
//}

class Favourite extends StatelessWidget {
  //final ListView text;

  //Favourite(pushSaved,  {Key key, @required this.text}) : super(key: key);//add also..example this.abc,this...

  //Favourite(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Second screen 2')),

        body:
        Text('favorite')
    );
  }
}
