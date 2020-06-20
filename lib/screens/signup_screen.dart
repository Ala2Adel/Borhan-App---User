import 'package:Borhan_User/app_localizations.dart';
import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/providers/usersProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Animation/FadeAnimation.dart';

import 'dart:io' show Platform;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _submitLoading = false;
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  bool validateStrongPassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void _showErrorDialog(String message) {
    print("alert");
    showDialog(
      context: context,
      builder: (ctx) => (Platform.isAndroid)
          ? AlertDialog(
              title: Text(AppLocalizations.of(context)
                  .translate('Something_went_wrong_String')),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text(AppLocalizations.of(context).translate('ok')),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            )
          : CupertinoAlertDialog(
              title: Text(AppLocalizations.of(context)
                  .translate('Something_went_wrong_String')),
              content: Text(message),
              actions: <Widget>[
                CupertinoDialogAction(
                    child: Text(AppLocalizations.of(context).translate('ok')),
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
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _submitLoading = true;
    });

    try {
      // Log user in
      String localId = await Provider.of<Auth>(context, listen: false).signup(
        _authData['email'],
        _authData['password'],
      );

      await Provider.of<UsersPtovider>(context, listen: false).addUser(
        localId,
        _authData['name'],
        _authData['email'],
        _authData['password'],
      );

      Flushbar(
        message: AppLocalizations.of(context).translate('new'),
        icon: Icon(
          Icons.thumb_up,
          size: 28.0,
          color: Colors.blue[300],
        ),
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(8),
        borderRadius: 8,
      )..show(context).then(
          (value) => Navigator.of(context).pushReplacementNamed('/Login'));
    } catch (error) {
      print(error);
      var errorMessage = AppLocalizations.of(context).translate('already');
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _submitLoading = false;
    });
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
                    child: Text(
                      AppLocalizations.of(context).translate('Welcome'),
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
                children: <Widget>[
                  FadeAnimation(
                    1.5,
                    Text(
                      AppLocalizations.of(context).translate('register'),
                      style: TextStyle(
                          color: Color.fromRGBO(49, 39, 79, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppLocalizations.of(context)
                                          .translate('username'),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.deepPurple,
                                      ),
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  onSaved: (value) {
                                    _authData['name'] = value;
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppLocalizations.of(context)
                                        .translate('Email'),
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
                                      return AppLocalizations.of(context)
                                          .translate('invalid_mail');
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _authData['email'] = value;
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppLocalizations.of(context)
                                          .translate('Password'),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.deepPurple,
                                      ),
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  obscureText: true,
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value.isEmpty || value.length < 5) {
                                      return AppLocalizations.of(context)
                                          .translate('short');
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _authData['password'] = value;
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppLocalizations.of(context)
                                          .translate('conf'),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.deepPurple,
                                      ),
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  obscureText: true,
                                  controller: _passwordConfirmController,
                                  validator: (value) {
                                    if (value != _passwordController.text) {
                                      return AppLocalizations.of(context)
                                          .translate('notconsist');
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _authData['password'] = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
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
                      }, // handle your onTap here
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.symmetric(horizontal: .25 * width),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromRGBO(49, 39, 79, 1),
                        ),
                        child: Center(
                          child: _submitLoading == false
                              ? Text(
                                  AppLocalizations.of(context)
                                      .translate('register'),
                                  style: TextStyle(color: Colors.white),
                                )
                              : CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      2,
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                        child: Center(
                          child: FlatButton(
                            child: Text(
                              AppLocalizations.of(context).translate('have'),
                              style: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, .6),
                              ),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, '/Login'),
                          ),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
