import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hook_diner/app/routes/route_names.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';

class LoginViewModel extends SharedViewModel {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;

  void logIn({required String username, required String password}) async {
    setBusy(true);

    try {
      await auth.logIn(username: username, password: password);

      setBusy(false);
      toMainMenu();
    } on FirebaseAuthException catch (e) {
      String title = '', message = '';
      switch (e.code) {
        case 'network-request-failed':
          title = 'Network Error';
          message = 'No internet connection. Please try again.';
          break;
        case 'invalid-email':
          title = 'Invalid Credentials';
          message = 'Username not found. Please try again.';
          break;
        case 'wrong-password':
          title = 'Invalid Credentials';
          message = 'Incorrect password. Please try again.';
          break;
        case 'invalid-credential':
          title = 'Invalid Credentials';
          message = 'Please check your credentials and try again.';
          break;

        default:
          title = 'Authentication Error';
          message = 'Please enter a valid username and password.';
          break;
      }
      await dialog.showDialog(
        title: title,
        description: message,
      );
    } finally {
      setBusy(false);
    }
  }

  void streamAuth() async {
    await auth.logOut();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print(user == null
          ? 'User is currently signed out!'
          : 'user details: $user');
    });
  }

  void toMainMenu() {
    navigator.pushNamedAndRemoveUntil(homeRoute);
  }
}
