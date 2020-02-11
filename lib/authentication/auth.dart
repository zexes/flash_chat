import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
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
          Navigator.pushNamed(context, ChatScreen.id);
        } else {
          AlertAndError.alertButton(AlertType.info, context, "VERIFY EMAIL",
              "Verification mail sent to registered mail", LoginScreen.id);
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
  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pop(context, LoginScreen.id);
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
