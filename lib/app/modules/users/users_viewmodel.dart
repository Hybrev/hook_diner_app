import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/user.dart';

class UsersViewModel extends SharedViewModel {
  final String _title = 'Users';
  String get title => _title;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  List<User>? _users;
  List<User>? get users => _users;

  void initialize() async {
    setBusy(true);
    database.listenToUsers().listen((usersData) {
      List<User> updatedUsers = usersData;
      if (updatedUsers.isNotEmpty) {
        _users = updatedUsers;
        notifyListeners();
      }

      setBusy(false);
    });

    /* MANUAL APPROACH */
    // final fetchedUsers = await database.getUsers();
    // print('fetchedUsers: $fetchedUsers');
    // setBusy(false);
    // if (fetchedUsers is! List<User>) {
    //   await dialog.showDialog(
    //     title: 'Error',
    //     description: 'Failed to fetch users',
    //   );
    //   return;
    // }
    // _users = fetchedUsers;
    // notifyListeners();
  }

  void addUser() async {
    setBusy(true);

    User user = User(
      username: usernameController.text,
      password: passwordController.text,
      role: roleController.text,
    );

    try {
      final response = await auth.createUser(
        username: user.username!,
        password: user.password!,
        role: user.role!,
      );
      if (response) {
        await dialog.showDialog(
          title: 'User Added',
          description: 'User added successfully',
        );
        navigator.back();
      }
    } catch (e) {
      print('error: $e');
      await dialog.showDialog(
        title: 'Error',
        description: 'Failed to add user',
      );
    }
    setBusy(false);
  }

  Future updateUser(User user) async {
    print('received user: ${user.toJson().toString()}');
    setBusy(true);
    try {
      final response = await database.updateUser(user);

      if (response) {
        await dialog.showDialog(
          title: 'User Updated!',
          description: 'User updated successfully',
        );
        navigator.back();
      }
    } catch (e) {
      await dialog.showDialog(
        title: 'Error',
        description: 'Failed to updated user',
      );
    }
    setBusy(false);
  }

  Future deleteUser(String id) async {
    final dialogResponse = await dialog.showConfirmationDialog(
      description: 'Are you sure you want to delete this user?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse!.confirmed) {
      setBusy(true);

      try {
        final response = await database.deleteUser(id);
        print('response: $response');
        setBusy(false);

        await dialog.showDialog(
          title: 'User Deleted',
          description: 'User deleted successfully',
        );
      } catch (e) {
        setBusy(false);

        await dialog.showDialog(
          title: 'Error',
          description: 'Failed to delete user',
        );
      } finally {
        navigator.back();
      }
    }
  }
}
