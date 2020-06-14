import 'package:Borhan_User/models/activity.dart';
import 'package:Borhan_User/models/organization.dart';
import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/providers/usersProvider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Animation/FadeAnimation.dart';
import 'dart:core';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:io' show Platform;

class FastDonationScreen extends StatefulWidget {
  @override
  _FastDonationScreenState createState() => _FastDonationScreenState();
}

class _FastDonationScreenState extends State<FastDonationScreen> {
  String selectedType;
  Future formatDates;

  var selectedOraginzaton;
  Activity selectedActivity;
  var _loading = false;
  var _submitLoading = false;

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

  void _nextSubmit() {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    if (current < 3) {
      if (current == 2 &&
          (selectedType == null ||
              selectedOraginzaton == null ||
              selectedActivity == null)) {
        _showErrorDialog(
            "من فضلك اختر نوع التبرع والجمعية والنشاط الذى تود التبرع له");
      } else {
        current++;
      }
    }

    setState(() {
      checkCurrent();
    });
  }

  Future<void> _submit(BuildContext context) async {
    String amount = _authData['amount'];
    String items = _authData['items'];

    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }

    if (_image == null && selectedType != 'نقدى') {
      _showErrorDialog("من فضلك اضف صورة تبرعك ");
      return;
    }

    _formKey.currentState.save();

    setState(() {
      _submitLoading = true;
    });

    if (selectedType != 'نقدى') {
      _downloadUrl = await uploadImage(_image);
      if (selectedType == 'عينى') {
        amount = "";
      }
    } else {
      items = "";
      _downloadUrl =
          'https://www.moneyunder30.com/wp-content/uploads/2018/05/2_how-to-invest-648x364-c-default.jpg';
    }

    var arabicTimeFormat = DateFormat.Hms('ar');
    var arabicDateFormat = DateFormat.yMd('ar');

    String formattedTime = arabicTimeFormat.format(DateTime.now());
    String formattedDate = arabicDateFormat.format(DateTime.now());
    String arabicFormattedDateTime = formattedTime + ' ' + formattedDate;

    final data = Provider.of<Auth>(context);
    try {
      await Provider.of<UsersPtovider>(context, listen: false)
          .makeDonationRequest2(
              userId: data.userData.id,
              orgId: _orgList[selectedOraginzaton].id,
              availableOn: _authData['time'],
              donationAmount: amount,
              donationDate: arabicFormattedDateTime,
              donationType: selectedType,
              activityName: selectedActivity.name,
              donatorAddress: _authData['address'],
              donatorItems: items,
              image: _downloadUrl,
              orgName: _orgList[selectedOraginzaton].orgName,
              mobile: _authData['mobile'],
              userName: _authData['name']);
      Flushbar(
        message: 'تم ارسال طلب تبرعك بنجاح',
        icon: Icon(
          Icons.thumb_up,
          size: 28.0,
          color: Colors.blue[300],
        ),
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(8),
        borderRadius: 8,
      )..show(context) //;
          .then((value) => Navigator.of(context).pop());
    } catch (error) {
      print(error);
      const errorMessage = ' حدث خطا ما';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _submitLoading = false;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  final globalKey = GlobalKey<ScaffoldState>();
  var _isLoadImg = false;
  File _image;
  String _downloadUrl;

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

  Future<String> uploadImage(File image) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(image.path.split('/').last);
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;

    String _downloadUrl = await storageReference.getDownloadURL();

    return _downloadUrl;
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => (Platform.isAndroid)
            ? AlertDialog(
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
              )
            : CupertinoAlertDialog(
                title: const Text('تحذير'),
                content: Text(message),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text("حسنا"),
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ));
  }

  Future<void> getActivites(String orgId) async {
    _loading = true;

    _activitesList = [];
    selectedActivity = null;
    final url = 'https://borhanadmin.firebaseio.com/activities/$orgId.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      final List<Activity> loadedOrganizations = [];
      extractedData.forEach((prodId, prodData) {
        loadedOrganizations.add(Activity(
            id: prodId,
            name: prodData['name'],
            image: prodData['image'],
            description: prodData['description']));
      });
      _loading = false;
      setState(() {
        _activitesList = loadedOrganizations;
      });
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
    initializeDateFormatting();

    this.getOrganizations();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * (2 / 7);

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
                    height: height,
                    width: width,
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/images/BorhanLogo3.png'),
                          )),
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
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
                            if (firstForm)
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
                                            hintText: "اسم المتبرع",
                                            prefixIcon: Icon(
                                              Icons.person,
                                              color: Colors.deepPurple,
                                            ),
                                            hintStyle:
                                                TextStyle(color: Colors.grey)),
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
                                            hintText: "رقم التلفون المحمول",
                                            prefixIcon: Icon(
                                              Icons.mobile_screen_share,
                                              color: Colors.deepPurple,
                                            ),
                                            hintStyle:
                                                TextStyle(color: Colors.grey)),
                                        keyboardType: TextInputType.number,
                                        onChanged: (val) {
                                          _authData['mobile'] = val;
                                        },
                                        controller: mobileController,
                                        validator: (value) {
                                          bool spaceRex = new RegExp(r"^\\s+$")
                                              .hasMatch(value);
                                          if (spaceRex ||
                                              value.length == 0 ||
                                              value == null) {
                                            return 'ادخل رقم الهاتف من فضلك';
                                          } else if (value.length < 11) {
                                            return 'رقم الهاتف لايمكن ان يكون اقل من 11 رقم';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2.0)),
                                            labelText: "العنوان",
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 24)),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        minLines: 2,
                                        onChanged: (val) {
                                          _authData['address'] = val;
                                        },
                                        validator: (value) {
                                          bool spaceRex = new RegExp(r"^\\s+$")
                                              .hasMatch(value);
                                          if (spaceRex ||
                                              value.length == 0 ||
                                              value == null) {
                                            return 'ادخل العنوان من فضلك';
                                          } else if (value.length < 5) {
                                            return 'العنوان لايمكن ان يكون اقل من 5 احرف';
                                          }
                                          return null;
                                        },
                                        controller: addressController,
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 10, 0),
                                        child: const Text(
                                          'اكتب الوقت الذى تكون فيه متاح لكي يأتي مندوبنا اليك',
                                          style: TextStyle(
                                              fontSize: 17,
                                              height: 1,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 10),
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
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 24)),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        minLines: 2,
                                        onChanged: (val) {
                                          _authData['time'] = val;
                                        },
                                        controller: timeController,
                                        validator: (value) {
                                          bool spaceRex = new RegExp(r"^\\s+$")
                                              .hasMatch(value);
                                          if (spaceRex ||
                                              value.length == 0 ||
                                              value == null) {
                                            return 'ادخل الوقت من فضلك';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (scondForm)
                              Container(
                                child: Column(children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(20),
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
                                            items: _orgList
                                                .map(
                                                  (value) => DropdownMenuItem(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          value.orgName,
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                            hint: const Text(
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
                                          padding: const EdgeInsets.fromLTRB(
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
                                                              Text(
                                                                value.name,
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
                                                  hint: const Text(
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
                                        hint: const Text(
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
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          _authData['amount'] = value;
                                        },
                                        controller: moneyController,
                                        validator: (value) {
                                          bool spaceRex = new RegExp(r"^\\s+$")
                                              .hasMatch(value);
                                          if (spaceRex ||
                                              value.length == 0 ||
                                              value == null) {
                                            return 'ادخل المبلغ من فضلك';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                ]),
                              ),
                            if (thirdForm)
                              Container(
                                child: Column(
                                  children: <Widget>[
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
                                              child: const Text(
                                                  "اضف صورة التبرع",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)))
                                        ],
                                      ),
                                    ),
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
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 10, 0),
                                        child: Text(
                                          'اكتب مواصفات ونوع الاشياء والكمية التي تود التبرع بها ',
                                          style: TextStyle(
                                              fontSize: 17,
                                              height: 1,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 10, 0),
                                        child: Text(
                                          ' مثال:3 اطقم ملابس و 2بطاطين....',
                                          style: TextStyle(
                                              fontSize: 14,
                                              height: 1,
                                              color: Colors.grey),
                                        )),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 10),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2.0)),
                                            labelText: "الوصف",
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 24)),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        minLines: 3,
                                        onChanged: (value) {
                                          _authData['items'] = value;
                                        },
                                        controller: itemsController,
                                        validator: (value) {
                                          bool spaceRex = new RegExp(r"^\\s+$")
                                              .hasMatch(value);
                                          if (spaceRex ||
                                              value.length == 0 ||
                                              value == null) {
                                            return 'ادخل الوصف من فضلك';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
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
                            onTap: () => _nextSubmit(),
                            child: Container(
                              height: 50,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromRGBO(49, 39, 79, 1),
                              ),
                              child: Center(
                                child: const Text(
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
                              onTap: () {
                                if (!_submitLoading) {
                                  _submit(ctx);
                                }
                              },
                              child: Container(
                                height: 50,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 60),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromRGBO(49, 39, 79, 1),
                                ),
                                child: Center(
                                  child: _submitLoading == false
                                      ? Text(
                                          "تبرع الأن",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : CircularProgressIndicator(),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
