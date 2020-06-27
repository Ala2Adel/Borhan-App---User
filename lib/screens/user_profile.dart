import 'dart:io';
import 'dart:ui';

import 'package:Borhan_User/models/user_nav.dart';
import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/providers/shard_pref.dart';
import 'package:Borhan_User/providers/usersProvider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:google_fonts_arabic/fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';
import 'org_widgets/arc_banner_image.dart';

class UserProfileScreen extends StatefulWidget {
  // Organization storyline = new Organization(
  //     orgName: "wwww",
  //     description: "tttt",
  //     address: "Ramadan Elnaggar66",
  //     email: "ramadan96naggar@gmail.com99",
  //     mobileNo: "01272173025");
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UsersPtovider usersPtovider;
  UserNav userLoad;
  var _isLoadImg = false;
  var _edited = false;
  var editedClicked = false;
  File _image;
  String userName;

  final GlobalKey<FormState> _formKey = GlobalKey();
//  final globalKey = GlobalKey<ScaffoldState>();

  Future<UserNav> loadSharedPrefs() async {
    UserNav user;
    try {
      SharedPref sharedPref = SharedPref();
      user = UserNav.fromJson(await sharedPref.read("user"));
      setState(() {
        userLoad = user;
      });
    } catch (Excepetion) {
      // do something
    }
    return user;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => (Platform.isAndroid)
          ? BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AlertDialog(
                title: const Text('تسجيل خروج'),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: const Text('الغاء'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                  FlatButton(
                    child: const Text(
                      'نعم',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      SharedPref sharedPref = SharedPref();
                      sharedPref.remove("user");
                      LoginScreen.googleSignIn.disconnect();
                      Navigator.of(ctx).pop();
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              ),
            )
          : BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: CupertinoAlertDialog(
                title: const Text('تسجيل خروج'),
                content: Text(message),
                actions: <Widget>[
                  CupertinoDialogAction(
                      child: const Text('الغاء'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      }),
                  CupertinoDialogAction(
                      child: const Text(
                        'نعم',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        SharedPref sharedPref = SharedPref();
                        sharedPref.remove("user");
                        Navigator.of(ctx).pop();
                        Navigator.of(ctx).pop();
                      })
                ],
              ),
            ),
    );
  }

  Future getImage() async {
    File img;
    img = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (img != null) {
        _image = img;
        _isLoadImg = true;
      } else {
        if (_image != null) {
          _isLoadImg = true;
        } else {
          _isLoadImg = false;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    //this.getActivites(widget.currentOrg.id);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;
    var screenWidth = MediaQuery.of(context).size.width;
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Container(
            height: 220,
            child: Stack(
              children: [
                ClipPath(
                  clipper: ArcClipper(),
                  child: Container(
                    height: 140,
                    width: screenWidth,
                    color: Colors.green,
                  ),
                ),
                userLoad == null
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: Center(
                          child: Container(
                            width: 140,
                            height: 140,
                            //  color: Colors.lime,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                color: Colors.orange,
                                border:
                                    Border.all(color: Colors.white, width: 5)),
                            child: _isLoadImg
                                ? CircleAvatar(
                                    backgroundImage: AssetImage(_image.path),
                                    // radius: 40.0,
                                  )
                                : userLoad.userImage == null
                                    ? CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/profile2.png"),
                                        // radius: 40.0,
                                      )
                                    : CircleAvatar(
                                        backgroundImage:
                                            AssetImage(userLoad.userImage),
                                        // radius: 40.0,
                                      ),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 160, 0, 0),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      //  color: Colors.lime,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white, width: 2)),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                        ),
                        onPressed: () {
                          getImage();
                          setState(() {
                            _edited = true;
                          });
                        },
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.green[50],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Center(
            child: const Text(
              'الملف الشخصى',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: ArabicFonts.Changa,
                  package: 'google_fonts_arabic',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            column,
            userLoad == null
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'اسم المستخدم',
                          style: textTheme.subtitle1.copyWith(fontSize: 21.0),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //  SizedBox(width: 10.0),
                            !editedClicked
                                ? Text(
                                    userName == null
                                        ? userLoad.userName
                                        : userName,
                                    style: textTheme.bodyText2.copyWith(
                                      color: Colors.black45,
                                      fontSize: 18.0,
                                    ),
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width *
                                        2 /
                                        3,
                                    child: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        initialValue: userName == null
                                            ? userLoad.userName
                                            : userName,
                                        validator: (value) {
                                          if (value.length < 3 ||
                                              value == null) {
                                            bool spaceRex =
                                                new RegExp(r"^\\s+$")
                                                    .hasMatch(value);
                                            if (spaceRex || value.length == 0) {
                                              return 'ادخل الاسم من فضلك';
                                            } else {
                                              return 'الاسم لايمكن ان يكون اقل من ثلاثه احرف';
                                            }
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          userName = value;
                                        },
                                      ),
                                    )),
                            !editedClicked
                                ? IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        editedClicked = true;
                                      });
                                    },
                                    color: Colors.green,
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.done,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        editedClicked = false;
                                        _edited = true;
                                      });
                                    },
                                    color: Colors.green,
                                  ),
                          ],
                        ),
                        Text(
                          'البريد الإلكتروني',
                          style: textTheme.subtitle1.copyWith(fontSize: 21.0),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          userLoad.email,
                          style: textTheme.bodyText2.copyWith(
                            color: Colors.black45,
                            fontSize: 18.0,
                          ),
                        ),
                        // Text(
                        //   ' رقم التليفون المحمول',
                        //   style: textTheme.subtitle1.copyWith(fontSize: 21.0),
                        // ),
                        // SizedBox(height: 5.0),
                        // Text(
                        //   widget.storyline.mobileNo,
                        //   style: textTheme.bodyText2.copyWith(
                        //     color: Colors.black45,
                        //     fontSize: 18.0,
                        //   ),
                        // ),
                        SizedBox(height: 5.0),
                        FlatButton(
                          child: Text(
                            ' تغير كلمة المرور',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.green[700],
                            ),
                          ),
                          onPressed: () async {
                            try {
                              await Provider.of<Auth>(context, listen: false)
                                  .resetPassword(userLoad.email);
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
                              const errorMessage =
                                  'البريد الإلكتروني غير موجود';
                              _showErrorDialog(errorMessage);
                            }
                          },
                        ),
                        if (_edited)
                          Container(
                            height: 45,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 20),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                                //  side: BorderSide(color: Colors.green, width: 2),
                              ),
                              color: Colors.green,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    ' حفظ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              onPressed: () async {
                                // if (!_formKey.currentState.validate()) {
                                //   // Invalid!
                                //   print("formKey.currentState IS Invalid");
                                //   return;
                                // }
                                String imageUrl;
                                if (userName == null) {
                                  userName = userLoad.userName;
                                }
                                if (_image == null) {
                                  imageUrl = userLoad.userImage;
                                } else {
                                  imageUrl = _image.path;
                                }
                                try {
                                  await Provider.of<UsersPtovider>(context,
                                          listen: false)
                                      .apdateUser(userLoad.id, userName,
                                          userLoad.email, imageUrl);
                                  Flushbar(
                                    message: 'تم تعديل بياناتك بنجاح',
                                    icon: Icon(
                                      Icons.thumb_up,
                                      size: 28.0,
                                      color: Colors.blue[300],
                                    ),
                                    duration: Duration(seconds: 3),
                                    margin: EdgeInsets.all(8),
                                    borderRadius: 8,
                                  )..show(context);
                                } catch (error) {
                                  print(error);
                                  const errorMessage = ' حدث خطا ما';
                                  _showErrorDialog(errorMessage);
                                }
                              },
                            ),
                          ),
                        Container(
                          height: 45,
                          margin: const EdgeInsets.fromLTRB(80, 100, 80, 10),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                              side: BorderSide(color: Colors.green, width: 2),
                            ),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'تسجيل خروج',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            onPressed: () {
                              _showErrorDialog("هل تريد تسجيل الخروج");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
