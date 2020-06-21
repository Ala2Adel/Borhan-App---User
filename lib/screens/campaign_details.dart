import 'package:Borhan_User/models/user_nav.dart';
import 'package:Borhan_User/notifiers/campaign_notifier.dart';
import 'package:Borhan_User/providers/shard_pref.dart';
import 'package:Borhan_User/screens/campaigns_donation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

class CampaignDetail extends StatefulWidget {
  @override
  _CampaignDetailState createState() => _CampaignDetailState();
}

class _CampaignDetailState extends State<CampaignDetail> {
  bool isFirstTime = true;

  CampaignNotifier campaignNotifier;
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => (Platform.isAndroid)
          ? AlertDialog(
              title: const Text('تسجيل دخول'),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: const Text('لا ارغب'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
                FlatButton(
                  child: const Text('موافق'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.pushNamed(context, '/Login');
                  },
                ),
              ],
            )
          : CupertinoAlertDialog(
              title: const Text('تسجيل دخول'),
              content: Text(message),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text("موافق"),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(ctx).pop();

                    Navigator.pushNamed(context, '/Login');
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('لا ارغب'),
                  onPressed: () => Navigator.of(ctx).pop(),
                )
              ],
            ),
    );
  }

  Future<UserNav> loadSharedPrefs() async {
    UserNav user;
    try {
      SharedPref sharedPref = SharedPref();
      user = UserNav.fromJson(await sharedPref.read("user"));
    } catch (Excepetion) {
      // do something
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstTime) {
      campaignNotifier = Provider.of<CampaignNotifier>(context, listen: false);
      isFirstTime = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(campaignNotifier.currentCampaign.campaignName),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child:
                    Image.network(campaignNotifier.currentCampaign.imagesUrl)),
            SizedBox(height: 30),
            Text(
              campaignNotifier.currentCampaign.campaignName,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              campaignNotifier.currentCampaign.campaignDescription,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                color: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  // side: BorderSide(
                  //     color:
                  //         Colors.white),
                ),
                onPressed: () async {
                  UserNav userLoad = await loadSharedPrefs();
                  if (userLoad == null) {
                    print("user is not here");
                    _showErrorDialog("برجاء تسجيل الدخول أولا");
                  } else {
                    print("user is  here");
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return CampaignDenotationScreen();
                    }));
                  }
                },
                child: Text(
                  'تبرع الآن',
                  style: TextStyle(fontSize: 21.0, color: Colors.white),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}