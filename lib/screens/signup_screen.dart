import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/providers/usersProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Animation/FadeAnimation.dart';

import 'dart:io' show Platform;


class SignupScreen  extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _SignupScreenState  createState() => _SignupScreenState ();
}

class _SignupScreenState  extends State <SignupScreen > {

   var _submitLoading = false;  
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  bool validateStrongPassword(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void _showErrorDialog(String message) {
    print("alert");
    showDialog(
      context: context,
      builder: (ctx) =>(Platform.isAndroid)? AlertDialog(
        title: const  Text('حدث خطأ ما'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: const  Text('حسنا'),
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
          CupertinoDialogAction( child: const  Text('حسنا'),
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
      return;
    }
    _formKey.currentState.save();
     
     setState(() {
      _submitLoading=true;
    });

    try {
      // Log user in
     String localId= await Provider.of<Auth>(context, listen: false).signup(
        _authData['email'],
        _authData['password'],
      );
//      Auth auth=new Auth();
//      await auth.signup(
//        _authData['email'],
//        _authData['password'],
//      );
      await Provider.of<UsersPtovider>(context, listen: false).addUser(
        localId,
        _authData['name'],
        _authData['email'],
        _authData['password'],
      );
      
       Flushbar(
        message: 'تم تسيجل البريد الالكترونى بنجاح',
        icon: Icon(
          Icons.thumb_up,
          size: 28.0,
          color: Colors.blue[300],
        ),
        duration: Duration(seconds: 3),
        //leftBarIndicatorColor: Colors.blue[300],
        margin: EdgeInsets.all(8),
        borderRadius: 8,
      )..show(context).then((value) => Navigator.of(context).pushReplacementNamed('/Login'));

//      UsersPtovider usersPtovider =new UsersPtovider();
//      await  usersPtovider.addUser(
//        _authData['name'],
//        _authData['email'],
//        _authData['password'],
//      );
//      Navigator.push(
//          context, MaterialPageRoute(builder: (context) => Home()));

     //Navigator.of(context).pushReplacementNamed('/Login');
    }

    catch (error) {
      print(error);
      const errorMessage =
          'البريد الإلكتروني موجود بالفعل ';
      _showErrorDialog(errorMessage);
    }
     setState(() {
      _submitLoading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height*(1/3);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: height,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -height/10,
                    height: height,
                    width: width,
                    child: FadeAnimation(1, Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.fill
                          )
                      ),
                    )),
                  ),
                  Positioned(
                    height: height,
                    width: width+20,
                    child: FadeAnimation(1.3, Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background-2.png'),
                              fit: BoxFit.fill
                          )
                      ),
                    )),
                  ),
                  Center(
                    child: const  Text('مرحبا بك فى برهان',
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
              padding: EdgeInsets.symmetric(horizontal: 20 ),
              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FadeAnimation(1.5,
                      Text("تسجيل حساب",
                        style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1),
                            fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  SizedBox(height: 10,),
                  FadeAnimation(1.7, Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )
                        ]
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
//                                  labelText:'اسم المستخدم',
                                  hintText: "اسم المستخدم",
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.deepPurple,

                                  ),
                                  hintStyle: TextStyle(color: Colors.grey)
                              ),
//                              textAlign: TextAlign.end,
                              onSaved: (value) {
                                _authData['name'] = value;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                    color: Colors.grey[200]
                                ))
                            ),
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
//                              textAlign: TextAlign.end,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                                if (!emailValid) {
                                  return 'البريد الالكترونى غير صالح ';
                                }
                              },
                              onSaved: (value) {
                                _authData['email'] = value;
                              },
                            ),

                          ),
//                           Container(
//                             padding: EdgeInsets.all(10),
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: "رقم التلفون المحمول",
//                                   prefixIcon: Icon(
//                                     Icons.mobile_screen_share,
//                                     color: Colors.deepPurple,

//                                   ),
//                                   hintStyle: TextStyle(color: Colors.grey)
//                               ),
// //                              textAlign: TextAlign.end,
//                               keyboardType: TextInputType.number,
//                             ),
//                           ),
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
                                  hintStyle: TextStyle(color: Colors.grey)
                              ),
//                              textAlign: TextAlign.end,
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value) {
                                if (value.isEmpty || value.length < 5) {
                                  return 'كلمة المرور قصيرة جدا';
                                }
                              },
                              onSaved: (value) {
                                _authData['password'] = value;
                              },

                            ),
                          ),
                          Container(
                            padding:  const EdgeInsets.all(10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "تأكيد كلمه المرور",
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.deepPurple,

                                  ),
                                  hintStyle: TextStyle(color: Colors.grey)
                              ),
//                              textAlign: TextAlign.end,
                              obscureText: true,
                              controller: _passwordConfirmController,
                              validator: (value) {
                                if(value != _passwordController.text){
                                  return 'غير مطابقة';
                                }

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
                  SizedBox(height: 30,),
                  FadeAnimation(1.9, InkWell(
                    onTap: () {
                                if(!_submitLoading){
                                   _submit();
                                }
                                  
                              }, // handle your onTap here
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: .25*width),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromRGBO(49, 39, 79, 1),
                      ),
                      child: Center(
                        child:_submitLoading==false? 
                              Text("تسجيل حساب", style: TextStyle(color: Colors.white),
                              ):CircularProgressIndicator(),
                      ),
                    ),
                   ),
                  ),
                
                  SizedBox(height: 10,),
                  FadeAnimation(2, Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                    child: Center(
                      child: FlatButton(
                        child: const  Text("أمتلك حساب",
                        style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6),
                          ),
                        ),
                        onPressed: ()=>Navigator.pushReplacementNamed(context, '/Login'),
                      ),
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),//ramadan say hi
      //hello again
    );
  }
}


