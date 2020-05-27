
import 'dart:convert';
import 'package:Borhan_User/models/activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ActivityNotifier with ChangeNotifier {
  List <Activity> _activityList =[];
  Activity _currentActivity;

  Activity get currentActivity => _currentActivity;

  set currentActivity (Activity activity) {
    _currentActivity = activity;
    notifyListeners();
  }

  List<Activity> get activityList {
    return [..._activityList];
  }

    Activity findById(String id) {
    return _activityList.firstWhere((organization) => organization.id == id);
  }

  Future<void> fetchAndSetActivities() async {
    const url = 'https://borhanadmin.firebaseio.com/activities.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // print((response.body));
      final List<Activity> loadedActivity = [];
      extractedData.forEach((prodId, prodData) {
        loadedActivity.add(Activity(
          id: prodId,
          name: prodData['name'],
          image: prodData['image'],
          description: prodData['description'],
          isFavorite: prodData ['isFavorite'],
        ));
      });
      _activityList = loadedActivity;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

//  Future <void> toggleFavoriteStatus () async{
//    final oldStatus = isFavorite;
//    isFavorite = !isFavorite;
//    notifyListeners();
//    final url = 'https://borhanadmin.firebaseio.com/activities/$id';
//    try{
//      final response = await http.patch(
//          url,
//          body:
//          json.encode({
//            'isFavorite' : isFavorite,
//          }));
//      if(response.statusCode >= 400){
//        isFavorite = oldStatus;
//        notifyListeners();
//      }
//
//    } catch (error){
//      isFavorite = oldStatus;
//      notifyListeners();
//    }
//
//  }


}