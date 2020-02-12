import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static String id = 'profile_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF4CAF50),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ProfileButton(
            icon: Icons.account_circle,
            label: 'Account',
            description: 'update details, change password, ...',
            onPressed: () {},
          ),
          ProfileButton(
            icon: Icons.attach_money,
            label: 'Top up',
            description: 'recharge your account',
            onPressed: () {},
          ),
          ProfileButton(
            icon: Icons.file_download,
            label: 'Chat History Download',
            description: 'download chat history with range',
            onPressed: () {},
          ),
          ProfileButton(
            icon: Icons.contact_phone,
            label: 'Customer Service',
            description: 'excellent customer service',
            onPressed: () {},
          ),
          ProfileButton(
            icon: Icons.settings,
            label: 'Settings',
            description: 'update details, change password, ...',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final Function onPressed;

  const ProfileButton(
      {@required this.icon,
      @required this.label,
      @required this.description,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 45.0,
            color: Color(0xFFE8A456),
          ),
          SizedBox(
            width: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(fontSize: 30.0, color: Color(0xFF689F38)),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 20.0, color: Color(0xFF757575)),
              )
            ],
          )
        ],
      ),
      onPressed: onPressed,
    );
  }
}
