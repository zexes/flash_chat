import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utility/alert_error.dart';
import 'base_auth.dart';

class Auth implements BaseAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<bool> signIn(String email, String password, BuildContext context,
      String screen) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        if (user.user.isEmailVerified) {
          Navigator.pushNamed(context, HomeScreen.id);
        } else {
          AlertAndError.alertButton(AlertType.info, context, "VERIFY EMAIL",
              "Verification mail sent to registered mail", screen);
        }
      }
      return true;
    } on PlatformException catch (e) {
      AlertAndError.errorHandler(e, context, screen);
      return false;
    } catch (e) {
      AlertAndError.generalError(e, context, screen);
      return false;
    }
  }

  @override
  Future<void> signOut(BuildContext context) async {
    Navigator.pushNamed(context, WelcomeScreen.id);
    await _auth.signOut();
  }

  @override
  Future<bool> signUp(String email, String password, BuildContext context,
      String screen) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      if (newUser != null) {
        await newUser.user.sendEmailVerification();
        return true;
      }
      return true;
    } on PlatformException catch (e) {
      AlertAndError.errorHandler(e, context, screen);
      return false;
    } catch (e) {
      AlertAndError.generalError(e, context, screen);
      return false;
    }
  }

  @override
  Future<FirebaseUser> currentUser() {
    return _auth.currentUser();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
