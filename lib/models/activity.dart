
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../helper/fav_helper.dart';

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


}