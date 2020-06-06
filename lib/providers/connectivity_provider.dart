import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class ConnectivityProvider with ChangeNotifier {

StreamSubscription _connectivitySubscription;
ConnectivityResult _previousResult;
bool _dialogShown = false;

StreamSubscription get connectivitySubscription{
  return _connectivitySubscription;
}

bool get dialogShown{
  return _dialogShown;
}

ConnectivityResult get previousResult{
  return _previousResult;
}




 Future<bool> checkinternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Future.value(true);
      }
    } on SocketException catch (_) {
      return Future.value(false);
    }
  }

  Future<ConnectivityResult> checkConnectivity (BuildContext context) async {
var value;
    _connectivitySubscription =  Connectivity().onConnectivityChanged.listen((ConnectivityResult connresult) {
    if(connresult == ConnectivityResult.none){
      _dialogShown = true;
      showDialog(context: context,
      barrierDismissible: false,
      child: AlertDialog(
        title: const Text(
          'حدث خطأ ما '
        ),
        content: Text(
          'فقدنا الاتصال بالانترنت  ،\n تأكد من اتصالالك وحاول مرة أخرى'
        ),
        actions: <Widget>[
          FlatButton(onPressed: ()=>{
           SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
          
          }, child: Text('خروج ',style: TextStyle(color: Colors.red),))
        ],
      )
      );

    }
    
  _previousResult = connresult;
 value = connresult;
print(value);
  print('from provider');
  print(_previousResult);

   });

return value;
//  
  }
}

