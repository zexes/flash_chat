import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/component/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 125.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              color: Colors.blueAccent,
              onPressed: () async {
                String authError;
                try {
                  print(email);
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email.trim(), password: password);
                  if (newUser != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } catch (e) {
                  print(e);
                  switch (e.code) {
                    case 'ERROR_INVALID_EMAIL':
                      authError = 'Invalid Email';
                      break;
                    case 'ERROR_USER_NOT_FOUND':
                      authError = 'User Not Found';
                      break;
                    case 'ERROR_WRONG_PASSWORD':
                      authError = 'Wrong Password';
                      break;
                    case 'ERROR_NETWORK_REQUEST_FAILED':
                      authError = 'network request failed';
                      break;
                    default:
                      authError =
                          'An error occured kindly restart app and try again';
                      break;
                  }
                  print(authError);
                }
              },
              title: 'Register',
            )
          ],
        ),
      ),
    );
  }
}
