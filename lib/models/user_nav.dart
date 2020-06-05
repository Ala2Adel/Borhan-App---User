import 'package:flutter/foundation.dart';

class UserNav with ChangeNotifier {
  final String id;
  final String userName;
  final String email;

  UserNav({
    this.id,
    @required this.userName,
    @required this.email,
  });

  Map<String, dynamic> toJson() => {
   'id' :id,
  'name': userName,
  'email': email,
   };

   UserNav.fromJson(Map<String, dynamic> json)
      :id = json['id'],
       userName = json['name'],
        email = json['email'];

   @override
  String toString() {
    // TODO: implement toString
    return "UserNav object data is id = $id name = $userName email = $email";
  }     
}
