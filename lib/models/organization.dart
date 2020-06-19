import 'package:flutter/foundation.dart';

class Organization with ChangeNotifier {
  final String id;
  var orgName;
  final String logo;
  var address;
  var description;
  final String licenseNo;
  final String landLineNo;
  final String mobileNo;
  var bankAccounts;
  final String webPage;
  final String email;

  Organization(
      {this.id,
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
