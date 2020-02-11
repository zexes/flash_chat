import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/component/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utility/alert_error.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

//    animation = CurvedAnimation(parent: controller, curve: Curves.elasticOut );// documentation video

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();

//    animation.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        controller.reverse(from: 1.0);
//      } else if (status == AnimationStatus.dismissed) {
//        controller.forward();
//      }
//    });

    controller.addListener(() {
      setState(() {}); // jez calling it will do the work
//      print(animation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> onBackPress() {
    return AlertAndError.alertButtonCloseCurrentScreen(AlertType.warning,
        context, "ARE YOU SURE ", "Do you want to exit the App");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        backgroundColor: animation.value,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60.0, // commented animation could be used here
                    ),
                  ),
                  TypewriterAnimatedTextKit(
                    text: ['Flash Chat'],
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              RoundedButton(
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                title: 'Log In',
              ),
              RoundedButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                title: 'Register',
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: <Widget>[],
              )
            ],
          ),
        ),
      ),
    );
  }
}
