import 'dart:convert';
import 'package:Borhan_User/models/organization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

class OrganizationNotifier with ChangeNotifier {
  List<Organization> _orgList = [];
  List<Organization> _translatedOrgList = [];

  List<Organization> get translatedOrgList {
    return [..._translatedOrgList];
  }

  Organization _currentOrg;

  Organization get currentOrg => _currentOrg;

  set currentOrganization(Organization organization) {
    _currentOrg = organization;
    notifyListeners();
  }

  List<Organization> get orgList {
    return [..._orgList];
  }

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
          licenseNo: prodData['licenseNo'],
          mobileNo: prodData['mobileNo'],
          bankAccounts: prodData['bankAccounts'],
          webPage: prodData['webPage'],
        ));
      });
      final translator = new GoogleTranslator();
      final List<Organization> translatedOrganizations = [];
      extractedData.forEach((prodId, prodData) {
        translatedOrganizations.add(Organization(
          id: prodId,
          orgName: prodData['orgName'],
          address: prodData['address'],
          logo: prodData['logo'],
          email: prodData['email'],
          description: prodData['description'],
          landLineNo: prodData['landLineNo'],
          licenseNo: prodData['licenseNo'],
          mobileNo: prodData['mobileNo'],
          bankAccounts: prodData['bankAccounts'],
          webPage: prodData['webPage'],
        ));
      });
      _orgList = loadedOrganizations;
      _translatedOrgList = translatedOrganizations;

      for (var i = 0; i < loadedOrganizations.length; i++) {
        _translatedOrgList[i].orgName = await translator
            .translate(_orgList[i].orgName, from: 'ar', to: 'en');
        _translatedOrgList[i].description =
            await translator.translate(_orgList[i].description, to: 'en');
        _translatedOrgList[i].address =
            await translator.translate(_orgList[i].address, to: 'en');
        _translatedOrgList[i].bankAccounts =
            await translator.translate(_orgList[i].bankAccounts, to: 'en');
      }
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
