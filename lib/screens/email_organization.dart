import 'package:Borhan_User/notifiers/organization_notifier.dart';
import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/screens/chat_screen.dart';
import 'package:Borhan_User/screens/email_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailOrganization extends StatefulWidget {
  static const routeName = '/emailOrg';

  @override
  _EmailOrganizationState createState() => _EmailOrganizationState();
}

class _EmailOrganizationState extends State<EmailOrganization> {
  var _isInit = true;
  var _isLoading = false;

//  String currentUserId = '1212145f';
//String currentUserId ='M8CoA0TH86hmKSikh1K';
  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<OrganizationNotifier>(context)
          .getOrganizations()
          .then((_) => {
                print('from provider'),
                setState(() {
                  _isLoading = false;
                }),
              });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final allOrg = Provider.of<OrganizationNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدعم بواسطة البريد الإلكتروني'),
      ),
      body: WillPopScope(
        child: Stack(
          children: <Widget>[
            Container(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) => buildItem(
                          context,
                          allOrg.orgList[index].orgName,
                          allOrg.orgList[index].email,
                          allOrg.orgList[index].logo),
                      itemCount: allOrg.orgList.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(
      BuildContext context, String orgName, String email, String img) {
    if (orgName == null) {
      return Container();
    } else {
//      print("documents"+documents.toString());
      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                child: Material(
                  child: Image.network(img),
//                Icon(
//                  Icons.account_circle,
//                  size: 50.0,
//                ),

                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  clipBehavior: Clip.hardEdge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          orgName,
                          style: TextStyle(color: Colors.teal),
                        ),
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EmailScreen(email)));
          },

//              () {
//            Navigator.of(context)
//                .pushNamed(EmailScreen.routeName, arguments: email);
//          },
          padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: const EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }
}
