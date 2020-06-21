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
          message: 'تم ارسال تغير رابط كلمه المرور',
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
    final height = MediaQuery.of(context).size.height * (1 / 3);

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
                    child: const Text(
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: <Widget>[
                FadeAnimation(
                  1.5,
                  Text(
                    _authMode == AuthMode.Login
                        ? 'تسجيل الدخول'
                        : 'نسيت كلمه المرور',
                    style: TextStyle(
                        color: const Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                                  padding: const EdgeInsets.all(10),
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
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      bool emailValid = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value);
                                      if (!emailValid) {
                                        bool spaceRex = new RegExp(r"^\\s+$")
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
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "كلمه المرور",
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Colors.deepPurple,
                                          ),
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                      obscureText: true,
                                      controller: _passwordController,
                                      onSaved: (value) {
                                        _authData['password'] = value;
                                      },
                                      validator: (value) {
                                        bool spaceRex = new RegExp(r"^\\s+$")
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
                          if (!_submitLoading) {
                            _submit();
                          }
                        }, // handle, // handle your onTap here
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(49, 39, 79, 1),
                          ),
                          child: Center(
                            child: _submitLoading == false
                                ? Text(
                                    _authMode == AuthMode.Login
                                        ? 'تسجيل الدخول'
                                        : 'إرسال رابط تغيير كلمة المرور',
                                    style: TextStyle(color: Colors.white),
                                  )
                                : CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                    if (_authMode == AuthMode.Login)
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.google,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(
                                    'تسجيل الدخول بحساب جوجل',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.0),
                                  ),
                                ],
                              ),
                              onPressed: _handleSignIn,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 0,
                    ),
                    FadeAnimation(
                      2,
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                        child: Center(
                          child: FlatButton(
                            child: const Text(
                              "حساب جديد",
                              style: TextStyle(
                                  color: Color.fromRGBO(49, 39, 79, .6)),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(
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