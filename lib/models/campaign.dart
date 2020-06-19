import 'package:flutter/foundation.dart';

class Campaign with ChangeNotifier {
  final String id;
  var campaignName;
  var campaignDescription;
  var orgName;
  final String orgId;
  final String imagesUrl;
  var time;

  Campaign({
    this.id,
    @required this.campaignName,
    @required this.campaignDescription,
    @required this.orgId,
    @required this.orgName,
    this.imagesUrl,
    this.time,
  });
}
