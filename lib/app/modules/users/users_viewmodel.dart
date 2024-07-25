import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/user.dart';

class UsersViewModel extends SharedViewModel {
  final String _title = 'Users';
  String get title => _title;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  late User currentUser;

  List<User>? _users;
  List<User>? get users => _users;

  void initialize() {
    setBusy(true);
    database.listenToUsers().listen((usersData) {
      List<User> updatedUsers = usersData;
      if (updatedUsers.isNotEmpty) {
        _users = updatedUsers;
        notifyListeners();
      }
      notifyListeners();
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

  Future deleteUser(User user) async {
    final dialogResponse = await dialog.showConfirmationDialog(
      description: 'Are you sure you want to delete this user?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse!.confirmed) {
      setBusy(true);

      try {
        await auth.deleteUser(user);

        await dialog.showDialog(
          title: 'SUCCESS',
          description: 'User deleted successfully!',
        );
      } catch (e) {
        await dialog.showDialog(
          title: 'ERROR',
          description: 'Failed to delete user',
        );
      } finally {
        setBusy(false);

        goBack();
        ();
      }
    }
  }
}
