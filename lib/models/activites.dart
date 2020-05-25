import 'package:flutter/foundation.dart';

class Activity with ChangeNotifier {
  final String id;
  final String activityName;
  final String description;
  final String activityImage;

  Activity(
      {this.id,
        @required  this.activityName,
        @required  this.description,
        this.activityImage,
        });
}
