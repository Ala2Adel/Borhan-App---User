import 'package:Borhan_User/models/user_nav.dart';
import 'package:Borhan_User/notifiers/campaign_notifier.dart';
import 'package:Borhan_User/providers/shard_pref.dart';
import 'package:Borhan_User/screens/campaigns_donation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
         backgroundColor: Colors.green,  ),
      body:

     //   child: Column(
         Card(
        margin: EdgeInsets.only(top:10 ,left: 20, right: 20, bottom: 5),
        elevation: 8, shadowColor: Colors.grey[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),

     // child: Column(
          //  children: <Widget>[
//            Expanded(
//                child:
//                    Image.network(campaignNotifier.currentCampaign.imagesUrl)),
           //   Expanded(

               child: SingleChildScrollView(

                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
               //   child: ConstrainedBox(
               //     constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),


                    child: Column(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,

                      children: <Widget>[

                            Flexible(child: Image.network(campaignNotifier.currentCampaign.imagesUrl)),

                           Flexible(
                             child: Text(campaignNotifier.currentCampaign.campaignName,
                               style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                           ),

                        SizedBox(height: 2),

                                Flexible(
                                  child: Text(campaignNotifier.currentCampaign.campaignDescription,
                                     style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.grey),

                               ),
                                ),
                        SizedBox(height: 120),
                             RaisedButton(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),

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
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                            ),
                        SizedBox(height: 10),



//                      Row(
//
//                        children: <Widget>[
//                          Spacer(),
//                          //Spacer(),
//                          Transform.translate(
//                            offset: Offset(120 , -15),
//                            child:           RaisedButton(
//                              color: Colors.green,
//                              shape: RoundedRectangleBorder(
//                                borderRadius: new BorderRadius.circular(5.0),
//
//                              ),
//                              onPressed: () async {
//                                UserNav userLoad = await loadSharedPrefs();
//                                if (userLoad == null) {
//                                  print("user is not here");
//                                  _showErrorDialog("برجاء تسجيل الدخول أولا");
//                                } else {
//                                  print("user is  here");
//                                  Navigator.of(context).push(
//                                      MaterialPageRoute(builder: (BuildContext context) {
//                                        return CampaignDenotationScreen();
//                                      }));
//                                }
//                              },
//                              child: Text(
//                                'تبرع الآن',
//                                style: TextStyle(fontSize: 21.0, color: Colors.white),
//                              ),
//                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
//                            ),
//                          ),
//                          SizedBox(width: 16),
//                        ],
//                      )
                      ],
                    ),
                  ),
                ),
      );
      //);
      //      ], )
            //  ),
            //),

        //),
     // ),
  //  );
  }
}
