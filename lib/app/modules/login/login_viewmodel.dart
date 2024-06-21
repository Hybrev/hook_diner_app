import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hook_diner/app/routes/route_names.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:hook_diner/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigator = locator<NavigationService>();
  final DialogService _dialog = locator<DialogService>();
  final AuthService _auth = locator<AuthService>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;

  void logIn({required String username, required String password}) async {
    setBusy(true);

    try {
      await _auth.logIn(username: username, password: password);

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
        case 'invalid-credential':
          title = 'Invalid Credentials';
          message = 'Incorrect password. Please try again.';
          break;
        case 'channel-error':
          title = 'Authentication Error';
          message = 'Please enter a valid username and password.';
          break;
      }
      await _dialog.showDialog(
        title: title,
        description: message,
      );
    } finally {
      setBusy(false);
    }
  }

  void toMainMenu() {
    _navigator.pushNamedAndRemoveUntil(homeRoute);
  }
}
