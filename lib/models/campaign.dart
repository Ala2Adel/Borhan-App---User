import 'package:flutter/foundation.dart';

class Campaign{
  // String id;
   String name;
   String description;
   String image;
   String period;

  Campaign.fromMap(Map<String, dynamic> data){
    //id = data['id'];
    name = data['Name'];
    description = data['Description'];
    image=data['Image'];
    period = data['Period'];


  }
}