import 'dart:convert';
import 'package:Borhan_User/models/activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helper/fav_helper.dart';

class ActivityNotifier with ChangeNotifier {
  List<Activity> _activityList = [];
  Activity _currentActivity;

  List<Activity> _fav = [];

  Activity get currentActivity => _currentActivity;

  set currentActivity(Activity activity) {
    _currentActivity = activity;
    notifyListeners();
  }

  List<Activity> get activityList {
    return [..._activityList];
  }

  List<Activity> get favorites {
    return [..._fav];
  }

  Activity findById(String id) {
    return _activityList.firstWhere((organization) => organization.id == id);
  }

  Future<void> fetchAndSetActivities(String orgId) async {
    final url = 'https://borhanadmin.firebaseio.com/activities/$orgId.json';
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
          isFavorite: prodData['isFavorite'],
        ));
      });
      _activityList = loadedActivity;
      print("Notifier" + loadedActivity[0].id);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void addFavorite(
      String pickedTitle,
      String pickedDescription,
      String pickedImage,
      String id,
      ) {
    print('from adding');
    final newActivity = Activity(
      id: id,
      name: pickedTitle,
      description: pickedDescription,
      image: pickedImage,
    );
    _fav.add(newActivity);
    notifyListeners();
    DBHelper.insert('activity_fav', {
      'id': newActivity.id,
      'name': newActivity.name,
      'description': newActivity.description,
      'image': newActivity.image
    });
  }

  Future<void> fetchAndSetFavorites() async {
    final dataList = await DBHelper.getData('activity_fav');
    _fav = dataList
        .map((item) => Activity(
      id: item['id'],
      name: item['name'],
      description: item['description'],
      image: item['image'],
    ))
        .toList();
    print('from fetch');
    print(dataList);
    notifyListeners();
  }

  void deleteFavorite(Activity activity) {
    print('from deleting');
    print(activity);
    print('*******************************************');
    _fav.remove(activity);
    notifyListeners();
    DBHelper.delete('activity_fav', activity.id);
  }
}
