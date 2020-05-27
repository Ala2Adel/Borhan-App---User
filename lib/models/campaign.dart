import 'package:flutter/foundation.dart';

class Campaign with ChangeNotifier {
  final String id;
  final String campaignName;
  final String campaignDescription;
  final String imagesUrl;
  final String time;

  Campaign({
    this.id,
    @required this.campaignName,
    @required this.campaignDescription,
    this.imagesUrl,
    this.time,
  });
}