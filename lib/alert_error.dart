import 'dart:io';

import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertAndError {
  static void alertButton(AlertType alertType, BuildContext context,
      String title, String description) {
    Alert(
      context: context,
      type: alertType,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
          width: 120,
        )
      ],
    ).show();
  }

  static void errorHandler(PlatformException e, BuildContext context) {
    String authError;
    String errorMessage;
    if (Platform.isIOS) {
      switch (e.code) {
        case 'Error 17011':
          authError = 'User Not Found';
          errorMessage = e.message;
          alertButton(AlertType.error, context, authError, errorMessage);
          break;
        case 'Error 17009':
          authError = 'Password Not Valid';
          errorMessage = e.message;
          alertButton(AlertType.error, context, authError, errorMessage);
          break;
        case 'Error 17020':
          authError = 'Network Error';
          errorMessage = e.message;
          alertButton(AlertType.error, context, authError, errorMessage);
          break;
        default:
          print('Case ${e.message} is not just implemented');
      }
    } else {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          authError = 'Invalid Email';
          errorMessage = e.message;
          print('$authError  ===== $errorMessage');
          alertButton(AlertType.error, context, authError, errorMessage);
          break;
        case 'ERROR_USER_NOT_FOUND':
          authError = 'User Not Found';
          errorMessage = e.message;
          print('$authError  ===== $errorMessage');
          alertButton(AlertType.error, context, authError, errorMessage);
          break;
        case 'ERROR_WRONG_PASSWORD':
          authError = 'Wrong Password';
          errorMessage = e.message;
          print('$authError  ===== $errorMessage');
          alertButton(AlertType.error, context, authError, errorMessage);
          break;
        case 'ERROR_NETWORK_REQUEST_FAILED':
          authError = 'Network error';
          errorMessage = e.message;
          print('$authError  ===== $errorMessage');
          alertButton(AlertType.error, context, authError, errorMessage);
          break;
        default:
          authError = 'Error';
          errorMessage = e.message;
          print('$authError  ===== $errorMessage');
          alertButton(AlertType.error, context, authError, errorMessage);
          break;
      }
    }
  }
}
