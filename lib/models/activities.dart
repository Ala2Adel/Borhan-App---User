
import 'package:flutter/cupertino.dart';

class Activity with ChangeNotifier {
final String id;
final String orgId;
final String activityName;
final String description;
final String activityImage;

Activity(
{this.id,
this.orgId,
@required  this.activityName,
@required  this.description,
this.activityImage,
});
}