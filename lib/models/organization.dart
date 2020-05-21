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

  Organization(
      {this.id,
      @required  this.orgName,
        this.logo,
        this.address,
      @required  this.description,
        this.licenseNo,
        this.landLineNo,
        this.mobileNo,
        this.bankAccounts,
        this.webPage});
}
