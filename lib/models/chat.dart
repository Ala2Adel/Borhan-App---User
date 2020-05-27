import 'package:flutter/foundation.dart';

class Chat with ChangeNotifier{
  final String id;
  final String text;
  final String userName;
  final String userId;
  final String time;
  final String img;

  Chat({
    this.id,
    this.text,
    this.userId,
    this.userName,
    this.time,
    this.img,
  });
}