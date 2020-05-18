import 'package:flutter/material.dart';
import '../Animation/FadeAnimation.dart';


class LoginScreen  extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _LoginScreenState  createState() => _LoginScreenState ();
}

class _LoginScreenState  extends State <LoginScreen > {
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FadeAnimation(1.5, Text("تسجيل دخول",style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),
                  )),
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
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color: Colors.grey[200]
                              ))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "البريد الالكترونى",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.deepPurple,

                              ),
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            textAlign: TextAlign.end,
                          ),

                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "كلمه المرور",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.deepPurple,

                                ),
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  )),
                  SizedBox(height: 20,),
                  FadeAnimation(1.7, Center(child:
                  Text("هل نسيت كلمه المرور ؟", style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),))),
                  SizedBox(height: 20,),
                  FadeAnimation(1.9, InkWell(
                    onTap: () => print("Container pressed"), // handle your onTap here
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromRGBO(49, 39, 79, 1),
                      ),
                      child: Center(
                        child: Text("تسجيل دخول", style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  )),
                  SizedBox(height: 30,),
                  FadeAnimation(2, Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                    child: Center(child: Text("حساب جديد",
                      style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),),
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