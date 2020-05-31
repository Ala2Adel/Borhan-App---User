import 'package:Borhan_User/notifiers/organization_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganizationDetails extends StatelessWidget {
  //static const routeName = '/orgDetails';

  @override
  Widget build(BuildContext context) {
    OrganizationNotifier orgNotifier =
        Provider.of<OrganizationNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          orgNotifier.currentOrg.orgName != null
              ? orgNotifier.currentOrg.orgName
              : 'no value',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(child: Image.network(orgNotifier.currentOrg.logo)),
//            Text(
//              "الوصف: " + orgNotifier.currentOrg.description,
//              style: TextStyle(fontSize: 20),
//            ),

            Text(
              "رقم الرخصة: " + orgNotifier.currentOrg.licenseNo,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Text(
              "رقم الهاتف الأرضي : " + orgNotifier.currentOrg.landLineNo,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Text(
              "رقم الهاتف المحمول: " + orgNotifier.currentOrg.mobileNo,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Text(
              "العنوان: " + orgNotifier.currentOrg.address,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Text(
              "تفاصيل الحساب المصرفي :",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Text(
              orgNotifier.currentOrg.bankAccounts,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Text(
              "رابط صفحة الإنترنت: ",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: InkWell(
                  onTap: () => launch(orgNotifier.currentOrg.webPage),
                  child: Text(
                    orgNotifier.currentOrg.webPage,
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
