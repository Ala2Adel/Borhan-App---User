import 'dart:ffi';
import 'package:Borhan_User/models/mydonation.dart';
import 'package:Borhan_User/models/user_nav.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exception.dart';
import 'package:Borhan_User/providers/shard_pref.dart';

class UsersPtovider with ChangeNotifier{

  var _userData2 = UserNav(email: null,userName: null);
  UserNav get userData2 {
    return _userData2;
  }
  void setUserData({String userName, String email}){
      _userData2 = UserNav(
        email: email ,
        userName: userName,
      );
  }
 
  Future<void> addUser( String userName, String email, String password) async {
    final url =
        'https://borhanuser-f92a3.firebaseio.com/Users.json';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          { "userName":userName,
            'userEmail': email,
            'userPassword': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _userData2 = UserNav(
        email: email ,
        userName: userName,
      );
    SharedPref sharedPref = SharedPref();
    sharedPref.save("user", _userData2);
    } catch (error) {
      throw error;
    }
  }

  Future<void> makeDonationRequest2( {String userName, String orgId,String donationAmount,String donationDate
    , String availableOn , String mobile ,String donationType,
    String donatorAddress , String donatorItems ,String image ,String activityName, String userId,String orgName}
      ) async {
//        userId="ZZTqvnHmqBQuTpzlpTT9XA9oIXO2";
    final url =
        'https://borhanadmin.firebaseio.com/DonationRequests/$orgId.json';
    try {
      final response = await http.post(
        url,
        body: json.encode(
        { "availableOn":availableOn,
            'donationAmount': donationAmount,
            'donationDate': donationDate,
            "donatorMobile":mobile,
            'donationType': donationType,
            "activityName":activityName,
            'donatorAddress': donatorAddress,
            "donationItems":donatorItems,
            'donatorName': userName,
            'donationImage': image,
          'status': 'wating',
          'userId': userId,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      var reqId =  json.decode(response.body)['name'];
      final reqUrl = 'https://borhanadmin.firebaseio.com/MyDonations/$userId/$reqId.json';
          await http.patch(
            reqUrl,
            body: json.encode(
              { "availableOn":availableOn,
                'donationAmount': donationAmount,
                'donationDate': donationDate,
                "donatorMobile":mobile,
                'donationType': donationType,
                "activityName":activityName,
                'donatorAddress': donatorAddress,
                "donationItems":donatorItems,
                'donatorName': userName,
                'donationImage': image,
                'status': 'wating',
                'userId': userId,
                'orgName': orgName,
              },
            ),
          );

    } catch (error) {
      throw error;
    }
  }

// Future<void> makeDonationRequest( {String userName, String donationAmount,String donationDate
//       , String availableOn , String mobile ,String donationType,
//       String donatorAddress , String donatorItems ,String image ,String activityName}
//       ) async {
//     final url =
//         'https://borhanadmin.firebaseio.com/DonationRequests.json';
//     try {
//       final response = await http.post(
//         url,
//         body: json.encode(
//           { "availableOn":availableOn,
//             'donationAmount': donationAmount,
//             'donationDate': donationDate,
//             "donatorMobile":mobile,
//             'donationType': donationType,
//             "activityName":activityName,
//             'donatorAddress': donatorAddress,
//             "donationItems":donatorItems,
//             'donatorName': userName,
//             'donationImage': image,
//           },
//         ),
//       );
//       final responseData = json.decode(response.body);
//       if (responseData['error'] != null) {
//         throw HttpException(responseData['error']['message']);
//       }
//     } catch (error) {
//       throw error;
//     }
//   }

}
