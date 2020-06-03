import 'package:flutter/foundation.dart';

class UserNav with ChangeNotifier {
  final String userName;
  final String email;

  UserNav({
    @required this.userName,
    @required this.email,
  });

  Map<String, dynamic> toJson() => {
  'name': userName,
  'email': email,
   };

   UserNav.fromJson(Map<String, dynamic> json)
      : userName = json['name'],
        email = json['email'];
}
