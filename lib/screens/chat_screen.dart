import 'package:emoji_picker/emoji_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/authentication/auth.dart';
import 'package:flash_chat/component/chat_tab.dart';
import 'package:flash_chat/module/messages/messages_stream.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/utility/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Auth().signOut(context);
                }),
          ],
          bottom: TabBar(
            indicatorWeight: 3.0,
            indicatorColor: Colors.red,
            tabs: <Widget>[
              ChatTab(icon: Icons.person, chatType: "Single Chat"),
              ChatTab(icon: Icons.people, chatType: "Group Chat"),
            ],
          ),
          title: Text('⚡️Chat'),
          backgroundColor: Color(0xFF4CAF50),
        ),
        body: SafeArea(
          child: WillPopScope(
            child: TabBarView(
              children: <Widget>[
                Container(
                  child: Center(child: Text("SINGLE CHAT TO BE IMPLEMENTED")),
                ),
                Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        MessagesStream(
                          fireStore: _fireStore,
                          loggedInUser: loggedInUser,
                        ),
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
              ],
            ),
            onWillPop: onBackPressEmoji,
          ),
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
