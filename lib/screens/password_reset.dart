import 'package:flash_chat/authentication/auth.dart';
import 'package:flash_chat/component/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utility/alert_error.dart';
import '../utility/constants.dart';

class PasswordResetScreen extends StatefulWidget {
  static String id = 'password_reset_screen';

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  String email;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              }),
        ],
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Password Reset'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                try {
                  await Auth().resetPassword(email);
                  showSpinner = false;
                  AlertAndError.alertButton(
                      AlertType.success,
                      context,
                      'PASSWORD RESET',
                      'Reset link sent to email',
                      LoginScreen.id);
                } on PlatformException catch (e) {
                  showSpinner = false;
                  AlertAndError.errorHandler(e, context, LoginScreen.id);
                } catch (e) {
                  showSpinner = false;
                  AlertAndError.generalError(e, context, LoginScreen.id);
                }
              },
              title: 'Reset Password',
            ),
          ],
        ),
      ),
    );
  }
}
