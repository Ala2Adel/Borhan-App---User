import 'package:flutter/foundation.dart';

class Activity with ChangeNotifier {
  final String id;
  final String name;
  final String image;
  final String description;
  final String orgId;
  bool isFavorite;

  Activity({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.description,
    this.isFavorite = false,
    this.orgId,
  });
}
