import 'package:flash_chat/authentication/auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/profile_screen.dart';
import 'package:flash_chat/utility/constants.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: FlatButton(
              child: Text(
                'Menu',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('images/nature.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Color(0xFF8BC34A)),
            title: Text('Home', style: kSideMenu),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart, color: Color(0xFF8BC34A)),
            title: Text('Order menu', style: kSideMenu),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.chat_bubble, color: Color(0xFF8BC34A)),
            title: Text('Chat', style: kSideMenu),
            onTap: () => Navigator.pushNamed(context, ChatScreen.id),
          ),
          ListTile(
            leading: Icon(Icons.border_color, color: Color(0xFF8BC34A)),
            title: Text('Feedback', style: kSideMenu),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.person_outline, color: Color(0xFF8BC34A)),
            title: Text('Profile', style: kSideMenu),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ProfileScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Color(0xFF8BC34A)),
            title: Text('Settings', style: kSideMenu),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Color(0xFF8BC34A)),
            title: Text('Logout', style: kSideMenu),
            onTap: () async {
              Navigator.pop(context);
              await Auth().signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
