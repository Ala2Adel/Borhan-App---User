import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  String userId;
//  final user = await FirebaseAuth.instance.currentUser();
  void _getCurrentUserId() async {
    final user = await FirebaseAuth.instance.currentUser();
    userId = user.uid;
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
//  return user.uid;
  }

  @override
  Widget build(BuildContext context) {
    print('from messages list view build');
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
//        print('user id : ' + userId);
        return StreamBuilder(
            stream: Firestore.instance
                .collection('/orgchat/-M8mbvDXI0a6SG24CwAX/$userId')
                .orderBy(
                  'createdAt',
                  descending: true,
                )
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data.documents;
//              print('Chat Docs are : ');
//              print(chatDocs);
              return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => MessageBubble(
                  chatDocs[index]['text'],
                  chatDocs[index]['username'],
                  chatDocs[index]['userId'] == futureSnapshot.data.uid,
                  key: ValueKey(chatDocs[index].documentID),
                ),
              );
            });
      },
    );
  }
}
