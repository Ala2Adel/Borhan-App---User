import 'package:Borhan_User/notifiers/activity_notifier.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localizations.dart';

class Donation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ActivityNotifier activityNotifier =
        Provider.of<ActivityNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(activityNotifier.currentActivity.name != null
            ? activityNotifier.currentActivity.name
            : AppLocalizations.of(context).translate('Donate_Now_String')),
      ),
      body: Center(),
    );
  }
}
