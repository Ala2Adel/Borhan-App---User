import 'package:Borhan_User/models/activites.dart';
import 'package:Borhan_User/models/organization.dart';
import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/providers/usersProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../Animation/FadeAnimation.dart';
import 'dart:core';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

//extension IndexedIterable<E> on Iterable<E> {
//  Iterable<T> mapIndexed<T>(T f(E e, int i)) {
//    var i = 0;
//    return this.map((e) => f(e, i++));
//  }
//}
//enum DenotationMode { Monetary , Eyes}

class FastDenotationScreen extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _FastDenotationScreenState createState() => _FastDenotationScreenState();
}

class _FastDenotationScreenState extends State<FastDenotationScreen> {
  String selectedType;
  // Organization  selectedOraginzaton;
  var selectedOraginzaton;
  Activity selectedActivity;
  var _loading = true;

  var firstForm = true;
  var scondForm = false;
  var thirdForm = false;
  var current = 1;

  var next = true;
  var prev = false;
  List<Organization> _orgList = [];
  List<Activity> _activitesList = [];

  List<String> _denoteType = <String>[
    'نقدى',
    'عينى',
    'نقدى وعينى',
  ];
  // DenotationMode _denotationMode = DenotationMode.Eyes;
  List<IconData> _denoteIcons = <IconData>[
    FontAwesomeIcons.moneyBill,
    FontAwesomeIcons.eye,
    Icons.looks_two,
  ];

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  TextEditingController moneyController = new TextEditingController();
  TextEditingController itemsController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();

  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'mobile': '',
    'address': '',
    'time': '',
    'money': '',
    'items': '',
    'amount': '',
  };

  void _nextSubmit(){
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
        if (current < 3) {
          if (current == 2 &&(selectedType == null || selectedOraginzaton == null ||
              selectedActivity == null)) {
            _showErrorDialog( "من فضلك اختار نوع التبرع والجمعية والنشاط الذى تود التبرع له");
             } 
              else {                 
               current++;
                  }
          }
                                // print("the current is $current");
          setState(() {
              checkCurrent();
          });

  }
  Future<void> _submit(BuildContext context) async {
    print("Container pressed");
    // Scaffold.of(ctx).showSnackBar(SnackBar(content: Text('Profile Save'),),);
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
      if (selectedType != 'نقدى')
    {
      _downloadUrl = await uploadImage(_image);
      print("value from upload" + _downloadUrl);
    }

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm EEE d MMM y').format(now);
    //String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM y').format(now);
    print(formattedDate);
    final data = Provider.of<Auth>(context);
    try {
      await Provider.of<UsersPtovider>(context, listen: false)
          .makeDonationRequest2(
          userId: data.userData.id,
              orgId: _orgList[selectedOraginzaton].id,
              availableOn: _authData['time'],
              donationAmount: _authData['amount'],
              donationDate: formattedDate,
              donationType: selectedType,
              activityName:selectedActivity.activityName,
              donatorAddress: _authData['address'],
              donatorItems: _authData['items'],
              image: _downloadUrl,
              mobile: _authData['mobile'],
              userName: _authData['name']);
      final snackBar = SnackBar(
          content: Text(
        'تم ارسال طلب تبرعك بنجاح',
        style: TextStyle(color: Color(0xff11b719)),
      ));
      Scaffold.of(context).showSnackBar(snackBar);
    } catch (error) {
      print(error);
      const errorMessage = ' حدث خطا ما';
      _showErrorDialog(errorMessage);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  final globalKey = GlobalKey<ScaffoldState>();
//  void _switchDenotationMode() {
//    if (_denotationMode == DenotationMode.Eyes) {
//      setState(() {
//        _denotationMode = DenotationMode.Monetary;
//      });
//    } else {
//      setState(() {
//        _denotationMode = DenotationMode.Eyes;
//      });
//    }
//  }
  var _isLoadImg = false;
  File _image;
  String _downloadUrl;

  Future getImage() async {
    File img;
    img = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = img;
      _isLoadImg = true;
    });

  }

  Future<String> uploadImage(File image) async {
    print("upload ");
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(image.path.split('/').last);
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded sucessfully ');
    String _downloadUrl = await storageReference.getDownloadURL();
    print('----------------------------------------------------------');
    print(" uploading URL :  " + _downloadUrl);
    print('----------------------------------------------------------');
    return _downloadUrl;
  }

  void _showErrorDialog(String message) {
    print("alert");
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('تحذير'),
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

  Future<void> getActivites(String orgId) async {
    _loading = true;

    _activitesList = [];
    selectedActivity = null;
    final url = 'https://borhanadmin.firebaseio.com/activities/$orgId.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      //  print((response.body));
      final List<Activity> loadedOrganizations = [];
      extractedData.forEach((prodId, prodData) {
//        if(selectedOraginzaton.id==prodData['org_id'])
//        if(  _orgList[selectedOraginzaton].id==prodData['org_id'])
//        {
        loadedOrganizations.add(Activity(
            id: prodId,
//            orgId: prodData['org_id'],
            activityName: prodData['name'],
            activityImage: prodData['image'],
            description: prodData['description']));
//        }
      });
      _loading = false;
      setState(() {
        _activitesList = loadedOrganizations;
      });
      // notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> getOrganizations() async {
    const url =
        'https://borhanadmin.firebaseio.com/CharitableOrganizations.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print((response.body));
      final List<Organization> loadedOrganizations = [];
      extractedData.forEach((prodId, prodData) {
        loadedOrganizations.add(Organization(
          id: prodId,
          orgName: prodData['orgName'],
          address: prodData['address'],
          logo: prodData['logo'],
          description: prodData['description'],
          landLineNo: prodData['landLineNo'],
          licenseNo: prodData['licenceNo'],
          mobileNo: prodData['mobileNo'],
          bankAccounts: prodData['bankAccounts'],
          webPage: prodData['webPage'],
        ));
      });

      setState(() {
        _orgList = loadedOrganizations;
      });
      // notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void checkCurrent() {
    if (current == 1) {
      firstForm = true;
      scondForm = false;
      thirdForm = false;
      next = true;
      prev = false;
    } else if (current == 2) {
      prev = true;
      firstForm = false;
      scondForm = true;
      thirdForm = false;
      if (selectedType != 'نقدى') {
        next = true;
      } else {
        next = false;
      }
    } else if (current == 3) {
      prev = true;
      firstForm = false;
      scondForm = false;
      thirdForm = true;
      next = false;
    }
  }

  @override
  void initState() {
    super.initState();
    this.getOrganizations();
  }

  @override
  void didChangeDependencies() {
    this.getOrganizations();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * (2 / 7);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text("التبرع السريع",
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
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
                    width: width,
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/burhan.jpg'),
                                  fit: BoxFit.fill)),
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 20,
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
                            if (firstForm) ///////////first form
                              Container(
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
//                                  labelText:'اسم المتبرع',
                                            hintText: "اسم المتبرع",
                                            prefixIcon: Icon(
                                              Icons.person,
                                              color: Colors.deepPurple,
                                            ),
                                            hintStyle:
                                                TextStyle(color: Colors.grey)),
//                              textAlign: TextAlign.end,
                                   validator: (value) {
                                     if (value.length<3 || value==null) {
                                       bool spaceRex = new RegExp(r"^\\s+$").hasMatch(value);
                                       if(spaceRex || value.length==0){
                                         return 'اادخل الاسم من فضلك';
                                       }else{
                                         return'الاسم لايمكن ان يكون اقل من ثلاثه احرف';
                                       }

                                     }
                                     return null;
                                   },
//                                    onSaved: (value) {
//                                      _authData['name'] = value;
//                                    },
                                        onChanged: (value) {
                                          _authData['name'] = value;
                                        },
                                        controller: nameController,
                                      ),
                                    ),
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
                                     bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                                     if (!emailValid) {
                                       return 'ايميل غيرصالح';
                                     }
                                 //    return null;
                                   },
//                                    onSaved: (value) {
//                                      _authData['email'] = value;
//                                    },
                                        onChanged: (value) {
                                          _authData['email'] = value;
                                        },

                                        controller: emailController,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "رقم التلفون المحمول",
                                            prefixIcon: Icon(
                                              Icons.mobile_screen_share,
                                              color: Colors.deepPurple,
                                            ),
                                            hintStyle:
                                                TextStyle(color: Colors.grey)),
//                              textAlign: TextAlign.end,
                                        keyboardType: TextInputType.number,
//                                    onSaved: (value) {
//                                      _authData['mobile'] = value;
//                                    },
                                        onChanged: (val) {
                                          _authData['mobile'] = val;
                                        },
                                        controller: mobileController,
//                                    validator: (value) {
//                                      if (value.length<11 || value==null) {
//                                          return'رقم الهاتف لايمكن ان يكون اقل من 11 رقم';
//                                      }
//                                      return null;
//                                    },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2.0)),
                                            labelText: "العنوان",
                                            // hintStyle: TextStyle(color: Colors.grey ,fontSize: 18),
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 24)),
//                              textAlign: TextAlign.end,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        minLines: 2,
//                                    onSaved: (value) {
//                                      _authData['address'] = value;
//                                    },
                                        onChanged: (val) {
                                          _authData['address'] = val;
                                        },
//                                    validator: (value) {
//                                      if (value.length<5 || value==null) {
//                                        bool spaceRex = new RegExp(r"^\\s+$").hasMatch(value);
//                                        if(spaceRex || value.length==0){
//                                          return 'اادخل العنوان من فضلك';
//                                        }else{
//                                          return'العنوان لايمكن ان يكون اقل من 5 احرف';
//                                        }
//
//                                      }
//                                      return null;
//                                    },
                                        controller: addressController,
                                      ),
                                    ),
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 0),
                                        child: Text(
                                          'اكتب الوقت الذى تكون فيه متاح لكي ياتى مندوبنا اليك',
                                          style: TextStyle(
                                              fontSize: 17,
                                              height: 1,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2.0)),
                                            prefixIcon: Icon(
                                              Icons.access_time,
                                              color: Colors.deepPurple,
                                            ),
                                            // hintStyle: TextStyle(color: Colors.grey ,fontSize: 18),
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 24)),
//                              textAlign: TextAlign.end,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        minLines: 2,
//                                    onSaved: (value) {
//                                      _authData['time'] = value;
//                                    },
                                        onChanged: (val) {
                                          _authData['time'] = val;
                                        },
                                        controller: timeController,
//                                    validator: (value) {
//                                        bool spaceRex = new RegExp(r"^\\s+$").hasMatch(value);
//                                        if(spaceRex || value.length==0  || value==null){
//                                          return 'اادخل الوقت من فضلك';
//                                      }
//                                      return null;
//                                    },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
//////////////////////////////////////////////////////////////////////
                            if (scondForm)
                              Container(
                                child: Column(children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.solidBuilding,
                                          size: 25.0,
                                          color: Colors.deepPurple,
                                        ),
                                        SizedBox(width: 50.0),
                                        Expanded(
                                          child: DropdownButton(
//                                              items: _orgList.mapIndexed((value , index ) => DropdownMenuItem(
                                            items: _orgList
                                                .map(
                                                  (value) => DropdownMenuItem(
                                                    // index = _orgList.indexOf(value);
                                                    child: Row(
                                                      children: <Widget>[
//                                          Icon(
//                                            _denoteIcons[index],
//                                            size: 25.0,
//                                            color:Color(0xff11b719),
//                                          ),
                                                        SizedBox(width: 50.0),
                                                        Text(
                                                          value.orgName,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ],
                                                    ),
                                                    value:
                                                        _orgList.indexOf(value),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (selected) {
                                              print('$selected');
                                              setState(() {
                                                selectedOraginzaton = selected;
                                              });
                                              this.getActivites(
                                                  _orgList[selectedOraginzaton]
                                                      .id);
                                            },
                                            value: selectedOraginzaton,
                                            isExpanded: false,
                                            hint: Text(
                                              'اختار الجمعية',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  _loading
                                      ? CircularProgressIndicator()
                                      : Container(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 0, 20, 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                FontAwesomeIcons
                                                    .galacticRepublic,
                                                size: 25.0,
                                                color: Colors.deepPurple,
                                              ),
                                              SizedBox(width: 50.0),
                                              Expanded(
                                                child: DropdownButton(
                                                  items: _activitesList
                                                      .map(
                                                        (value) =>
                                                            DropdownMenuItem(
                                                          child: Row(
                                                            children: <Widget>[
//                                          Icon(
//                                            _denoteIcons[index],
//                                            size: 25.0,
//                                            color:Color(0xff11b719),
//                                          ),
                                                              SizedBox(
                                                                  width: 50.0),
                                                              Text(
                                                                value
                                                                    .activityName,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                          value: value,
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChanged:
                                                      (selectedAccountType) {
                                                    print(
                                                        '$selectedAccountType');
                                                    setState(() {
                                                      selectedActivity =
                                                          selectedAccountType;
                                                    });
                                                  },
                                                  value: selectedActivity,
                                                  isExpanded: false,
                                                  hint: Text(
                                                    'اختار النشاط',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.handsHelping,
                                        size: 25.0,
                                        color: Colors.deepPurple,
                                      ),
                                      SizedBox(width: 50.0),
                                      DropdownButton(
                                        items: _denoteType
                                            .map(
                                              (value) => DropdownMenuItem(
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      _denoteIcons[_denoteType
                                                          .indexOf(value)],
                                                      size: 25.0,
                                                      color: Color(0xff11b719),
                                                    ),
                                                    SizedBox(width: 50.0),
                                                    Text(
                                                      value,
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff11b719)),
                                                    ),
                                                  ],
                                                ),
                                                value: value,
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (selectedAccountType) {
                                          print('$selectedAccountType');
                                          setState(() {
                                            selectedType = selectedAccountType;
                                            if (selectedType == 'نقدى' &&
                                                scondForm) {
                                              next = false;
                                            } else {
                                              next = true;
                                            }
                                          });
                                        },
                                        value: selectedType,
                                        isExpanded: false,
                                        hint: Text(
                                          'اختار نوع التبرع',
                                          style: TextStyle(
                                              color: Color(0xff11b719)),
                                        ),
                                      )
                                    ],
                                  ),
                                  if (selectedType == 'نقدى' ||
                                      selectedType == 'نقدى وعينى')
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: " المبلغ بالجنيه المصرى ",
                                            prefixIcon: Icon(
                                              FontAwesomeIcons.moneyBill,
                                              color: Colors.deepPurple,
                                            ),
                                            hintStyle:
                                                TextStyle(color: Colors.grey)),
//                              textAlign: TextAlign.end,
                                        keyboardType: TextInputType.number,
//                                        onSaved: (value) {
//                                          _authData['amount'] = value;
//                                        },
                                        onChanged: (value) {
                                          _authData['amount'] = value;
                                        },
                                        controller: moneyController,
//                                        validator: (value) {
//                                          bool spaceRex = new RegExp(r"^\\s+$").hasMatch(value);
//                                          if(spaceRex || value.length==0  || value==null){
//                                            return 'اادخل المبلغ من فضلك';
//                                          }
//                                          return null;
//                                        },
                                      ),
                                    ),
                                ]),
                              ),
///////////////////////////////////////////////////////
                            if (thirdForm)
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    //  if (selectedType != 'نقدى')
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.camera,
                                            size: 25.0,
                                            color: Colors.deepPurple,
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                              child: Text("اضف صورة التبرع",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)))
                                        ],
                                      ),
                                    ),

                                    //   if (selectedType != 'نقدى')
                                    InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        color: Colors.grey[300],
                                        width: 200,
                                        height: 200,
                                        child: _isLoadImg
                                            ? Image.file(_image)
                                            : Icon(
                                                Icons.add,
                                                size: 40,
                                              ),
                                      ),
                                      onTap: getImage,
                                    ),

                                    //    if (selectedType != 'نقدى')
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 0),
                                        child: Text(
                                          'اكتب مواصفات ونوع الاشياء والكمية التي تود التبرع بها ',
                                          style: TextStyle(
                                              fontSize: 17,
                                              height: 1,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    // if (selectedType != 'نقدى')
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 0),
                                        child: Text(
                                          ' مثال:3 اطقم ملابس و 2بطاطين....',
                                          style: TextStyle(
                                              fontSize: 14,
                                              height: 1,
                                              color: Colors.grey),
                                        )),
                                    // if (selectedType != 'نقدى')
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 10),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2.0)),
                                            labelText: "الوصف",
                                            // hintStyle: TextStyle(color: Colors.grey ,fontSize: 18),
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 24)),
//                              textAlign: TextAlign.end,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        minLines: 3,
//                                    onSaved: (value) {
//                                      _authData['items'] = value;
//                                    },
                                        onChanged: (value) {
                                          _authData['items'] = value;
                                        },
                                        controller: itemsController,
//                                    validator: (value) {
//                                      bool spaceRex = new RegExp(r"^\\s+$").hasMatch(value);
//                                      if(spaceRex || value.length==0  || value==null){
//                                        return 'اادخل الوصف من فضلك';
//                                      }
//                                      return null;
//                                    },
                                      ),
                                    ),
//                                    Container(
//                                        padding:
//                                            EdgeInsets.fromLTRB(10, 5, 10, 0),
//                                        child: Text(
//                                          'اكتب كمية او عدد الاشياء التي تود التبرع بها ',
//                                          style: TextStyle(
//                                              fontSize: 17,
//                                              height: 1,
//                                              fontWeight: FontWeight.bold),
//                                        )),
//                                    // if (selectedType != 'نقدى')
//
//                                    // if (selectedType != 'نقدى')
//                                    Container(
//                                      padding:
//                                          EdgeInsets.fromLTRB(10, 5, 10, 10),
//                                      child: TextFormField(
//                                        decoration: InputDecoration(
//                                            border: OutlineInputBorder(
//                                                borderRadius:
//                                                    BorderRadius.circular(2.0)),
//                                            labelText: "الكمية",
//                                            // hintStyle: TextStyle(color: Colors.grey ,fontSize: 18),
//                                            labelStyle: TextStyle(
//                                                color: Colors.grey,
//                                                fontSize: 24)),
////                              textAlign: TextAlign.end,
//                                        keyboardType: TextInputType.multiline,
//                                        maxLines: null,
//                                        minLines: 3,
////                                  onSaved: (value) {
////                                    _authData['amount'] = value;
////                                  },
//                                        onChanged: (value) {
//                                          _authData['amount'] = value;
//                                        },
//                                        controller: amountController,
////                                  validator: (value) {
////                                    bool spaceRex = new RegExp(r"^\\s+$").hasMatch(value);
////                                    if(spaceRex || value.length==0  || value==null){
////                                      return 'اادخل اكمية من فضلك';
////                                    }
////                                    return null;
////                                  },
//                                      ),
//                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  next
                      ? FadeAnimation(
                          1.9,
                          InkWell(
                            onTap:()=> _nextSubmit(),
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 60),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromRGBO(49, 39, 79, 1),
                              ),
                              child: Center(
                                child: Text(
                                  "التالى",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      : FadeAnimation(
                          1.9,
                          Builder(
                            builder: (ctx) => InkWell(
                              onTap: () =>
                                  _submit(ctx), // handle your onTap here
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 60),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromRGBO(49, 39, 79, 1),
                                ),
                                child: Center(
                                  child: Text(
                                    "تبرع الأن",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  if (prev)
                    FadeAnimation(
                      2,
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                        child: Center(
                          child: FlatButton(
                            child: FlatButton(
                              child: Text(
                                "السابق",
                                style: TextStyle(
                                    color: Color.fromRGBO(49, 39, 79, .6)),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (current > 1) {
                                    current--;
                                  }

                                  checkCurrent();
                                });
                              },
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
      ), 
    );
  }
}
