import 'package:flutter/material.dart';

class Favourite extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Favorites screen')),

        body:
       Center (child:
         CircularProgressIndicator(),
       )
    );
  }
}
