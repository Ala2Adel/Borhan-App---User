
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



//void _setFavValue(bool newValue ){
//isFavorite = newValue ;
//notifyListeners();
//}

//Future <void> toggleFavoriteStatus () async{
//final oldStatus = isFavorite;
//isFavorite = !isFavorite;
//notifyListeners();
//
//Future<void> updateRequest () async {
//final url = 'https://borhanadmin.firebaseio.com/activities/$id.json';
//try {
//final response = await http.patch(
//url,
//body:
//json.encode({
//'isFavorite': isFavorite,
//}));
//if (response.statusCode >= 400) {
////        isFavorite = oldStatus;
////        notifyListeners();
//_setFavValue(oldStatus);
//}
//} catch (error) {
////        isFavorite = oldStatus;
////        notifyListeners();
//_setFavValue(oldStatus);
//}
//}
//}
}