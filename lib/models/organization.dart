import 'package:flutter/foundation.dart';

class Organization with ChangeNotifier {
  final String id;
  final String orgName;
  final String logo;
  final String address;
  final String description;
  final String licenseNo;
  final String landLineNo;
  final String mobileNo;
  final String bankAccounts;
  final String webPage;
  final String email;
  final String orgLocalId;

  Organization(
      {this.id,
      this.orgLocalId,
      @required this.orgName,
      this.logo,
      this.address,
      @required this.description,
      this.licenseNo,
      this.email,
      this.landLineNo,
      this.mobileNo,
      this.bankAccounts,
      this.webPage});
}