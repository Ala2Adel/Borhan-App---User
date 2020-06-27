import 'package:flutter/foundation.dart';

class UserNav with ChangeNotifier {
  final String id;
  final String userName;
  final String userImage;
  final String email;

  UserNav({
    this.id,
    @required this.userName,
    @required this.email,
    this.userImage,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': userName,
        'image': userImage,
        'email': email,
      };

  UserNav.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['name'],
        userImage= json['image'],
        email = json['email'];

  @override
  String toString() {
    return "UserNav object data is id = $id name = $userName email = $email image = $userImage";
  }
}
