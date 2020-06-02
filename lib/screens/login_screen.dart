
import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/providers/usersProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Animation/FadeAnimation.dart';
import 'overview_screen.dart';


enum AuthMode { ResetPassword, Login }

class LoginScreen  extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _LoginScreenState  createState() => _LoginScreenState ();
}

class _LoginScreenState  extends State <LoginScreen > {

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  AuthMode _authMode = AuthMode.Login;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    print("alert");
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('حدث خطأ ما'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('حسنا'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
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
    if (_authMode == AuthMode.Login) {
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).login(
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
     Provider.of<UsersPtovider>(context, listen: false).setUserData(
      email:_authData['email'],
      userName: _authData['name']
      );
     //////////////////////////////////////////////
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OrgOverviewScreen()));

//      Navigator.push(
//          context, MaterialPageRoute(builder: (context) => Home()));

      // Navigator.of(context).pushReplacementNamed('/home');
    }

      catch (error) {
      print(error);
      const errorMessage =
          'البريد الإلكتروني أو كلمة المرور غير صحيحة ,رجاء المحاولة مرة أخري';
      _showErrorDialog(errorMessage);
         }

    } else {
      try {
        Auth auth = new Auth();
        await auth.resetPassword(_authData['email']);
      }
      catch (error) {
        print(error);
        const errorMessage =
            'البريد الإلكتروني غير موجود';
        _showErrorDialog(errorMessage);
      }
     }
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
    final height = MediaQuery.of(context).size.height*(3/7);
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
                    child: Text('مرحبا بك فى برهان',
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
                  FadeAnimation(1.5,
                      Text(_authMode == AuthMode.Login
                          ? 'تسجيل الدخول'
                          : 'نسيت كلمه المرور',
                        style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1)
                            , fontWeight: FontWeight.bold
                            , fontSize: 30),
                     ),
                  ),
                  SizedBox(height: 20,),
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
                                         bool spaceRex = new RegExp(r"^\\s+$").hasMatch(value);
                                       if(spaceRex || value.length==0 || value==null){
                                         return 'ادخل البريد الألكترونى من فضلك';
                                       }else{
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
                                  hintStyle: TextStyle(color: Colors.grey)
                              ),
//                              textAlign: TextAlign.end,
                              obscureText: true,
                              controller: _passwordController,
                              onSaved: (value) {
                                _authData['password'] = value;
                              },
                               validator: (value) {
                                    bool spaceRex = new RegExp(r"^\\s+$").hasMatch(value);
                                    if(spaceRex || value.length==0 || value==null){
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
                  SizedBox(height: 20,),
                  FadeAnimation(1.7, Center(child:
                  FlatButton(child: Text('${_authMode == AuthMode.Login ? 'هل نسيت كلمة المرور؟' : 'الرجوع إلي تسجيل الدخول'} ',
                    style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1),
                       ),
                     ),
                    onPressed: _switchAuthMode,
                    ),
                   ),
                  ),
                  SizedBox(height: 20,),
                  FadeAnimation(1.9, InkWell(
                    onTap: _submit, // handle your onTap here
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromRGBO(49, 39, 79, 1),
                      ),
                      child: Center(
                        child: Text(_authMode == AuthMode.Login
                            ? 'تسجيل الدخول'
                            : 'إرسال رابط تغيير كلمة المرور',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )),
                  SizedBox(height: 30,),
                  FadeAnimation(2, Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                    child: Center(child: FlatButton(
                      child: FlatButton(
                        child: Text("حساب جديد",
                          style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6))
                          ,
                        ),
                        onPressed: ()=>Navigator.pushReplacementNamed(context, '/Signup'),
                      ),
                    ),
                    ),
                  ),
                  ),
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