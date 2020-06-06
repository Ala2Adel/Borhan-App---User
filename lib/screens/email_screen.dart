import 'dart:async';
import 'dart:io';

import '../providers/email_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/emailm.dart';

class EmailScreen extends StatefulWidget {
//  static const routeName = '/email';
  var orgEmail;
  EmailScreen(this.orgEmail);

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
//  final requestId = ModalRoute.of(context).settings.arguments as String;
  var emailM = EmailM(
      recipientController: '', subjectController: '', bodyController: '');
  List<String> attachments = [];

  final _recipientController = TextEditingController(
//    text: widget.orgEmail,
);

  final _subjectController = TextEditingController();

  final _bodyController = TextEditingController();

  void send() {
    emailM = EmailM(
        recipientController: widget.orgEmail,
        subjectController: emailM.subjectController,
        bodyController: emailM.bodyController);
    Provider.of<EmailProvider>(context, listen: false)
        .send(emailM, attachments);
  }

  @override
  Widget build(BuildContext context) {
    _recipientController.text = widget.orgEmail;
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.teal),
      home: Scaffold(
        appBar: AppBar(
          title: Text('طلب مساعدة بالبريد الإلكتروني'),
          actions: <Widget>[
            IconButton(
              onPressed: send,
              icon: Icon(Icons.send),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('مستقبل الرساله'),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _recipientController,
                    readOnly: true,
//                    onTap: () {
//                      emailM = EmailM(
//                        recipientController: _recipientController.text,
//                        bodyController: emailM.bodyController,
//                        subjectController: emailM.subjectController,
//                      );
//                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Text('الموضوع'),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _subjectController,
                    textDirection: TextDirection.rtl,
                    onChanged: (val) {
                      emailM = EmailM(
                        recipientController: emailM.recipientController,
                        bodyController: emailM.bodyController,
                        subjectController: val,
                      );
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Text('المضمون'),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _bodyController,
                    textDirection: TextDirection.rtl,
                    onChanged: (val) {
                      emailM = EmailM(
                        recipientController: emailM.recipientController,
                        bodyController: val,
                        subjectController: emailM.subjectController,
                      );
                    },
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ...attachments.map(
                  (item) => Text(
                    item,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.teal,
          icon: Icon(Icons.camera),
          label: Text(
            'إضافة صورة',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          onPressed: _openImagePicker,
        ),
      ),
    );
  }

  void _openImagePicker() async {
    File pick = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      attachments.add(pick.path);
    });
  }
}
