import 'dart:ui';

import 'package:Borhan_User/api/campaign_api.dart';
import 'package:Borhan_User/notifiers/campaign_notifier.dart';
import 'package:Borhan_User/screens/campaign_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class OrgOverviewScreen extends StatefulWidget {
  @override
  _OrgOverviewScreenState createState() => _OrgOverviewScreenState();
}

class _OrgOverviewScreenState extends State<OrgOverviewScreen> {
  @override
  void initState() {
    CampaignNotifier campaignNotifier =
        Provider.of<CampaignNotifier>(context, listen: false);
//   //retriever campaign list from firestore
    getCampaigns(campaignNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CampaignNotifier campaignNotifier =
        Provider.of<CampaignNotifier>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("برهان"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.list),
                onPressed: () {
                  print('Icon Button was Pressed');
                }),
          ],
        ),

        body: Column(

          children: <Widget>[
            Container(
              height:150 ,


     //      child: Expanded(
             
             
          child: ListView.builder(


              scrollDirection: Axis.horizontal,

              itemCount: campaignNotifier.campaignList.length,
              itemBuilder: (context, index) {
                return
                  GestureDetector(
                    onTap: (){
                      campaignNotifier.currentCampaign = campaignNotifier.campaignList[index];
                      //print(campaignNotifier.campaignList[index].name);
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                        return CampaignDetail();
                      }
                      ));
                    },
                 // width: MediaQuery.of(context).size.width* 0.45,
                  //child: Card(
                   // color: Colors.white10,
                    child: Container(

                          width: 150,
                         padding: EdgeInsets.all(6.0),
                         child: CircleAvatar(

                          backgroundImage: NetworkImage(
                        campaignNotifier.campaignList[index].image,),
                     //   style: TextStyle(color: Colors.white, fontSize: 20.0),
                       // height: 120,
                    ),
                    //)

                  )
                );
              }),
          ),

Expanded (child: ListView.builder(
          itemBuilder: (BuildContext context, int index){
            return Card(
              margin: EdgeInsets.all(25.5),
              child: ListTile(

                contentPadding: EdgeInsets.all(20.0),
              title: Text(campaignNotifier.campaignList[index].name),
              subtitle: Text(campaignNotifier.campaignList[index].description),
                 // trailing: IconButton(icon: Icon(Icons.favorite), onPressed: () {})

                trailing: Column(
                    children: <Widget>[
                CircleAvatar(

                backgroundColor: Colors.lightBlueAccent,
                child: IconButton(
                  icon: Icon(Icons.description), onPressed: () {  },

                )
                ),



                  ],
                )


              ));
          },
        itemCount: campaignNotifier.campaignList.length,
//        separatorBuilder: (BuildContext context, int index) {
//            return Divider(
//             // color: Colors.black,
//            );
//        },
          )


        ),
    ],
    )
    );
  }
}
