import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../models/chat.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';
  final orgId;

  ChatScreen({this.orgId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // the id for specific user (admin chat with him)
//  var id = '1212145f';
  var _enteredMessage = '';
  var _isInit = true;
  var chat =
  Chat(time: '', text: '', userId: '', userName: '', img: '', id: null);

  final _controller = new TextEditingController();
  var data;

  void _sendMessage() {
    print('from _send message text = ' + _enteredMessage);
    print('from _send message text from add message = ' + chat.text);
    FocusScope.of(context).unfocus();
    final data = Provider.of<Auth>(context);
    chat = Chat(
      img: chat.img,
      text: _enteredMessage,
      userName: chat.userName,
      userId: chat.userId,
      id: chat.id,
      time: chat.time,
    );
    Provider.of<ChatProvider>(context, listen: false)
        .addMessage(chat, data.userData.email.split('.com')[0], widget.orgId)
        .then((value) => {
      print('from _send message email from add message = ' + data.userData.email),
//    print('from _send message text from add message = ' + _enteredMessage),
      _controller.clear(),
      _enteredMessage = '',
      print('from add message'),
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    data = Provider.of<Auth>(context);
    if (_isInit) {
      print(widget.orgId);
      Provider.of<ChatProvider>(context)
          .fetchAndSetChat(data.userData.email.split('.com')[0], widget.orgId);
    }
    _isInit = false;
    chat = Chat(
        time: '',
        text: '',
        userId: data.userData.id,
        userName: data.userData.email.split('@')[0],
        img: '',
        id: null);
//    print('user Data');
//    print(data.userData);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final chatDocs = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('المحادثة'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: chatDocs.fetchAndSetChat(data.userData.email.split('.com')[0], widget.orgId),
                builder: (ctx, futureSnapshot) {
//                  if (futureSnapshot.connectionState ==
//                      ConnectionState.waiting) {
//                    return Center(
//                      child: CircularProgressIndicator(),
//                    );
//                  }
                  return StreamBuilder(builder: (ctx, chatSnapshot) {
//                    if (chatSnapshot.connectionState ==
//                        ConnectionState.waiting) {
//                      return Center(
//                        child: CircularProgressIndicator(),
//                      );
//                    }
                    return ListView.builder(
                      reverse: true,
                      itemCount: chatDocs.items.length,
                      itemBuilder: (_, index) => MessageBubble(
                        chatDocs.items[index].text,
                        chatDocs.items[index].userName,
                        chatDocs.items[index].userName == "Admin",
                      ),
                    );
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(labelText: 'كتابة رسالة ...'),
//                      onTap: () {
////                        _isInit = true;
//                      },
                      onChanged: (value) {
                        setState(() {
                          _enteredMessage = value;
                        });
                        print('from wigdet value is : ' + value);
                        print('from wigdet entered message is : ' + _enteredMessage);
//                        _isInit = true;
//                        chat = Chat(
//                          img: chat.img,
//                          text: _enteredMessage,
//                          userName: chat.userName,
//                          userId: chat.userId,
//                          id: chat.id,
//                          time: chat.time,
//                        );
                        print('from wigdet chat.text is : ' + chat.text);
                      },
                    ),
                  ),
                  IconButton(
                    color: Theme.of(context).primaryColor,
                    icon: Icon(
                      Icons.send,
                    ),
                    onPressed:
                    _enteredMessage.trim().isEmpty ? null : _sendMessage,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
