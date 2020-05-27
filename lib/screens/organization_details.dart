
import 'package:Borhan_User/notifiers/organization_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              ? orgNotifier.currentOrg.orgName : 'no value',),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(child: Image.network(orgNotifier.currentOrg.logo)),
              SizedBox(
                  height: 50),
              Text(
                "الوصف: "+orgNotifier.currentOrg.description,
                style: TextStyle(
                    fontSize: 24),
              ),
//              Text(
//                orgNotifier.currentOrg.licenseNo,
//                style: TextStyle(
//                    fontSize: 20,
//                    fontStyle: FontStyle.italic),
//              ),
//              Text(
//                orgNotifier.currentOrg.landLineNo,
//                style: TextStyle(
//                    fontSize: 20,
//                    fontStyle: FontStyle.italic),
//              ),
              Text(
                orgNotifier.currentOrg.mobileNo,
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              )
            ],
          ),
        ),
      );
    }
}
