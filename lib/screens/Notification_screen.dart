import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  // final String title;
  // Notification(this.title)
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الإشعارات"),
        
      ),
      body: Center(child: Text("Notification History")),
      
      
    );
  }
}