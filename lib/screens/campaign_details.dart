import 'package:Borhan_User/notifiers/campaign_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CampaignDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CampaignNotifier campaignNotifier =
        Provider.of<CampaignNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(campaignNotifier.currentCampaign.name),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.network(campaignNotifier.currentCampaign.image),
            SizedBox(
                height: 20),
            Text(
              campaignNotifier.currentCampaign.name,
              style: TextStyle(
                  fontSize: 24),
            ),
            Text(
              campaignNotifier.currentCampaign.description,
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
            )
          ],
          //  children: <Widget>[Text("تفاصيل الحملة")],
        ),
      ),
    );
  }
}
