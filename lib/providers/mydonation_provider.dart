import 'dart:io';
import 'package:Borhan_User/models/mydonation.dart';
import 'package:Borhan_User/models/user_nav.dart';
import 'package:Borhan_User/providers/shard_pref.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/activity.dart';

class MyDonationsProvider with ChangeNotifier {

  UserNav userLoad ;
  List<MyDonation> _items = [];

  List<MyDonation> get items {
    return [..._items];
  }

  MyDonation findById(String id) {
    return _items.firstWhere((donation) => donation.id == id);
  }
  
   loadSharedPrefs() async {
    try {
   
     SharedPref sharedPref = SharedPref();
     UserNav user = UserNav.fromJson(await sharedPref.read("user"));
      userLoad = user;
      } catch (Excepetion) {
    // do something
       }
   }    

  Future<void> fetchAndSetDonations(String userId) async {
//    userId = 'sj34ZIYOs6PUW4jxE93lWl35b1H3';      /******************/   /* Note */ /**************/
    
      await loadSharedPrefs();
          print(userLoad);
          userId=userLoad.id;

    print("from fetch userId  " + userId);
    final url = 'https://borhanadmin.firebaseio.com/MyDonations/$userId.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<MyDonation> loadedDonations = [];

//      print("Response body"+ response.body);

      if (extractedData != null) {
        extractedData.forEach((donationId, donationData) {
          print("Donation Id from fetch in looooop  :  " + donationId);
          print(donationData['image']);
          loadedDonations.add(MyDonation(
            id: donationId,
            orgName: donationData['orgName'],
            actName: donationData['activityName'],
            donationAmount: donationData['donationAmount'],
            donationDate: donationData['donationDate'],
            donationItems: donationData['donationItems'],
            donationType: donationData['donationType'],
            image: donationData['donationImage'],
            status: donationData['status'],
          ));
        });
        _items = loadedDonations;
        print('Items' + _items[0].orgName);
        notifyListeners();
      } else {
        print('No Data in this chat');
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<void> deleteMyDonation({String id, String userId}) async {
    await loadSharedPrefs();
          print(userLoad);
          userId=userLoad.id;
    final url = 'https://borhanadmin.firebaseio.com/MyDonations/$userId.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeWhere((activity) => activity.id == id);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
