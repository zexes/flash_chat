import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'messages_bubble.dart';

class MessagesStream extends StatelessWidget {
  final Firestore fireStore;
  final FirebaseUser loggedInUser;

  MessagesStream({this.fireStore, this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fireStore
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
