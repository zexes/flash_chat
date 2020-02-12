import 'package:emoji_picker/emoji_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/authentication/auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/utility/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utility/alert_error.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();

  String messageText;
  bool isShowSticker;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
    isShowSticker = false;
  }

  Future<bool> onBackPressEmoji() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  void getCurrentUser() async {
    try {
      final user = await Auth().currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Auth().signOut(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Color(0xFF4CAF50),
      ),
      body: SafeArea(
        child: WillPopScope(
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  MessagesStream(),
                  Container(
                    decoration: kMessageContainerDecoration,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Material(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.0),
                            child: IconButton(
                              icon: Icon(Icons.face),
                              onPressed: () {
                                setState(() {
                                  isShowSticker = !isShowSticker;
                                });
                              },
                              color: Colors.blueGrey,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        Expanded(
                          child: TextField(
                            controller: messageTextController,
                            onChanged: (value) {
                              messageText = value;
                            },
                            decoration: kMessageTextFieldDecoration,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            print('am here');
                            messageTextController.clear();
                            _fireStore.collection('messages').add({
                              'text': messageText,
                              'sender': loggedInUser.email,
                              'time': FieldValue.serverTimestamp(),
                            });
                          },
                          color: Colors.lightBlueAccent,
                        ),
                      ],
                    ),
                  ),
                  (isShowSticker ? buildSticker() : Container()),
                ],
              ),
            ],
          ),
          onWillPop: onBackPressEmoji,
        ),
      ),
    );
  }

  Widget buildSticker() {
    return EmojiPicker(
      rows: 3,
      columns: 7,
      buttonMode: ButtonMode.MATERIAL,
      recommendKeywords: ["racing", "horse"],
      numRecommended: 10,
      onEmojiSelected: (emoji, category) {
        messageTextController.text += emoji.emoji;
        print(emoji.emoji);
        print(category.toString());
      },
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection('messages')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messagesBubbles = [];

        // when no data available no need add inAsyncCall  to
        // CircularProgressIndicator which we control because
        // once data is available StreamBuilder rebuilds itself as
        // documentation says and hence CircularProgressIndicator is
        // destroyed
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents;
        for (var message in messages) {
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];

          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe:
                currentUser == messageSender, // auto Check ast it produces bool
          );
          messagesBubbles.add(messageBubble);
        }
        return Expanded(
          //so as not cover the send button
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 20.0), // enable scrolling
            children: messagesBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  final bool isMe;

  MessageBubble({this.text, this.sender, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
