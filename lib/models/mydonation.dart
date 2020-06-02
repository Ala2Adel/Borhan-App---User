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
  final String    status;

  MyDonation({
    this.id,
    this.donationType,
    this.donationItems,
    this.donationAmount,
    this.donationDate,
    this.image,
    this.orgName,
    this.actName,
    this.status,
  });
}
