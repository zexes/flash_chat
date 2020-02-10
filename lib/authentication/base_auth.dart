import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class BaseAuth {
  Future<bool> signIn(String email, String password, BuildContext context);
  void signOut(BuildContext context);
  Future<bool> signUp(String username, String password, BuildContext context);
  Future<FirebaseUser> currentUser();
  Future<void> resetPassword(String email);
}
