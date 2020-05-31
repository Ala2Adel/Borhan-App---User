import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/providers/mydonation_provider.dart';
import 'package:Borhan_User/widgets/my_donation_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDonationsScreen extends StatefulWidget {
  static const routeName = '/myDonations';

  @override
  _MyDonationsState createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonationsScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final data = Provider.of<Auth>(context);
      Provider.of<MyDonationsProvider>(context, listen: true)
          .fetchAndSetDonations(data.userData.id)
          .then((value) => {
                setState(() {
                  _isLoading = false;
                }),
              });
      setState(() {
        _isLoading = true;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final historyData = Provider.of<MyDonationsProvider>(context);
    return Scaffold(
//      backgroundColor: Colors.indigo[400],
      appBar: AppBar(
        title: Text('تبرعاتي'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: historyData.items.length,
              itemBuilder: (_, i) {
                return Container(
//                  color: Colors.indigo[100],
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: FittedBox(
                        child: Row(
                          children: <Widget>[
                            Material(
                              color: Colors.indigo[400],
                              elevation: 14.0,
                              borderRadius: BorderRadius.circular(24.0),
//                        shadowColor: Color(0x802196F3),
                              child: Column(children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 80,
                                        height: 100,
                                        child: ClipRRect(
                                          borderRadius:
                                              new BorderRadius.circular(24.0),
                                          child: historyData.items[i].image !=
                                                      '' &&
                                                  historyData.items[i].image !=
                                                      null
                                              ? Image(
                                                  fit: BoxFit.fill,
                                                  alignment: Alignment.topLeft,
                                                  image: NetworkImage(
                                                    historyData.items[i].image,
                                                  ),
                                                )
                                              : Image(
                                                  fit: BoxFit.fill,
                                                  alignment: Alignment.topLeft,
                                                  image: NetworkImage(
                                                    "https://cutt.ly/zyTkoxi",
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, right: 10.0, left: 10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0),
                                                ),
                                                historyData.items[i].status !=
                                                            null &&
                                                        historyData.items[i]
                                                                .status !=
                                                            ''
                                                    ? Material(
//                                                  color: Colors.indigo[50],
                                                        elevation: 2.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              'حالة التبرع : ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .indigo,
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            historyData.items[i]
                                                                            .status !=
                                                                        'done' &&
                                                                    historyData
                                                                            .items[
                                                                                i]
                                                                            .status !=
                                                                        'cancel'
                                                                ? Text(
                                                                    'قيد المراجعة',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .yellow,
                                                                        fontSize:
                                                                            18.0,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                : historyData
                                                                            .items[i]
                                                                            .status ==
                                                                        'done'
                                                                    ? Text(
                                                                        'تم قبول التبرع',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .green,
                                                                            fontSize:
                                                                                18.0,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      )
                                                                    : Text(
                                                                        'تم رفض التبرع',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .red,
                                                                            fontSize:
                                                                                18.0,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2.0),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                MyDonationItem(
                                                  orgName: historyData
                                                      .items[i].orgName,
                                                  donationType: historyData
                                                      .items[i].donationType,
                                                  actName: historyData
                                                      .items[i].actName,
                                                  donationItems: historyData
                                                      .items[i].donationItems,
                                                  donationDate: historyData
                                                      .items[i].donationDate,
                                                  donationAmount: historyData
                                                      .items[i].donationAmount,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
