import 'package:flutter/foundation.dart';


class EmailM with ChangeNotifier{
  final String bodyController;
  final String subjectController;
  final String recipientController;

  EmailM({
    this.bodyController,
    this.subjectController,
    @required this.recipientController,
  });
}