import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../app_localizations.dart';

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
          title: Text(
              AppLocalizations.of(context).translate('External_Donations')),
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
                        AppLocalizations.of(context).translate('redirect'),
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
                  title: Text(AppLocalizations.of(context).translate('exit')),
                  content: Text(AppLocalizations.of(context).translate('sure')),
                  actions: <Widget>[
                    new GestureDetector(
                      onTap: () => Navigator.of(context).pop(false),
                      child: Text(AppLocalizations.of(context).translate('no')),
                    ),
                    SizedBox(width: 30),
                    new GestureDetector(
                      onTap: () => Navigator.of(context).pop(true),
                      child: Text(
                          AppLocalizations.of(context).translate('yes_string'),
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
              : CupertinoAlertDialog(
                  title: Text(AppLocalizations.of(context).translate('exit')),
                  content: Text(AppLocalizations.of(context).translate('sure')),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text(
                          AppLocalizations.of(context).translate('yes_string'),
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                      isDefaultAction: true,
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                    CupertinoDialogAction(
                      child: Text(AppLocalizations.of(context).translate('no')),
                      onPressed: () => Navigator.of(context).pop(false),
                    )
                  ],
                ),
        ) ??
        false;
  }
}
