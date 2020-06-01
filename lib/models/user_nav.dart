import 'package:flutter/foundation.dart';

class UserNav with ChangeNotifier {
  final String userName;
  final String email;

  UserNav({
    @required this.userName,
    @required this.email,
  });
}
