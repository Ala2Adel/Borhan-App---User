import 'package:Borhan_User/screens/my_donation_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDonationItem extends StatefulWidget {
  final String donationType;
   final String donationImage;
  final String donationItems;
  final String donationAmount;
  final String donationDate;
  final String orgName;
  final String actName;
  final String status;
  final String id;

  MyDonationItem({
    this.id,
    this.donationImage,
    this.status,
    this.donationType,
    this.donationItems,
    this.donationAmount,
    this.donationDate,
    this.orgName,
    this.actName,
  });

  @override
  _MyDonationItemState createState() => _MyDonationItemState();
}

class _MyDonationItemState extends State<MyDonationItem> {

  void showCustomDialogWithImage(BuildContext context) {
    Dialog dialogWithImage = Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
       //  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
        // height: 300.0,
        //  width: 300.0,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: Text(
                  "تفاصيل التبرع",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              AspectRatio(
                aspectRatio: 3 / 2,
                child: Image.network(
                 widget.donationImage,
                  fit: BoxFit.fill,
                ),
              ),
              ///////////////////////////////////////////////////////////////
              
              widget.orgName != '' && widget.orgName != null
                  ? Wrap(
                  crossAxisAlignment:WrapCrossAlignment.start,
                   alignment: WrapAlignment.start,
                      children: <Widget>[
                        Text(
                          'اسم الجمعية : ',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.orgName,
                          style: TextStyle(
                              color: Colors.green,
                               fontSize: 16.0,
                             ),
                        ),
                      ],
                    )
                  : Container(),
            Container(
              child: widget.actName != '' && widget.actName != null
                  ? Wrap(
                     crossAxisAlignment:WrapCrossAlignment.start,
                   alignment: WrapAlignment.start,
                      children: <Widget>[
                        Text(
                          'اسم النشاط : ',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.actName,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                             ),
                        ),
                      ],
                    )
                  : Container(),
            ),
            Container(
              child: widget.donationType != '' && widget.donationType != null
                  ? Wrap(
                     crossAxisAlignment:WrapCrossAlignment.start,
                   alignment: WrapAlignment.start,
                      children: <Widget>[
                        Text(
                          'نوع التبرع : ',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.donationType,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                             ),
                        ),
                      ],
                    )
                  : Container(),
            ),
            Container(
              child: widget.donationDate != '' && widget.donationDate != null
                  ? Wrap(
                     crossAxisAlignment:WrapCrossAlignment.start,
                   alignment: WrapAlignment.start,
                      children: <Widget>[
                        Text(
                          'التاريخ : ',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.donationDate,
                          style: TextStyle(
                              color: Colors.green,
                               fontSize: 16.0,
                              ),
                        ),
                      ],
                    )
                  : Container(),
            ),
            Container(
              child: widget.donationItems != '' && widget.donationItems != null
                  ? Wrap(
                     crossAxisAlignment:WrapCrossAlignment.start,
                   alignment: WrapAlignment.start,
                      children: <Widget>[
                        Text(
                          'وصف التبرع : ',
                          style: TextStyle(
                              color: Colors.green,
                               fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.donationItems,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                             ),
                        ),
                      ],
                    )
                  : Container(),
            ),
            Container(
              child: widget.donationAmount != '' && widget.donationAmount != null
                  ? Wrap(
                     crossAxisAlignment:WrapCrossAlignment.start,
                   alignment: WrapAlignment.start,
                      children: <Widget>[
                        Text(
                          'المبلغ : ',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                         widget.donationAmount,
                          style: TextStyle(
                              color: Colors.green,
                               fontSize: 16.0,
                             ),
                        ),
                      ],
                    )
                  : Container(),
            ),

              /////////////////////////////////////////////////////////////////////
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      // color: Colors.blue,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                        // side: BorderSide(
                        //     color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'حسنا',
                        style: TextStyle(fontSize: 18.0, color: Colors.green[900]),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // RaisedButton(
                  //   // color: Colors.red,
                  //   color: Colors.white,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: new BorderRadius.circular(24.0),
                  //     // side: BorderSide(
                  //     //     color: Colors.black),
                  //   ),
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  //   child: Text(
                  //     'تعديل',
                  //     style: TextStyle(fontSize: 18.0, color: Colors.green[900]),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => dialogWithImage);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: widget.orgName != '' && widget.orgName != null
                  ? Row(
                      children: <Widget>[
                        Text(
                          'اسم الجمعية : ',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.orgName,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Container(),
            ),
            Container(
              child: widget.actName != '' && widget.actName != null
                  ? Row(
                      children: <Widget>[
                        Text(
                          'اسم النشاط : ',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.actName,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Container(),
            ),
            // Container(
            //   child: donationType != '' && donationType != null
            //       ? Row(
            //           children: <Widget>[
            //             Text(
            //               'نوع التبرع : ',
            //               style: TextStyle(
            //                   color: Colors.green,
            //                   fontSize: 12.0,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //             Text(
            //               donationType,
            //               style: TextStyle(
            //                   color: Colors.green,
            //                   fontSize: 12.0,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         )
            //       : Container(),
            // ),
            // Container(
            //   child: donationDate != '' && donationDate != null
            //       ? Row(
            //           children: <Widget>[
            //             Text(
            //               'التاريخ : ',
            //               style: TextStyle(
            //                   color: Colors.green,
            //                   fontSize: 12.0,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //             Text(
            //               donationDate,
            //               style: TextStyle(
            //                   color: Colors.green,
            //                   fontSize: 12.0,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         )
            //       : Container(),
            // ),
            // Container(
            //   child: donationItems != '' && donationItems != null
            //       ? Row(
            //           children: <Widget>[
            //             Text(
            //               'وصف التبرع : ',
            //               style: TextStyle(
            //                   color: Colors.green,
            //                   fontSize: 12.0,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //             Text(
            //               donationItems,
            //               style: TextStyle(
            //                   color: Colors.green,
            //                   fontSize: 12.0,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         )
            //       : Container(),
            // ),
            // Container(
            //   child: donationAmount != '' && donationAmount != null
            //       ? Row(
            //           children: <Widget>[
            //             Text(
            //               'المبلغ : ',
            //               style: TextStyle(
            //                   color: Colors.green,
            //                   fontSize: 12.0,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //             Text(
            //               donationAmount,
            //               style: TextStyle(
            //                   color: Colors.green,
            //                   fontSize: 12.0,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         )
            //       : Container(),
            // ),
           

            /////////////////////////////////////////////////////////////
            Container(
              margin: EdgeInsets.all(10),
              child: Wrap(
                spacing: 10.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                   widget.status == 'waiting'
                  ? RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      child: Text(
                        'تعديل التبرع',
                        style: TextStyle(color: Colors.green[900]),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditDonation(
                                    reqId: widget.id,
                                  )),
                        );
                      },
                    )
//            IconButton(
//                    icon: Icon(Icons.edit),
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => EditDonation(
//                                  reqId: id,
//                                )),
//                      );
//                    },
//                    color: Colors.green,
//                  )
                  : Container(),
                  RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                    ),
                    child: Text(
                      ' التفاصيل',
                      style: TextStyle(color: Colors.green[900]),
                    ),
                    onPressed: () {
                     showCustomDialogWithImage(context);
                    },
                  ),
                ],
              ),
            )
            //////////////////////////////////////////////////////////////////
          ],
        ),
      ],
    );
  }
}
