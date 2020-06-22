import 'package:Borhan_User/models/organization.dart';
import 'package:Borhan_User/notifiers/organization_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class OrganizationDetails extends StatelessWidget {

    OrganizationNotifier orgNotifier;
    Organization currentOrg;
    OrganizationDetails(this.currentOrg);


   @override
  Widget build(BuildContext context) {
   
    return Scaffold( 
      appBar: AppBar(
        title: Text(
         currentOrg.orgName != null
              ? currentOrg.orgName
              : 'no value',
        ),
        backgroundColor:  Colors.green[900],
        
      ),
      body: SingleChildScrollView(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(child: Hero( tag:'imageHero',child: Flexible(child: Image.network(currentOrg.logo))),
            onTap: (){
              Navigator.pop(context);
            }),


            Text(
              "رقم الرخصة: " + currentOrg.licenseNo,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Text(
              "رقم الهاتف الأرضي : " + currentOrg.landLineNo,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Text(
              "رقم الهاتف المحمول: " + currentOrg.mobileNo,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Text(
              "العنوان: " + currentOrg.address,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Text(
              "تفاصيل الحساب المصرفي :",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Text(
             currentOrg.bankAccounts,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Text(
              "رابط صفحة الإنترنت: ",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: InkWell(
                  onTap: () => launch(currentOrg.webPage),
                  child: Text(
                   currentOrg.webPage,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
