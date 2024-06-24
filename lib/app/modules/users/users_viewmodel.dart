import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/user.dart';

class UsersViewModel extends SharedViewModel {
  final String _title = 'Users';
  String get title => _title;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  void initialize() async {
    print('viewModel initialized');
  }

  void addUser() async {
    setBusy(true);

    User user = User(
      username: usernameController.text,
      password: passwordController.text,
      role: roleController.text,
    );

    final response = await auth.createUser(
      username: user.username!,
      password: user.password!,
      role: user.role!,
    );
    print('response: $response');

    setBusy(false);
  }
}
