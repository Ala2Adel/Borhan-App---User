import 'dart:async';

import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/providers/shard_pref.dart';
import 'package:Borhan_User/providers/usersProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../Animation/FadeAnimation.dart';
import 'overview_screen.dart';
import 'dart:io' show Platform;

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
GoogleSignInAccount _currentUser;

enum AuthMode { ResetPassword, Login }

class LoginScreen extends StatefulWidget {
  static var userName;
  static var gmail;
  // This widget is the root of your application.
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   var _submitLoading = false;  
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  AuthMode _authMode = AuthMode.Login;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
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
    if (_currentUser != null) {
      LoginScreen.userName = _currentUser.displayName;
      LoginScreen.gmail = _currentUser.email;
    }
//    GmailUserDetails.userName = _currentUser.displayName;
//    user.userName=_currentUser.displayName;
//    user.gmail=_currentUser.email;
//    GmailUserDetails.gmail = _currentUser.email;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_currentUser != null) {
      LoginScreen.userName = _currentUser.displayName;
      LoginScreen.gmail = _currentUser.email;
    }
  }

  void _showErrorDialog(String message) {
    print("alert");
    showDialog(
      context: context,
      builder: (ctx) => (Platform.isAndroid)?AlertDialog(
        title: const  Text('حدث خطأ ما'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child : const  Text('حسنا'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ):
      CupertinoAlertDialog(
         title: const  Text('حدث خطأ ما'),
        content: Text(message),
        actions: <Widget>[
          CupertinoDialogAction( child : const  Text('حسنا'),
            onPressed: () {
              Navigator.of(ctx).pop();
            }),
          
        ],
      ),
    );
  }

  Future<void> _submit() async {
    print("Container pressed");
    if (!_formKey.currentState.validate()) {
      // Invalid!
      print("formKey.currentState IS Invalid");
      return;
    }
    _formKey.currentState.save();
   
     setState(() {
      _submitLoading=true;
    });
    if (_authMode == AuthMode.Login) {
      try {
        // Log user in
        String localId = await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
//      Auth auth=new Auth();
//      await auth.login(
//        _authData['email'],
//        _authData['password'],
//      );
        // const errorMessage =
        //     'اهلا بك';
        // _showErrorDialog(errorMessage);
        /////////////////////////////////////////////
        Provider.of<UsersPtovider>(context, listen: false)
            .setUserData(email: _authData['email'], userId: localId);
        //////////////////////////////////////////////
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OrgOverviewScreen()));

//      Navigator.push(
//          context, MaterialPageRoute(builder: (context) => Home()));

        // Navigator.of(context).pushReplacementNamed('/home');
      } catch (error) {
        print(error);
        const errorMessage =
            'البريد الإلكتروني أو كلمة المرور غير صحيحة ,رجاء المحاولة مرة أخري';
        _showErrorDialog(errorMessage);
      }
    } else {
      try {
        Auth auth = new Auth();
        await auth.resetPassword(_authData['email']);
        
        Flushbar(
        message: 'تم ارسال تغير رابط كلمه المرور',
        icon: Icon(
          Icons.thumb_up,
          size: 28.0,
          color: Colors.blue[300],
        ),
        duration: Duration(seconds: 3),
        //leftBarIndicatorColor: Colors.blue[300],
        margin: EdgeInsets.all(8),
        borderRadius: 8,
      )..show(context);
        
      } catch (error) {
        print(error);
        const errorMessage = 'البريد الإلكتروني غير موجود';
        _showErrorDialog(errorMessage);
      }
       
    }
       setState(() {
      _submitLoading=false;
        },
       );
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.ResetPassword;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
//    print(_currentUser.displayName)
//    LoginScreen.userName = _currentUser.displayName;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * (1 / 3);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: height,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -height / 10,
                    height: height,
                    width: width,
                    child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background.png'),
                                  fit: BoxFit.fill)),
                        )),
                  ),
                  Positioned(
                    height: height,
                    width: width + 20,
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background-2.png'),
                                  fit: BoxFit.fill)),
                        )),
                  ),
                  Center(
                    child: Text(
                      'مرحبا بك فى برهان',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FadeAnimation(
                      1.5,
                      Text(
                        _authMode == AuthMode.Login
                            ? 'تسجيل الدخول'
                            : 'نسيت كلمه المرور',
                        style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _currentUser != null
                        ? Column(
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
//                              RaisedButton(
//                                onPressed: _handleSignOut,
//                                child: Text('تسجيل الخروج من حساب جوجل'),
//                              )
                            ],
                          )
                        : Container(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
//                              Text('You are not signed in..'),

                        FadeAnimation(
                            1.7,
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10),
                                    )
                                  ]),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "البريد الالكترونى",
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Colors.deepPurple,
                                          ),
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
//                              textAlign: TextAlign.end,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          bool emailValid = RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value);
                                          if (!emailValid) {
                                            bool spaceRex =
                                                new RegExp(r"^\\s+$")
                                                    .hasMatch(value);
                                            if (spaceRex ||
                                                value.length == 0 ||
                                                value == null) {
                                              return 'ادخل البريد الألكترونى من فضلك';
                                            } else {
                                              return 'البريد الألكترونى غيرصالح';
                                            }
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _authData['email'] = value;
                                        },
                                      ),
                                    ),
                                    if (_authMode == AuthMode.Login)
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "كلمه المرور",
                                              prefixIcon: Icon(
                                                Icons.lock,
                                                color: Colors.deepPurple,
                                              ),
                                              hintStyle: TextStyle(
                                                  color: Colors.grey)),
//                              textAlign: TextAlign.end,
                                          obscureText: true,
                                          controller: _passwordController,
                                          onSaved: (value) {
                                            _authData['password'] = value;
                                          },
                                          validator: (value) {
                                            bool spaceRex =
                                                new RegExp(r"^\\s+$")
                                                    .hasMatch(value);
                                            if (spaceRex ||
                                                value.length == 0 ||
                                                value == null) {
                                              return 'ادخل  كلمة المرور من فضلك';
                                            }
                                            return null;
                                          },
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                       
                        FadeAnimation(
                          1.7,
                          Center(
                            child: FlatButton(
                              child: Text(
                                '${_authMode == AuthMode.Login ? 'هل نسيت كلمة المرور؟' : 'الرجوع إلي تسجيل الدخول'} ',
                                style: TextStyle(
                                  color: Color.fromRGBO(196, 135, 198, 1),
                                ),
                              ),
                              onPressed: _switchAuthMode,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            1.9,
                            InkWell(
                              onTap: () {
                                if(!_submitLoading){
                                   _submit();
                                }
                                  
                              }, // handle, // handle your onTap here
                              child: Container(
                                height: 40,
                                margin: EdgeInsets.symmetric(horizontal: 60),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromRGBO(49, 39, 79, 1),
                                ),
                                child: Center(
                                  child: _submitLoading==false? 
                                  Text(
                                    _authMode == AuthMode.Login
                                        ? 'تسجيل الدخول'
                                        : 'إرسال رابط تغيير كلمة المرور',
                                    style: TextStyle(color: Colors.white),
                                  ):CircularProgressIndicator(),
                                ),
                              ),
                             ),
                            ),
                            /////////////////////////////////
                           
                            if (_authMode == AuthMode.Login)
                             _currentUser == null
                            ?
                             Container(
                                width: 280.0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                      color: Color.fromRGBO(49, 39, 79, 1),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.google,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10.0),
                                          Text(
                                            'تسجيل الدخول بحساب جوجل',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0),
                                          ),
                                        ],
                                      ),
//                            RaisedButton(
//                              onPressed: _handleSignIn,
//                              child: Text('SIGN IN'),
//                            )
                                      onPressed: _handleSignIn,
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Align(
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                      color: Color.fromRGBO(49, 39, 79, 1),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.google,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10.0),
                                          Expanded(
                                            child: Text(
                                              'تسجيل الخروج من حساب جوجل',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                        ],
                                      ),
//                            RaisedButton(
//                              onPressed: _handleSignIn,
//                              child: Text('SIGN IN'),
//                            )
                                      onPressed: _handleSignOut,
                                    ),
                                  ),
                                ),
                              ),
                            ////////////////////////////////
                        SizedBox(
                          height: 0,
                        ),
                        FadeAnimation(
                          2,
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                            child: Center(
                              child: FlatButton(
                                child: Text(
                                  "حساب جديد",
                                  style: TextStyle(
                                      color: Color.fromRGBO(49, 39, 79, .6)),
                                ),
                                onPressed: () =>
                                    Navigator.pushReplacementNamed(
                                        context, '/Signup'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ), //ramadan say hi
      //hello again
    );
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
//    LoginScreen.userName = _currentUser.displayName;
//    LoginScreen.gmail = _currentUser.email;
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => OrgOverviewScreen())));
//    Future<T> pushNamed <T extends Object>(
//    BuildContext context,
//    String routeName,
//  {Object arguments}
//    )
//    Navigator.of(context).pushNamed(OrgOverviewScreen.routeName,arguments: _currentUser.email)
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => OrgOverviewScreen()));

//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => OrgOverviewScreen()));
//  }
  }

  Future<void> _handleSignOut() async {
    if (_currentUser != null) {
      print("from signout : " + _currentUser.displayName);
      LoginScreen.userName = _currentUser.displayName;
      LoginScreen.gmail = _currentUser.email;
    }
    SharedPref sharedPref = SharedPref();
    sharedPref.remove("user");
    _googleSignIn.disconnect();
//    LoginScreen.userName = '';
//    LoginScreen.gmail = '';
//    LoginScreen.userName = null;
//    LoginScreen.gmail = null;
  }
}
//
//class GmailUserDetails {
////  final String =_currentUser.displayName;
//
//}
