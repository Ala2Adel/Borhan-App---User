import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExternalDonation extends StatefulWidget {
  @override
  _ExternalDonationState createState() => _ExternalDonationState();
}

class _ExternalDonationState extends State<ExternalDonation> {
  final Completer<WebViewController>_controller = new Completer<WebViewController>();
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
            
                child: Scaffold(
              appBar: AppBar(
                title: const  Text('التبرعات الخارجية'),
              ),
              body: Stack(
                children: <Widget>[
                  new WebView(
                    initialUrl:"https://pay.jumia.com.eg/services/donations",
                    javascriptMode: JavascriptMode.unrestricted,onWebViewCreated: (WebViewController webViewController){
                      _controller.complete(webViewController);
                    },
                    onPageFinished: (_) {
                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),
                  _isLoading ? Center( child: CircularProgressIndicator()) : Container(),
                ],
              ),
            ),
          );
          
        }
      
        Future<bool> _onBackPressed() {
           return showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      elevation: 25.0
      ,
      title: new Text('هل تود الخروج ؟'),
      content: new Text('هل تريد الخروج من التبرعات الخارجية'),
      
      actions: <Widget>[
        


        new GestureDetector(
          onTap: () => Navigator.of(context).pop(false),
          child: Text("لا"),
        ),
        SizedBox(width: 30),
        new GestureDetector(
          onTap: () => Navigator.of(context).pop(true),
          child: Text("نعم"),
        ),
      ],
    ),
  ) ??
      false;
  }
}