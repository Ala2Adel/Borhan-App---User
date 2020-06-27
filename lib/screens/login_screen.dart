import 'dart:async';
import 'package:Borhan_User/providers/auth.dart';

import 'package:Borhan_User/providers/usersProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../Animation/FadeAnimation.dart';
import 'org_widgets/arc_banner_image.dart';
import 'overview_screen.dart';
import 'dart:io' show Platform;

GoogleSignInAccount _currentUser;

enum AuthMode { ResetPassword, Login }

class LoginScreen extends StatefulWidget {
  static GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _pwdFocusNode = FocusNode();

  var _submitLoading = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  AuthMode _authMode = AuthMode.Login;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  
  
  @override
  void dispose() {
    _pwdFocusNode.dispose();
    super.dispose();
  }
  
  @override
  void initState() {
    super.initState();
    LoginScreen.googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      Provider.of<UsersPtovider>(context, listen: false).addUser(
        _currentUser.id,
        _currentUser.displayName,
        _currentUser.email,
        _authData['password'],
      );
    });

    LoginScreen.googleSignIn.signInSilently();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => (Platform.isAndroid)
          ? AlertDialog(
              title: const Text('حدث خطأ ما'),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: const Text('حسنا'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            )
          : CupertinoAlertDialog(
              title: const Text('حدث خطأ ما'),
              content: Text(message),
              actions: <Widget>[
                CupertinoDialogAction(
                    child: const Text('حسنا'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    }),
              ],
            ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      print("formKey.currentState IS Invalid");
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _submitLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      try {
        String localId = await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );

        Provider.of<UsersPtovider>(context, listen: false)
            .setUserData(email: _authData['email'], userId: localId);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OrgOverviewScreen()));
      } catch (error) {
        const errorMessage =
            'البريد الإلكتروني أو كلمة المرور غير صحيحة ,رجاء المحاولة مرة أخري';
        _showErrorDialog(errorMessage);
      }
    } else {
      try {
        Auth auth = new Auth();
        await auth.resetPassword(_authData['email']);

        Flushbar(
          message: 'تم ارسال تغير رابط كلمة المرور',
          icon: Icon(
            Icons.thumb_up,
            size: 28.0,
            color: Colors.blue[300],
          ),
          duration: Duration(seconds: 3),
          margin: const EdgeInsets.all(8),
          borderRadius: 8,
        )..show(context);
      } catch (error) {
        const errorMessage = 'البريد الإلكتروني غير موجود';
        _showErrorDialog(errorMessage);
      }
    }
    setState(
      () {
        _submitLoading = false;
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * (2 / 3);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // height: height,
              child: Stack(
                children: <Widget>[
                  // Positioned(
                  //   // top: -height / 10,
                  //   height: height,
                  //   width: width,
                  //   child: FadeAnimation(
                  //       1,
                  //       Container(
                  //         decoration: BoxDecoration(
                  //             image: DecorationImage(
                  //                 image: AssetImage(
                  //                     'assets/images/backg2.png'),
                  //                 fit: BoxFit.fill)),
                  //        ),
                  //       ),
                  // ),
                  ///////////////////////////////////////////////////////

                  Positioned(
                    // top: -height / 10,
                    top: -100,
                    child: ClipPath(
                      clipper: ArcClipper(),
                      child: Image.asset(
                        'assets/images/backg2.png',
                        fit: BoxFit.fill,
                        height: 500.0,
                        width: width,
                      ),
                    ),
                  ),

                  /////////////////////////////////////////////////
                  // Positioned(
                  //   top: -height / 10,
                  //   height: height,
                  //   width: width,
                  //   child: FadeAnimation(
                  //       1,
                  //       Container(
                  //         decoration: BoxDecoration(
                  //             image: DecorationImage(
                  //                 image: AssetImage(
                  //                     'assets/images/background.png'),
                  //                 fit: BoxFit.fill)),
                  //       )),
                  // ),
                  // Positioned(
                  //   height: height,
                  //   width: width + 20,
                  //   child: FadeAnimation(
                  //       1.3,
                  //       Container(
                  //         decoration: BoxDecoration(
                  //             image: DecorationImage(
                  //                 image: AssetImage(
                  //                     'assets/images/background-2.png'),
                  //                 fit: BoxFit.fill)),
                  //       )),
                  // ),
                  ////////////////////////////////////////////////////////

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 100),
                    child: Center(
                      child: const Text(
                        'مرحبا بك فى برهان',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 150),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(
                          1.5,
                          Text(
                            _authMode == AuthMode.Login
                                ? 'تسجيل الدخول'
                                : 'نسيت كلمة المرور',
                            style: TextStyle(
//                        color: const Color.fromRGBO(49, 39, 79, 1),
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            FadeAnimation(
                              1.7,
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromRGBO(196, 135, 198, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10),
                                      )
                                    ]),
                                child: Form(
                                  key: _formKey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]),
                                            ),
                                          ),
                                          child: TextFormField(
                                            textInputAction: TextInputAction.next,
                                            onFieldSubmitted: (_){
                                              FocusScope.of(context).requestFocus( _pwdFocusNode);
                                            },

                                          
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "البريد الإلكتروني",
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Color.fromRGBO(1, 123, 126, 1),
                                              ),
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                            ),
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
                                                  return 'ادخل البريد الإلكتروني من فضلك';
                                                } else {
                                                  return 'البريد الإلكتروني غير صالح';
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
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]),
                                              ),
                                            ),
                                            child: TextFormField(
                                              focusNode: _pwdFocusNode,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "كلمة المرور",
                                                  prefixIcon: Icon(
                                                    Icons.lock,
                                                    color: Color.fromRGBO(1, 123, 126, 1),
                                                  ),
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey)),
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
                                          ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        FadeAnimation(
                                          1.9,
                                          InkWell(
                                            onTap: () {
                                              if (!_submitLoading) {
                                                _submit();
                                              }
                                            }, // handle, // handle your onTap here
                                            child: Container(
                                              height: 45,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 30,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
//                            color: Color.fromRGBO(49, 39, 79, 1),
                                                color: Color.fromRGBO(1, 123, 126, 1),
                                              ),
                                              child: Center(
                                                child: _submitLoading == false
                                                    ? Text(
                                                        _authMode ==
                                                                AuthMode.Login
                                                            ? 'تسجيل الدخول'
                                                            : 'إرسال رابط تغيير كلمة المرور',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    : CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (_authMode != AuthMode.Login)
                                          SizedBox(
                                            height: 20,
                                          ),
                                        if (_authMode == AuthMode.Login)
                                          Text(
                                            'أو',
                                            style: TextStyle(
                                                color: Color.fromRGBO(1, 123, 126, 1),
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        if (_authMode == AuthMode.Login)
                                          Container(
                                            height: 45,
                                            margin: const EdgeInsets.fromLTRB(
                                                30, 0, 30, 30),
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        30.0),
                                                side: BorderSide(
                                                    color: Color.fromRGBO(1, 123, 126, 1),
                                                    width: 2),
                                              ),
//                              color: Color.fromRGBO(49, 39, 79, 1),
                                              //color: Colors.green[700],

                                              color: Colors.white,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.google,
                                                    color: Color.fromRGBO(1, 123, 126, 1),
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  Text(
                                                    'تسجيل الدخول بحساب جوجل',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(1, 123, 126, 1),
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              onPressed: _handleSignIn,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
//                              color: Color.fromRGBO(196, 135, 198, 1),
                                      color: Color.fromRGBO(1, 123, 126, 1),
                                    ),
                                  ),
                                  onPressed: _switchAuthMode,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            FadeAnimation(
                              2,
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 30),
                                child: Center(
                                  child: FlatButton(
                                    child: const Text(
                                      "حساب جديد",
                                      style: TextStyle(
                                        color: Color.fromRGBO(1, 123, 126, 1),
//                                  color: Color.fromRGBO(49, 39, 79, .6)
                                      ),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            /////////////////////))))0000000
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      await LoginScreen.googleSignIn.signIn();
    } catch (error) {
      print(error);
    }

    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => OrgOverviewScreen())));
  }
}
