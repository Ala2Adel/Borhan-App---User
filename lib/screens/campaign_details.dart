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
        title: Text(campaignNotifier.currentCampaign.campaignName),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.network(campaignNotifier.currentCampaign.imagesUrl),
            SizedBox(
                height: 30),
            Text(
              campaignNotifier.currentCampaign.campaignName,
              style: TextStyle(
                  fontSize: 24),
            ),
            Text(
              campaignNotifier.currentCampaign.campaignDescription,
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
            )
          ],
        ),
      ),
    );
  }
}
