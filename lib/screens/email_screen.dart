import 'dart:io';
import '../providers/email_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/emailm.dart';

class EmailScreen extends StatefulWidget {
  final orgEmail;
  EmailScreen(this.orgEmail);

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  var emailM = EmailM(
      recipientController: '', subjectController: '', bodyController: '');
  List<String> attachments = [];

  final _recipientController = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلب مساعدة بالبريد الإلكتروني'),
        actions: <Widget>[
          IconButton(
            onPressed: send,
            icon: Icon(Icons.open_in_new),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
          
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('مستقبل الرساله'),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _recipientController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            const   Text('الموضوع'),
              Padding(
                padding: const  EdgeInsets.all(8.0),
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
        
        icon: Icon(Icons.camera),
        label: const  Text(
          'إضافة صورة',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        onPressed: _openImagePicker,
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