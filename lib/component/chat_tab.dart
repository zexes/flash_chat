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
          Icon(icon, color: Color(0xff757575)),
          SizedBox(
            width: 10.0,
          ),
          Text(
            chatType,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xffDCEDC8),
            ),
          )
        ],
      ),
    );
  }
}
