import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

class GmailSignin extends StatefulWidget {
  @override
  _GmailSigninState createState() => _GmailSigninState();
}

class _GmailSigninState extends State<GmailSignin> {
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign in Demo'),
      ),
      body: Center(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_currentUser != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: _currentUser,
            ),
            title: Text(_currentUser.displayName ?? ''),
            subtitle: Text(_currentUser.email ?? ''),
          ),
          RaisedButton(
            onPressed: _handleSignOut,
            child: Text('SIGN OUT'),
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text('You are not signed in..'),
          RaisedButton(
            onPressed: _handleSignIn,
            child: Text('SIGN IN'),
          )
        ],
      );
    }
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
  }
}

//import 'package:Borhan_User/screens/overview_screen.dart';
//import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//
//class GoogleSignApp extends StatefulWidget {
//  @override
//  _GoogleSignAppState createState() => _GoogleSignAppState();
//}
//
//class _GoogleSignAppState extends State<GoogleSignApp> {
//  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//  final GoogleSignIn _googlSignIn = new GoogleSignIn();
//
//  Future<FirebaseUser> _signIn(BuildContext context) async {
//    Scaffold.of(context).showSnackBar(new SnackBar(
//      content: new Text('Sign in'),
//    ));
//
//    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth =
//        await googleUser.authentication;
//
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );
//
//    FirebaseUser userDetails =
//        (await _firebaseAuth.signInWithCredential(credential)) as FirebaseUser;
//    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);
//
//    List<ProviderDetails> providerData = new List<ProviderDetails>();
//    providerData.add(providerInfo);
//
//    UserDetails details = new UserDetails(
//      userDetails.providerId,
//      userDetails.displayName,
//      userDetails.photoUrl,
//      userDetails.email,
//      providerData,
//    );
//    Navigator.push(
//      context,
//      new MaterialPageRoute(
//        builder: (context) => new OrgOverviewScreen(),
//      ),
//    );
//    return userDetails;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Builder(
//        builder: (context) => Stack(
//          fit: StackFit.expand,
//          children: <Widget>[
//            Container(
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
//              child: Image.network(
//                  'https://images.unsplash.com/photo-1518050947974-4be8c7469f0c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
//                  fit: BoxFit.fill,
//                  color: Color.fromRGBO(255, 255, 255, 0.6),
//                  colorBlendMode: BlendMode.modulate),
//            ),
//            Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                SizedBox(height: 10.0),
//                Container(
//                    width: 250.0,
//                    child: Align(
//                      alignment: Alignment.center,
//                      child: RaisedButton(
//                        shape: RoundedRectangleBorder(
//                            borderRadius: new BorderRadius.circular(30.0)),
//                        color: Color(0xffffffff),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          children: <Widget>[
//                            Icon(
//                              FontAwesomeIcons.google,
//                              color: Color(0xffCE107C),
//                            ),
//                            SizedBox(width: 10.0),
//                            Text(
//                              'Sign in with Google',
//                              style: TextStyle(
//                                  color: Colors.black, fontSize: 18.0),
//                            ),
//                          ],
//                        ),
//                        onPressed: () => _signIn(context)
//                            .then((FirebaseUser user) => print(user))
//                            .catchError((e) => print(e)),
//                      ),
//                    )),
//                Container(
//                    width: 250.0,
//                    child: Align(
//                      alignment: Alignment.center,
//                      child: RaisedButton(
//                        shape: RoundedRectangleBorder(
//                            borderRadius: new BorderRadius.circular(30.0)),
//                        color: Color(0xffffffff),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          children: <Widget>[
//                            Icon(
//                              FontAwesomeIcons.facebookF,
//                              color: Color(0xff4754de),
//                            ),
//                            SizedBox(width: 10.0),
//                            Text(
//                              'Sign in with Facebook',
//                              style: TextStyle(
//                                  color: Colors.black, fontSize: 18.0),
//                            ),
//                          ],
//                        ),
//                        onPressed: () {},
//                      ),
//                    )),
//                Container(
//                    width: 250.0,
//                    child: Align(
//                      alignment: Alignment.center,
//                      child: RaisedButton(
//                        shape: RoundedRectangleBorder(
//                            borderRadius: new BorderRadius.circular(30.0)),
//                        color: Color(0xffffffff),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          children: <Widget>[
//                            Icon(
//                              FontAwesomeIcons.solidEnvelope,
//                              color: Color(0xff4caf50),
//                            ),
//                            SizedBox(width: 10.0),
//                            Text(
//                              'Sign in with Email',
//                              style: TextStyle(
//                                  color: Colors.black, fontSize: 18.0),
//                            ),
//                          ],
//                        ),
//                        onPressed: () {},
//                      ),
//                    )),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class UserDetails {
//  final String providerDetails;
//  final String userName;
//  final String photoUrl;
//  final String userEmail;
//  final List<ProviderDetails> providerData;
//
//  UserDetails(this.providerDetails, this.userName, this.photoUrl,
//      this.userEmail, this.providerData);
//}
//
//class ProviderDetails {
//  ProviderDetails(this.providerDetails);
//  final String providerDetails;
//}
