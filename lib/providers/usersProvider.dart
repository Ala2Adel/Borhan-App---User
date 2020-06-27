

import 'package:Borhan_User/models/user_nav.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exception.dart';
import 'package:Borhan_User/providers/shard_pref.dart';

class UsersPtovider with ChangeNotifier {
  UserNav userLoad;
  var _userData2 = UserNav(email: null, userName: null);
  UserNav get userData2 {
    return _userData2;
  }

  void setUserData({String userId, String email}) async {
  
    getUserData(userId);
  }

  Future<void> getUserData(String userId) async {
    final url = 'https://borhanuser-f92a3.firebaseio.com/Users/$userId.json';
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
  
      _userData2 = UserNav(
        id: userId,
        email: responseData['userEmail'],
        userName: responseData['userName'],
        userImage: responseData['userimage']
      );
      print(_userData2);
    
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      SharedPref sharedPref = SharedPref();
      sharedPref.save("user", _userData2);
    } catch (error) {
      throw error;
    }
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

  Future<void> addUser(
      String userId, String userName, String email, String password) async {
    
    final url = 'https://borhanuser-f92a3.firebaseio.com/Users/$userId.json';
    try {
      final response = await http.patch(
        url,
        body: json.encode(
          {
            "userName": userName,
            'userEmail': email,
            // 'userPassword': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (password == '') {
        _userData2 = UserNav(
          id: userId,
          email: email,
          userName: userName,
        );

        SharedPref sharedPref = SharedPref();
        sharedPref.save("user", _userData2);
      }
    } catch (error) {
      throw error;
    }
  }
 Future<void> apdateUser(
      String userId, String userName, String email, String image) async {
    
    final url = 'https://borhanuser-f92a3.firebaseio.com/Users/$userId.json';
    try {
      final response = await http.patch(
        url,
        body: json.encode(
          {
            "userName": userName,
            'userEmail': email,
            "userimage":image,
            // 'userPassword': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
     
        _userData2 = UserNav(
          id: userId,
          email: email,
          userName: userName,
          userImage: image
        );

        SharedPref sharedPref = SharedPref();
        sharedPref.save("user", _userData2);
    
    } catch (error) {
      throw error;
    }
  }
  Future<void> makeDonationRequest2(
      {String userName,
      String orgId,
      String donationAmount,
      String donationDate,
      String availableOn,
      String mobile,
      String donationType,
      String donatorAddress,
      String donatorItems,
      String image,
      String activityName,
      String userId,
      String orgName}) async {
    
    await loadSharedPrefs();
    userId = userLoad.id;
    final url =
        'https://borhanadmin.firebaseio.com/DonationRequests/$orgId.json';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "availableOn": availableOn,
            'donationAmount': donationAmount,
            'donationDate': donationDate,
            "donatorMobile": mobile,
            'donationType': donationType,
            "activityName": activityName,
            'donatorAddress': donatorAddress,
            "donationItems": donatorItems,
            'donatorName': userName,
            'donationImage': image,
            'status': 'waiting',
            'userId': userId,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      var reqId = json.decode(response.body)['name'];
      final reqUrl =
          'https://borhanadmin.firebaseio.com/MyDonations/$userId/$reqId.json';
      await http.patch(
        reqUrl,
        body: json.encode(
          {
            "availableOn": availableOn,
            'donationAmount': donationAmount,
            'donationDate': donationDate,
            "donatorMobile": mobile,
            'donationType': donationType,
            "activityName": activityName,
            'donatorAddress': donatorAddress,
            "donationItems": donatorItems,
            'donatorName': userName,
            'donationImage': image,
            'status': 'waiting',
            'userId': userId,
            'orgName': orgName,
          },
        ),
      );
    } catch (error) {
      throw error;
    }
  }


}
