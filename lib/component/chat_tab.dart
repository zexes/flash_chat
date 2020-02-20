import 'package:flutter/material.dart';

class ChatTab extends StatelessWidget {
  final IconData icon;
  final String chatType;
  ChatTab({this.icon, this.chatType});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon),
          SizedBox(
            width: 10.0,
          ),
          Text(chatType)
        ],
      ),
    );
  }
}
