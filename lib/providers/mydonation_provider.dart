import 'dart:io';
import 'package:Borhan_User/models/mydonation.dart';
import 'package:Borhan_User/models/organization.dart';
import 'package:Borhan_User/models/user_nav.dart';
import 'package:Borhan_User/providers/shard_pref.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyDonationsProvider with ChangeNotifier {
  UserNav userLoad;
List<Organization> _orgList = [];
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
    } catch (error) {
      // do something
    }
  }

  Future<void> fetchAndSetDonations(String userId) async {
    await loadSharedPrefs();
    userId = userLoad.id;
    final url = 'https://borhanadmin.firebaseio.com/MyDonations/$userId.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<MyDonation> loadedDonations = [];
      if (extractedData != null) {
        extractedData.forEach((donationId, donationData) {
          print(donationData['donatorName']);
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
            donatorName: donationData['donatorName'],
            donatorAddress: donationData['donatorAddress'],
            availableOn: donationData['availableOn'],
            donatorMobileNo: donationData['donatorMobile'],
            userId: donationData['userId'],
          ));
        });
        _items = loadedDonations;

        notifyListeners();
      } else {
        print('No Data in this chat');
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateMyDonation(String id, MyDonation newDonation) async {
    final donationIndex = _items.indexWhere((donation) => donation.id == id);
    String userId = newDonation.userId;
    if (donationIndex >= 0) {
      final url = 'https://borhanadmin.firebaseio.com/MyDonations/$userId/$id.json';
      await http.patch(url,
          body: json.encode({
            'activityName': newDonation.actName,
            'availableOn': newDonation.availableOn,
            'donationAmount':newDonation.donationAmount,
            'donationDate':newDonation.donationDate,
            'donationImage': newDonation.image,
            'donationItems':newDonation.donationItems,
            'donationType':newDonation.donationType,
            'donatorAddress': newDonation.donatorAddress,
            'donatorMobile':newDonation.donatorMobileNo,
            'donatorName':newDonation.donatorName,
            'orgName': newDonation.orgName,
            'status': newDonation.status,
            'userId': newDonation.userId,
          }));
      _items[donationIndex] = newDonation;
      notifyListeners();
    }
  }

  Future<void> deleteMyDonation({String id, String userId}) async {
    await loadSharedPrefs();
    userId = userLoad.id;
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

  Future<String> uploadImage(File image) async {
    StorageReference storageReference =
    FirebaseStorage.instance.ref().child(image.path.split('/').last);
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    String _downloadUrl = await storageReference.getDownloadURL();
    return _downloadUrl;
  }

  Future deleteImage(String imgUrl) async {
    StorageReference myStorageReference =
    await FirebaseStorage.instance.getReferenceFromUrl(imgUrl);
    await myStorageReference.delete();
  }

  Future<void> updateDonationReq(MyDonation donationReq, String orgId) async {
    print('*************\n***************\n***************\n'+donationReq.donatorName);
    final reqIndex =
    _items.indexWhere((request) => request.id == donationReq.id);
    if (reqIndex >= 0) {
      var reqId = donationReq.id;
      final url =
          'https://borhanadmin.firebaseio.com/DonationRequests/$orgId/$reqId.json';
      await http.patch(url,
          body: json.encode({
            'activityName': donationReq.actName,
            'availableOn': donationReq.availableOn,
            'donationAmount':donationReq.donationAmount,
            'donationDate':donationReq.donationDate,
            'donationImage': donationReq.image,
            'donationItems':donationReq.donationItems,
            'donationType':donationReq.donationType,
            'donatorAddress': donationReq.donatorAddress,
            'donatorMobile':donationReq.donatorMobileNo,
            'donatorName':donationReq.donatorName,
            'orgName': donationReq.orgName,
            'status': donationReq.status,
            'userId': donationReq.userId,
          }));
      _items[reqIndex] = donationReq;
      notifyListeners();
    }
  }

  Future<Organization> fetchAndSetOrg (String orgName) async {
    final url =
        'https://borhanadmin.firebaseio.com/CharitableOrganizations.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Organization> loadedActivities = [];
      if (extractedData != null) {
        extractedData.forEach((autoOrgId, orgData) {
          loadedActivities.add(Organization(
              id: autoOrgId,
              orgName: orgData['orgName'],
              address: orgData['address'],
              bankAccounts: orgData['bankAccounts'],
              landLineNo: orgData['landLineNo'],
              description: orgData['description'],
              licenseNo: orgData['licenseNo'],
              mobileNo: orgData['mobileNo'],
              webPage: orgData['webPage'],
              logo: orgData['logo'],
              orgLocalId: orgData['orgLocalId']));
        });
        _orgList = loadedActivities;
        notifyListeners();
        var organization =
        _orgList.firstWhere((org) => org.orgName == orgName);
        return organization;
      } else {
        print('No Data in this org');
      }
    } catch (error) {
      throw (error);
    }
  }

}

