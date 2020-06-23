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
      appBar: AppBar(
        title: const Text('تبرعاتي'),
        backgroundColor: Colors.green,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
           :historyData.items.length==0? 
           Center(
            child: const Text('لا توجد تبرعات حاليا'
            ,style: TextStyle(
              fontSize: 19,
            ),),
          )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: historyData.items.length,
              itemBuilder: (_, i) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: FittedBox(
                        child: Row(
                          children: <Widget>[
                            Material(
//                              color: Colors.purple[400],
//                            color: Colors.green[300],
                              elevation: 14.0,
                              borderRadius: BorderRadius.circular(10.0),
                              child: Column(children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 80,
                                        height: MediaQuery.of(context).size.width/3,
//                                      height: 100,
                                        child: ClipRRect(
                                          borderRadius:
                                              new BorderRadius.circular(10.0),
                                          child: historyData.items[i].image !=
                                                      '' &&
                                                  historyData.items[i].image !=
                                                      null
                                              ? Image(
                                                  fit: BoxFit.fill,
                                                  alignment: Alignment.centerLeft,
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
                                                        elevation: 2.0,
                                                  color: Colors.green[100],
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
//                                                                  color: Colors.green,
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
                                                                ? const Text(
                                                                    'قيد المراجعة',
                                                                    style: TextStyle(
                                                                        color: Colors.orange,
                                                                        fontSize:
                                                                            18.0,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                : historyData
                                                                            .items[i]
                                                                            .status ==
                                                                        'done'
                                                                    ? const Text(
                                                                        'تم قبول التبرع',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .green,
                                                                            fontSize:
                                                                                18.0,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      )
                                                                    : const Text(
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
                                                  status: historyData.items[i].status,
                                                  id: historyData.items[i].id,
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