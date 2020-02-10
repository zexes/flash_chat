import 'package:flash_chat/alert_error.dart';
import 'package:flash_chat/authentication/auth.dart';
import 'package:flash_chat/component/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email;
  String password;

//  void signIn() async {
//    try {
//      final user = await _auth.signInWithEmailAndPassword(
//        email: email,
//        password: password,
//      );
//      if (user != null) {
//        Navigator.pushNamed(context, ChatScreen.id);
//      }
//      setState(() {
//        showSpinner = false;
//      });
//    } on PlatformException catch (e) {
//      AlertAndError.errorHandler(e, context);
//    }
//
//  }

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
                height: 30.0,
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
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  if (email == null || password == null) {
                    AlertAndError.alertButton(
                        AlertType.warning,
                        context,
                        'Wrong format',
                        'Email or Password is empty',
                        LoginScreen.id);
                    return;
                  }
//                  signIn();
                  bool spinnerOpp =
                      await Auth().signIn(email, password, context);

                  setState(() {
                    showSpinner = !spinnerOpp;
                  });
                },
                title: 'Log in',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'Forgot Password',
                      style: kLoginText,
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  FlatButton(
                    child: Text(
                      'Sign Up/Register',
                      style: kLoginText,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
