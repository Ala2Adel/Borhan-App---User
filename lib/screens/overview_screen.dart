import 'package:Borhan_User/notifiers/campaign_notifier.dart';
import 'package:Borhan_User/notifiers/organization_notifier.dart';
import 'package:Borhan_User/screens/Donation_mainScreen.dart';
import 'package:Borhan_User/screens/campaign_details.dart';
import 'package:Borhan_User/screens/fast_donation.dart';
import 'package:Borhan_User/screens/navigation_drawer.dart';
import 'package:Borhan_User/screens/organization_activities.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import '../background.dart';
import 'Donation.dart';
import 'organization_details.dart';

class OrgOverviewScreen extends StatefulWidget {
  @override
  _OrgOverviewScreenState createState() => _OrgOverviewScreenState();
}

class _OrgOverviewScreenState extends State<OrgOverviewScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<OrganizationNotifier>(context).getOrganizations().then((_) {
        setState(() {
          _isLoading = false;
          print('in screen org view');
        });
      });

      Provider.of<CampaignNotifier>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final campaignNotifier = Provider.of<CampaignNotifier>(context);
    final orgNotifier = Provider.of<OrganizationNotifier>(context);

    print('org notifier');

    print(orgNotifier);

    final headerList = new ListView.builder(
      itemBuilder: (context, index) {
        EdgeInsets padding = index == 0
            ? const EdgeInsets.only(
                left: 20.0, right: 10.0, top: 5.0, bottom: 30.0)
            : const EdgeInsets.only(
                left: 20.0, right: 10.0, top: 5.0, bottom: 30.0);

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
                color: Colors.lightBlueAccent,
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
                            color: const Color(0xFF273A48),
                            borderRadius: new BorderRadius.only(
                                bottomLeft: new Radius.circular(10.0),
                                bottomRight: new Radius.circular(10.0))),
                        height: 25.0,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              campaignNotifier.campaignList[index].campaignName,
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 20),
                            )
                          ],
                        )),
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
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      drawer: NavigationDrawer(),
      backgroundColor: Colors.transparent,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : new Container(
              child: new Stack(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.only(top: 10.0),
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
                      height: 200.0,
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
                          minWidth: MediaQuery.of(context).size.width,
                          //width: 200,
                          height: 50.0,


                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RaisedButton(
                                color: Colors.greenAccent,
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
                                      fontSize: 20.0, color: Colors.black),
                                ),
                              ),
                            ],
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
                                          EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      color: Colors.blueGrey.withAlpha(500),
                                      //padding: EdgeInsets.only(top: 20.0),
                                      child: new ListTile(
                                        contentPadding: EdgeInsets.all(8.0),
                                        title: new Column(
                                          children: <Widget>[
                                            new Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Container(
                                                  height: 120.0,
                                                  width: 120.0,
                                                  decoration: new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors
                                                          .lightBlueAccent,
                                                      boxShadow: [
                                                        new BoxShadow(
                                                            color: Colors
                                                                .blueGrey
                                                                .withAlpha(70),
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
                                                          fontSize: 20.0,
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
                                                        RaisedButton(
                                                          color: Colors
                                                                  .deepOrangeAccent[
                                                              100],
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    18.0),
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .black),
                                                          ),
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
                                                              return OrganizationDetails();
                                                            }));
                                                          },
                                                          child: Text(
                                                            'التفاصيل',
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        RaisedButton(
                                                          splashColor: Colors
                                                              .yellow[200],
                                                          color: Colors
                                                              .amberAccent,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    18.0),
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .black),
                                                          ),
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
                                                            }));
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
                                }))
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );

    return new Container(
      decoration: new BoxDecoration(
        color: const Color(0xFF273A48),
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
