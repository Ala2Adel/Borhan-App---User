import 'package:Borhan_User/notifiers/activity_notifier.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Donation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ActivityNotifier activityNotifier =
        Provider.of<ActivityNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(activityNotifier.currentActivity.name != null
            ? activityNotifier.currentActivity.name
            : 'تبرع الآن'),
      ),
      body: Center(),
    );
  }
}