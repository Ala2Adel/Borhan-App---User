import 'package:flutter/foundation.dart';

class Activity with ChangeNotifier {
  final String id;
  final String name;
  final String image;
  final String description;


  Activity(
      {this.id,
        @required  this.name,
        this.image,
        @required  this.description,
      });
}
