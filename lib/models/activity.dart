import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Activity with ChangeNotifier {
  final String id;
  final String name;
  final String image;
  final String description;
  final String org_id;
  bool isFavorite;


  Activity(

      {@required this.id,
        @required  this.name,
        @required this.image,
        @required  this.description,
        this.isFavorite= false,
        this.org_id,
      });

  void toggleFavoriteStatus (){
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    
    notifyListeners();
    final url = 'https://borhanadmin.firebaseio.com/activities/$id.json';
    
   // http.patch(url, body: json.encode(value));
  }
}
