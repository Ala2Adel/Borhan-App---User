import 'package:flutter/foundation.dart';

class MyDonation with ChangeNotifier {
  final String id;
  final String donationType;
  final String donationItems;
  final String donationAmount;
  final String donationDate;
  final String image;
  final String orgName;
  final String actName;
  final String status;
  final String userId;
  final String donatorAddress;
  final String donatorMobileNo;
  final String availableOn;
  final String donatorName;

  MyDonation({
    this.id,
    this.donatorName,
    this.availableOn,
    this.donationType,
    this.donationItems,
    this.donationAmount,
    this.donationDate,
    this.image,
    this.orgName,
    this.actName,
    this.status,
    this.userId,
    this.donatorMobileNo,
    this.donatorAddress,
  });
}
