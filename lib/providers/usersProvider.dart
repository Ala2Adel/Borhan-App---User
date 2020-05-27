import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exception.dart';

class UsersPtovider with ChangeNotifier{

  Future<void> addUser( String userName,
      String email, String password) async {
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
    } catch (error) {
      throw error;
    }
  }
  Future<void> makeDonationRequest( {String userName, String donationAmount,String donationDate
      , String availableOn , String mobile ,String donationType,
      String donatorAddress , String donatorItems ,String image}
      ) async {
    final url =
        'https://borhanadmin.firebaseio.com/DonationRequests.json';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          { "AvailableOn":availableOn,
            'DonationAmount': donationAmount,
            'DonationDate': donationDate,
            "DonationMobileNo":mobile,
            'DonationType': donationType,
            'DonatorAddress': donatorAddress,
            "DonatorItems":donatorItems,
            'DonatorName': userName,
            'Image': image,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }
}