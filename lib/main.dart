import 'package:Borhan_User/notifiers/campaign_notifier.dart';
import 'package:Borhan_User/screens/Notification_screen.dart';
import 'package:Borhan_User/screens/donation_history.dart';
import 'package:Borhan_User/screens/favourite_screen.dart';
import 'package:Borhan_User/screens/overview_screen.dart';
import 'package:Borhan_User/screens/profile_screen.dart';
import 'package:Borhan_User/screens/support_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import  'package:Borhan_User/screens/login_screen.dart';
import  'package:Borhan_User/screens/signup_screen.dart';

import 'models/campaign.dart';

void main() => runApp(
    MultiProvider(
  providers: [
    ChangeNotifierProvider(builder: (context)=> CampaignNotifier(),)
  ],
  child: MyApp(),
  )
//    MyApp()

);


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      builder: (BuildContext context, Widget child) {
              return new Directionality(
                textDirection: TextDirection.rtl,
                child: new Builder(
                  builder: (BuildContext context) {
                    return new MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                            textScaleFactor: 1.0,
                          ),
                      child: child,
                    );
                  },
                ),
              );
            },
        title: 'Borhan',
        theme: new ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Consumer<CampaignNotifier>(builder: (context, notifier, child) {
          return OrgOverviewScreen();
        }),
        routes:{
          '/DonationHistory': (context) => DonationHistory(),
          '/Favourite': (context) => Favourite(),
          '/Home': (context) => OrgOverviewScreen(),
          '/Notifications': (context) => Notifications(),
          '/Login': (context) => LoginScreen(),
          '/Profile': (context) => Profile(),
          '/Support': (context) => Support(),
        }

    );
  }
}


//class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() {
//    return _MyHomePageState();
//  }
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: new Text('برهان'),
//      leading: Icon(Icons.list )),
//
//      body:
//      _buildBody(context),
//    );
//  }
//
//  Widget _buildBody(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.collection('campaigns').snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) return LinearProgressIndicator();
//        return
//          //_buildList(context, snapshot.data.documents);
//
//          Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Container(
//                height: 100.0,
//                child: ListView.builder(
//                  itemCount: snapshot.data.documents.length,
//                  scrollDirection: Axis.horizontal,
//                  itemBuilder: (context, position) {
//                    return GestureDetector(
//                      child: Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Card(
//                          child: Container(
//                            width: 150.0,
//                            child: Column(
//                              crossAxisAlignment:
//                              CrossAxisAlignment.start,
//                              mainAxisAlignment:
//                              MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: Column(
//                                    crossAxisAlignment:
//                                    CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Padding(
//                                        padding: const EdgeInsets
//                                            .symmetric(
//                                            horizontal: 8.0,
//                                            vertical: 4.0),
//                                        child:
//
//                                        Text(
//                                            '${snapshot.data
//                                                .documents[position]['Name']}',
//                                            style: TextStyle(
//                                                color: Colors.black)),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          shape: RoundedRectangleBorder(
//                              borderRadius:
//                              BorderRadius.circular(10.0)),
//                        ),
//                      ),
//                    );
//                  },
//                ),
//              )
//            ],
//          );
//     },
//    );
//  }
//
//  Widget horizontalList1 = new Container(
//      margin: EdgeInsets.symmetric(vertical: 20.0),
//      height: 200.0,
//      child: new ListView(
//
//       // children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//        scrollDirection: Axis.horizontal,
//        children: <Widget>[
//          Container(width: 100.0, color: Colors.red,),
//          Container(width: 100.0, color: Colors.orange,),
//          Container(width: 100.0, color: Colors.pink,),
//          Container(width: 100.0, color: Colors.yellow,),
//        ],
//      )
//  );
//
//  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//    return Container(
//        child: ListView(
//          //  children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//          scrollDirection: Axis.vertical,
//
//          children: <Widget>[
//            horizontalList1,
//
////      padding: const EdgeInsets.only(top: 20.0),
//
//          ]
//    ));
//  }
//
//  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//    final record = Campaigns.fromSnapshot(data);
//
//    return Padding(
//      key: ValueKey(record.Name),
//      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//      child: Container(
//        decoration: BoxDecoration(
//          border: Border.all(color: Colors.grey),
//          borderRadius: BorderRadius.circular(10.0),
//        ),
//        child: ListTile(
//          title: Text(record.Name),
//          trailing: Text(record.votes.toString()),
//          onTap: () => print(record),
//        ),
//      ),
//    );
//  }
//}
//
//class Campaigns {
//  final String Name;
//  final int votes;
//  final DocumentReference reference;
//
//  Campaigns.fromMap(Map<String, dynamic> map, {this.reference})
//      : assert(map['Name'] != null),
//        assert(map['votes'] != null),
//        Name = map['Name'],
//        votes = map['votes'];
//
//  Campaigns.fromSnapshot(DocumentSnapshot snapshot)
//      : this.fromMap(snapshot.data, reference: snapshot.reference);
//
//  @override
//  String toString() => "Record<$Name:$votes>";
//}
