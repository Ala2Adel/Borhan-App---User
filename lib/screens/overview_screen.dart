import 'dart:async';
import 'dart:io';

import 'package:Borhan_User/notifiers/campaign_notifier.dart';
import 'package:Borhan_User/notifiers/organization_notifier.dart';
import 'package:Borhan_User/screens/campaign_details.dart';
import 'package:Borhan_User/screens/fast_donation.dart';
import 'package:Borhan_User/screens/navigation_drawer.dart';
import 'package:Borhan_User/screens/organization_activities.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:connectivity/connectivity.dart';


import '../background.dart';
import 'Donation.dart';
import 'organization_details.dart';


import 'package:getflutter/getflutter.dart';

class OrgOverviewScreen extends StatefulWidget {
  @override
  _OrgOverviewScreenState createState() => _OrgOverviewScreenState();
  
}

class _OrgOverviewScreenState extends State<OrgOverviewScreen> {

// void chechNet() async{
//     var connectivityResult = await (Connectivity().checkConnectivity());
// if (connectivityResult == ConnectivityResult.mobile) {
//   print('4g');
//   // I am connected to a mobile network.
// } else if (connectivityResult == ConnectivityResult.wifi) {
//   print('wifi');
//   // I am connected to a wifi network.
// }
//   }

StreamSubscription connectivitySubscription;
ConnectivityResult _previousResult;
bool dialogShown = false;

 Future<bool> checkinternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Future.value(true);
      }
    } on SocketException catch (_) {
      return Future.value(false);
    }
  }




@override
void initState(){

 connectivitySubscription =    Connectivity().onConnectivityChanged.listen((ConnectivityResult connresult) {
    if(connresult == ConnectivityResult.none){
      dialogShown = true;
      showDialog(context: context,
      barrierDismissible: false,
      child: AlertDialog(
        title: const Text(
          'حدث خطأ ما '
        ),
        content: Text(
          'فقدنا الاتصال بالانترنت  ،\n تأكد من اتصالالك وحاول مرة أخرى'
        ),
        actions: <Widget>[
          FlatButton(onPressed: ()=>{
           
            SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
          
          }, child: Text('خروج ',style: TextStyle(color: Colors.red),))
        ],
      )
      );

    }else if (_previousResult == ConnectivityResult.none) {
        checkinternet().then((result) {
          if (result == true) {
          
            if (dialogShown == true) {
              dialogShown = false;
               print('-------------------------put your fix here ----------------------');
                getOrganizationsAndCampaign();

              Navigator.pop(context);
            }
          }
        });

    }
  _previousResult = connresult;

   });

}


@override
void dispose(){
  super.dispose();
connectivitySubscription.cancel();
}


  var _isLoading = false;
  var _isInit = true;

  var campaignNotifier ;
  var orgNotifier ;

  @override
  void didChangeDependencies() { 
    if (_isInit) {

      // setState(() {
      //   _isLoading = true;
      // });
      // Provider.of<OrganizationNotifier>(context).getOrganizations().then((_) {
      //   setState(() {
      //     _isLoading = false;
      //     print('in screen org view');
      //   });
      // });

      // Provider.of<CampaignNotifier>(context).fetchAndSetProducts().then((_) {
      //   setState(() {
      //     _isLoading = false;
      //   });
      // });

      campaignNotifier = Provider.of<CampaignNotifier>(context,listen: false);
      orgNotifier = Provider.of<OrganizationNotifier>(context ,listen: false);  
   ////////////////////////////////////////////////////
     getOrganizationsAndCampaign();
      ////////////////////////////////////
    }
    _isInit = false;
    super.didChangeDependencies();
  }
Future<void> getOrganizationsAndCampaign() async {
    setState(() {
        _isLoading = true;
      });
  
  await Provider.of<OrganizationNotifier>(context).getOrganizations();

  await Provider.of<CampaignNotifier>(context).fetchAndSetProducts();

        setState(() {
          _isLoading = false;
          //print('in screen org view');
        });
        
}
  //  @override
  // void initState() {
  
  //     campaignNotifier = Provider.of<CampaignNotifier>(context);
  //     orgNotifier = Provider.of<OrganizationNotifier>(context);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {

  

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    print('org notifier'); 

    print(orgNotifier);

    final headerList = new ListView.builder(
      itemBuilder: (context, index) {
        EdgeInsets padding = index == 0
            ? const EdgeInsets.only(
                left: 20.0, right: 10.0, top: 5.0, bottom: 15.0)
            : const EdgeInsets.only(
                left: 20.0, right: 10.0, top: 5.0, bottom: 15.0);

        return new Padding(
          padding: padding,
          child: new InkWell(
            onTap: () {
              print('Card selected');

              campaignNotifier.currentCampaign =
                  campaignNotifier.campaignList[index];

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return CampaignDetail();
              }));
            },
            child: new Container(
              decoration: new BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: new BorderRadius.circular(10.0),
                color: Colors.purple[100],
                boxShadow: [
                  new BoxShadow(
                      color: Colors.blueGrey.withAlpha(100),
                      offset: const Offset(3.0, 10.0),
                      blurRadius: 10.0)
                ],

                image: new DecorationImage(
                  image: new NetworkImage(
                      campaignNotifier.campaignList[index].imagesUrl),
                  fit: BoxFit.fitHeight,
                ),
              ),
              // height: 200.0,
              width: 150.0,
              child: new Stack(
                children: <Widget>[
                  new Align(
                    alignment: Alignment.bottomCenter,
                    child: new Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        decoration: new BoxDecoration(
                            color: Colors.purple[300],
                            borderRadius: new BorderRadius.only(
                                bottomLeft: new Radius.circular(10.0),
                                bottomRight: new Radius.circular(10.0))),
                        height: 35.0,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              campaignNotifier.campaignList[index].campaignName,
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 20,
                                  ),
                            )
                          ],
                         ),
                        ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: campaignNotifier.campaignList.length,
    );

    final body = new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'برهان',
          style: new TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
       // elevation: 0.0,
        backgroundColor:  Colors.purple[700],
      ),
      drawer: NavigationDrawer(),
      backgroundColor: Colors.transparent,
      body:
       _isLoading
          ?
           Center(
              child: CircularProgressIndicator(),
            
            )
          : new Container(
              child: new Stack(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.only(top: 0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

//                        new Align(
//                          alignment: Alignment.centerLeft,
//                          child: new Padding(
//                              padding: new EdgeInsets.all(20),
//                              child: new Text(
//                                'الحملات',
//                                style: new TextStyle(
//                                  color: Colors.white70,
//                                  fontSize: 26,
//                                ),
//                              )),
//                        ),

                    new Container(
                      height: 180.0,
                      child: new Carousel(
                        boxFit: BoxFit.cover,
                        images: [
                          AssetImage('assets/offers/Offer1.jpg'),
                          AssetImage('assets/offers/Offer2.jpg'),
                          AssetImage('assets/offers/Offer3.jpg'),
                          AssetImage('assets/offers/Offer4.jpg'),
                          AssetImage('assets/offers/Offer5.jpg'),
                        ],
                        autoplay: true,
                        animationCurve: Curves.fastLinearToSlowEaseIn,
                        animationDuration: Duration(milliseconds: 1500),
                        dotSize: 4.0,
                        indicatorBgPadding: 2.0,
                      ),
                    ),

                        new Container(
                            height: 150.0, width: _width, child: headerList),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width-50,
                          //width: 200,
                          height: 50.0,


                          child: Container(
                          //  margin: const EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                RaisedButton(
                                  color: Colors.purple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(24.0),
                                    side: BorderSide(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return FastDenotationScreen();
                                    }));
                                  },
                                  child: Text(
                                    'تبرع الآن',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        new Expanded(
                            child: ListView.builder(
                                itemCount: orgNotifier.orgList.length,
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: new BorderRadius.circular(20),
                                    child: Card(
                                      margin:
                                          EdgeInsets.fromLTRB(20, 5, 20, 5),
                                      color: Colors.purple[200],
                                      //padding: EdgeInsets.only(top: 20.0),
                                      child: new ListTile(
                                        contentPadding: EdgeInsets.fromLTRB(5, 5, 10, 0),
                                        title: new Column(
                                          children: <Widget>[
                                            new Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: new BoxDecoration(
                                                      // shape: BoxShape.circle,
                                                      borderRadius: BorderRadius.circular(5) ,
                                                      color: Colors.lightBlueAccent,
                                                      boxShadow: [
                                                        new BoxShadow(
                                                            color: Colors.blueGrey.withAlpha(70),
                                                            offset:
                                                                const Offset(
                                                                    2.0, 2.0),
                                                            blurRadius: 2.0)
                                                      ],
                                                      image:
                                                          new DecorationImage(
                                                        image: orgNotifier
                                                                        .orgList[
                                                                            index]
                                                                        .logo !=
                                                                    null &&
                                                                orgNotifier
                                                                        .orgList[
                                                                            index]
                                                                        .logo !=
                                                                    ""
                                                            ? new NetworkImage(
                                                                orgNotifier
                                                                    .orgList[
                                                                        index]
                                                                    .logo)
                                                            : NetworkImage(
                                                                'https://img2.arabpng.com/20171128/5d2/gold-soccer-ball-png-clip-art-image-5a1d466b159ac0.0656563615118680110885.jpg'),
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                new SizedBox(
                                                  width: 10.0,
                                                ),
                                                new Expanded(
                                                    child: new Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    new Text(
                                                      orgNotifier.orgList[index]
                                                                  .orgName !=
                                                              null
                                                          ? orgNotifier
                                                              .orgList[index]
                                                              .orgName
                                                          : 'no value',
                                                      style: new TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    new Text(
                                                      orgNotifier.orgList[index]
                                                          .description,
                                                      style: new TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    Wrap(
//                                                      mainAxisAlignment:
//                                                          MainAxisAlignment
//                                                              .spaceEvenly,
                                                    crossAxisAlignment: WrapCrossAlignment.center,
                                                      children: <Widget>[
                                                        FlatButton(
                                                          // color: Colors.deepOrangeAccent[100],
                                                          // shape:
                                                          //     RoundedRectangleBorder(
                                                          //   borderRadius:
                                                          //       new BorderRadius
                                                          //               .circular(
                                                          //           18.0),
                                                          //   side: BorderSide(
                                                          //       color: Colors
                                                          //           .black),
                                                          // ),
                                                          onPressed: () {
                                                            orgNotifier
                                                                    .currentOrganization =
                                                                orgNotifier
                                                                        .orgList[
                                                                    index];

                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(builder:
                                                                    (BuildContext
                                                                        context) {
                                                              return OrganizationDetails( orgNotifier.orgList[index]);
                                                              },
                                                             ),
                                                            );
                                                          },
                                                          child: Text(
                                                            'التفاصيل',
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        FlatButton(
                                                          // splashColor: Colors.yellow[200],
                                                          // color: Colors
                                                          //     .amberAccent,
                                                          // shape:
                                                          //     RoundedRectangleBorder(
                                                          //   borderRadius:
                                                          //       new BorderRadius
                                                          //               .circular(
                                                          //           18.0),
                                                          //   side: BorderSide(
                                                          //       color: Colors
                                                          //           .black),
                                                          // ),
                                                          onPressed: () {
                                                            orgNotifier
                                                                    .currentOrganization =
                                                                orgNotifier
                                                                        .orgList[
                                                                    index];

                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(builder:
                                                                    (BuildContext
                                                                        context) {
                                                              print("Over view Screen " +
                                                                  orgNotifier
                                                                      .orgList[
                                                                          index]
                                                                      .id);
                                                              return OrganizationActivity(
                                                                  orgNotifier
                                                                      .orgList[
                                                                          index]
                                                                      .id);
                                                              },
                                                             ),
                                                            );
                                                          },
                                                          child: Text(
                                                            'الانشطة',
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
//                                                        Icon(
//                                                          Icons.favorite,
//                                                          color:
//                                                              Colors.redAccent,
//                                                          size: 30.0,
//                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )),
                                              ],
                                            ),
                                            //  new Divider( height: 20,color: Colors.green,),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );

                                  ///////////////////////////////////////////////
                                  
  //                            return    
  //   GFCard(
  //   boxFit: BoxFit.fill,
  //   margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
  //   image: Image.network(orgNotifier.orgList[index].logo ,height: 120,
  //   fit: BoxFit.cover,
  //   ),
  //   title: GFListTile(
  //    //  avatar: GFAvatar(),
  //      padding: EdgeInsets.all(2),
  //      title: Text(orgNotifier.orgList[index].orgName,
  //      style:TextStyle(
  //         fontSize: 19,
  //         fontWeight: FontWeight.bold
  //        ) ,
  //      ),
  //      subTitle: Text(orgNotifier.orgList[index].description,
  //         style:TextStyle(
  //         fontSize: 17,
  //         color: Colors.black
  //        ) ,
  //        maxLines: 1,
  //      ),
  //    //  color: Colors.purple[300].withOpacity(0.75),
  //      margin: EdgeInsets.all(0),
  //    ),
  //    padding: EdgeInsets.all(0),
  //   //content: Text("GFCards has three types of cards i.e, basic, with avataras and with overlay image"),
  //    buttonBar: GFButtonBar( 
  //    //alignment: MainAxisAlignment.center,
    
  //    padding: EdgeInsets.symmetric(horizontal: 5 ,vertical: 5),

  //    children: <Widget>[
  //    GFButton(
  //      onPressed: () {
  //          orgNotifier.currentOrganization =orgNotifier.orgList[index];
  //          Navigator.of( context)
  //          .push(MaterialPageRoute(builder:(BuildContext context) 
  //          {
  //            return OrganizationDetails(orgNotifier.orgList[index]);  
  //           },
  //          ),
  //        );
  //      },
  //      text: 'التفاصيل',
  //      color: Colors.purple,
  //      ),
  //      GFButton(
  //      onPressed: () {
  //      orgNotifier.currentOrganization =orgNotifier.orgList[index];
  //      Navigator.of(context)
  //     .push(MaterialPageRoute(builder:(BuildContextcontext)
  //     {
  //     print("Over view Screen " + orgNotifier.orgList[index].id);
  //     return OrganizationActivity(orgNotifier.orgList[ index].id);
  //      },
  //     ),
  //                                                           );
  //    },
  //      text: 'الأنشطة',
  //       color: Colors.purple,
  //      )
  //     ],
  //    ),
  //  );
                                  ///////////////////////////////////////////////
                                  },
                                 ),
                                ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );

    return new Container(
      decoration: new BoxDecoration(
       color: Colors.white,
      ),
      child: new Stack(
        children: <Widget>[
          new CustomPaint(
            size: new Size(_width, _height),
            painter: new Background(),
          ),
          body,
        ],
      ),
    );
  }
}
