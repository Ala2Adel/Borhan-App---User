import 'package:Borhan_User/notifiers/organization_notifier.dart';
import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/screens/chat_screen.dart';
import 'package:Borhan_User/screens/firestore_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelpOrganization extends StatefulWidget {
  static const routeName = '/helpOrg';
  @override
  _HelpOrganizationState createState() => _HelpOrganizationState();
}

class _HelpOrganizationState extends State<HelpOrganization> {
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
    final allUsers = Provider.of<OrganizationNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('المحادثات'),
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
                          allUsers.orgList[index].orgName,
                          allUsers.orgList[index].id,
                          allUsers.orgList[index].logo),
                      itemCount: allUsers.orgList.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(
      BuildContext context, String orgName, String orgId, String img) {
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
                        margin: const  EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                    ],
                  ),
                  margin: const  EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(orgId: orgId)));
//                    builder: (context) => FirestoreChatScreen()));
          },
          padding: const  EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: const  EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }
}
