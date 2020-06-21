import 'package:Borhan_User/screens/my_donation_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDonationItem extends StatelessWidget {
  final String donationType;
  final String donationItems;
  final String donationAmount;
  final String donationDate;
  final String orgName;
  final String actName;
  final String status;
  final String id;

  MyDonationItem({
    this.id,
    this.status,
    this.donationType,
    this.donationItems,
    this.donationAmount,
    this.donationDate,
    this.orgName,
    this.actName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: orgName != '' && orgName != null
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
                          orgName,
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
              child: actName != '' && actName != null
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
                          actName,
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
              child: donationType != '' && donationType != null
                  ? Row(
                      children: <Widget>[
                        Text(
                          'نوع التبرع : ',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          donationType,
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
              child: donationDate != '' && donationDate != null
                  ? Row(
                      children: <Widget>[
                        Text(
                          'التاريخ : ',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          donationDate,
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
              child: donationItems != '' && donationItems != null
                  ? Row(
                      children: <Widget>[
                        Text(
                          'وصف التبرع : ',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          donationItems,
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
              child: donationAmount != '' && donationAmount != null
                  ? Row(
                      children: <Widget>[
                        Text(
                          'المبلغ : ',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          donationAmount,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Container(),
            ),
            status == 'waiting'
                ?
                RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(24.0),
                  ),
                  child: Text('تعديل التبرع',style: TextStyle(color: Colors.green[900]),),
                  onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditDonation(
                          reqId: id,
                        )),
                  );
                },)
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
          ],
        ),
      ],
    );
  }
}
