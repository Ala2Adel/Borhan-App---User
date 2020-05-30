import 'dart:convert';
import 'package:Borhan_User/models/organization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrganizationNotifier with ChangeNotifier {
  List<Organization> _orgList = [];

  Organization _currentOrg;

  Organization get currentOrg => _currentOrg;

  set currentOrganization(Organization organization) {
    _currentOrg = organization;
    notifyListeners();
  }

  List<Organization> get orgList {
    return [..._orgList];
  }

//  Organization findById(String id) {
//    return _orgList.firstWhere((organization) => organization.id == id);
//  }

  Future<void> getOrganizations() async {
    final url =
        'https://borhanadmin.firebaseio.com/CharitableOrganizations.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print((response.body));
      final List<Organization> loadedOrganizations = [];
      extractedData.forEach((prodId, prodData) {
        loadedOrganizations.add(Organization(
          id: prodId,
          orgName: prodData['orgName'],
          address: prodData['address'],
          logo: prodData['logo'],
          email: prodData['email'],
          description: prodData['description'],
          landLineNo: prodData['landLineNo'],
          licenseNo: prodData['licenceNo'],
          mobileNo: prodData['mobileNo'],
          bankAccounts: prodData['bankAccounts'],
          webPage: prodData['webPage'],
        ));
      });

      _orgList = loadedOrganizations;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
