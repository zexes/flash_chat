import 'dart:io';

import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertAndError {
  static void alertButton(AlertType alertType, BuildContext context,
      String title, String description, String screen) {
    Alert(
      context: context,
      type: alertType,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          child:
              Text("Ok", style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => Navigator.pushNamed(context, screen),
          width: 120,
        )
      ],
    ).show();
  }

  static Future<bool> alertButtonCloseCurrentScreen(AlertType alertType,
      BuildContext context, String title, String description) {
    return Alert(
          context: context,
          type: alertType, //AlertType.warning,
          title: title, //"ARE YOU SURE",
          desc: description, //"Do you want to close the curent screen",
          buttons: [
            DialogButton(
              child: Text(
                "YES",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.of(context).pop(true),
              color: Colors.red,
            ),
            DialogButton(
              child: Text(
                "NO",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.of(context).pop(false),
              color: Color.fromRGBO(0, 179, 134, 1.0),
            )
          ],
        ).show() ??
        false;
  }

  static void errorHandler(PlatformException e, BuildContext context) {
    if (Platform.isIOS) {
      switch (e.code) {
        case 'Error 17011':
          alertButton(AlertType.error, context, 'User Not Found', e.message,
              LoginScreen.id);
          break;
        case 'Error 17009':
          alertButton(AlertType.error, context, 'Password Not Valid', e.message,
              LoginScreen.id);
          break;
        case 'Error 17020':
          alertButton(AlertType.error, context, 'Network Error', e.message,
              LoginScreen.id);
          break;
        default:
          print('Case ${e.message} is not just implemented');
      }
    } else {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          alertButton(AlertType.error, context, 'Invalid Email', e.message,
              LoginScreen.id);
          break;
        case 'ERROR_USER_NOT_FOUND':
          alertButton(AlertType.error, context, 'User Not Found', e.message,
              LoginScreen.id);
          break;
        case 'ERROR_WRONG_PASSWORD':
          alertButton(AlertType.error, context, 'Wrong Password', e.message,
              LoginScreen.id);
          break;
        case 'ERROR_NETWORK_REQUEST_FAILED':
          alertButton(AlertType.error, context, 'Network error', e.message,
              LoginScreen.id);
          break;
        default:
          alertButton(
              AlertType.error, context, 'Error', e.message, LoginScreen.id);
          break;
      }
    }
  }
}
