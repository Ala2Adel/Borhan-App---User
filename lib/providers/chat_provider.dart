import 'dart:io';
import '../models/chat.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatProvider with ChangeNotifier {
  List<Chat> _items = [];

  List<Chat> get items {
    return [..._items];
  }

  Future<void> fetchAndSetChat(String id, String orgId) async {
//    id = 'sj34ZIYOs6PUW4jxE93lWl35b1H3';
    final url = 'https://borhanadmin.firebaseio.com/chat/$orgId/$id.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Chat> loadedChat = [];
      if (extractedData != null) {
        extractedData.forEach((messageId, chatData) {
          loadedChat.insert(
              0,
              Chat(
                id: messageId,
                userName: chatData['name'],
                userId: chatData['userId'],
                text: chatData['text'],
                img: chatData['image'],
              ));
        });
        _items = loadedChat;
        notifyListeners();
      } else {
        print('No Data in this chat');
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addMessage(Chat chat, String id, String orgId) async {
    // id is the user id not admin
//    id = 'sj34ZIYOs6PUW4jxE93lWl35b1H3';
    print('chat message add message '+ chat.text);
    final url = 'https://borhanadmin.firebaseio.com/chat/$orgId/$id.json';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'name': chat.userName,
            'userId': chat.userId,
//            'userId': 'sj34ZIYOs6PUW4jxE93lWl35b1H3',
            'text': chat.text,
            'image': chat.img,
            'time': DateTime.now().toString(),
          },
        ),
      );
      final newMessage = Chat(
        id: json.decode(response.body)['name'],
        userId: chat.userId,
        userName: chat.userName,
        text: chat.text,
        img: chat.img,
        time: DateTime.now().toString(),
      );
//      _items.add(newMessage);
      _items.insert(0, newMessage);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<String> uploadImage(File image) async {
    print("in upload");
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(image.path.split('/').last);
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    String _downloadUrl = await storageReference.getDownloadURL();
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
        '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    print("from uploading :  " + _downloadUrl);
    return _downloadUrl;
  }
}
