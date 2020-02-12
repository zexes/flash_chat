import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/utility/alert_error.dart';
import 'package:flash_chat/authentication/auth.dart';
import 'package:flash_chat/component/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utility/constants.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  String email;
  String password;
  String confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value.trim();
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
                  password = value.trim();
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  confirmPassword = value.trim();
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Confirm your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  if (password != confirmPassword) {
                    AlertAndError.alertButton(
                        AlertType.error,
                        context,
                        'Password Check',
                        'Password does not match',
                        RegistrationScreen.id);
                    showSpinner = false;
                    return;
                  }
                  bool spinnerFlag = await Auth()
                      .signUp(email, password, context, RegistrationScreen.id);
                  AlertAndError.alertButton(
                      AlertType.success,
                      context,
                      'Registration',
                      'Registration Successful',
                      LoginScreen.id);
                  setState(() {
                    showSpinner = !spinnerFlag;
                  });
                },
                title: 'Register',
              )
            ],
          ),
        ),
      ),
    );
  }
}
