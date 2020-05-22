import 'package:Borhan_User/notifiers/campaign_notifier.dart';
import 'package:Borhan_User/notifiers/organization_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Donation extends StatelessWidget {
 // static const routeName = '/donation';

  @override
  Widget build(BuildContext context) {
//
//    OrganizationNotifier orgNotifier =
//    Provider.of<OrganizationNotifier>(context, listen: false);
    return Scaffold(

      appBar: AppBar(
        title: Text('Donation Page'),
      ),
      backgroundColor: Color.fromRGBO(65, 41, 106, 0.5),
      body: Center(
        child: Image.asset('assets/burhan.jpg', width : MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,),
      ),
    );
  }
}
