import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExternalDonation extends StatefulWidget {
  @override
  _ExternalDonationState createState() => _ExternalDonationState();
}

class _ExternalDonationState extends State<ExternalDonation> {
  final Completer<WebViewController> _controller =
      new Completer<WebViewController>();
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
          title: const Text('التبرعات الخارجية'),
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          children: <Widget>[
            new WebView(
              initialUrl: "https://pay.jumia.com.eg/services/donations",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageFinished: (_) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
            _isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                      Text(
                        'جاري توجيهك الى صفحة خارجية \n عن تطبيق برهان ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            backgroundColor: Colors.black54,
                            color: Colors.white,
                            fontSize: 25.0),
                      )
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => (Platform.isAndroid)
              ? new AlertDialog(
                  elevation: 25.0,
                  title: const Text('الخروج'),
                  content: const Text('هل تريد الخروج من التبرعات الخارجية ؟'),
                  actions: <Widget>[
                    new GestureDetector(
                      onTap: () => Navigator.of(context).pop(false),
                      child: Text("لا"),
                    ),
                    SizedBox(width: 30),
                    new GestureDetector(
                      onTap: () => Navigator.of(context).pop(true),
                      child: const Text("نعم",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
              : CupertinoAlertDialog(
                  title: const Text('الخروج'),
                  content: const Text('هل تريد الخروج من التبرعات الخارجية ؟'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: const Text("نعم",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                      isDefaultAction: true,
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                    CupertinoDialogAction(
                      child: const Text("لا"),
                      onPressed: () => Navigator.of(context).pop(false),
                    )
                  ],
                ),
        ) ??
        false;
  }
}