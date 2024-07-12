import 'package:firebase_auth/firebase_auth.dart';
import 'package:hook_diner/app/modules/users/users_viewmodel.dart';
import 'package:hook_diner/core/models/user.dart' as user_model;

class AddEditUserViewModel extends UsersViewModel {
  late final String prevUsername;
  late final String prevPassword;

  void setUpModal(user_model.User? user) async {
    prevUsername = user?.username ?? '';
    prevPassword = user?.password ?? '';
    usernameController.text = user?.username ?? '';
    passwordController.text = user?.password ?? '';
    roleController.text = user?.role ?? '';
    notifyListeners();
  }

  void updateRole(String role) {
    roleController.text = role;
    notifyListeners();
  }

  void addUser() async {
    setBusy(true);

    user_model.User user = user_model.User(
      username: usernameController.text,
      password: passwordController.text,
      role: roleController.text,
    );

    try {
      await auth.createUser(
        username: user.username!,
        password: user.password!,
        role: user.role!,
      );

      await dialog.showDialog(
        title: 'Success',
        description: 'User added successfully!',
      );
      navigator.back();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          await dialog.showDialog(
            title: 'Password Error',
            description: 'Password must be at least 6 characters',
          );
          break;
        default:
          await dialog.showDialog(
            title: 'Error',
            description: 'Failed to add user',
          );
      }
    }
    setBusy(false);
  }

  Future updateUser(user_model.User targetUser) async {
    targetUser = user_model.User(
      id: targetUser.id,
      username: usernameController.text,
      password: passwordController.text,
      role: roleController.text,
    );

    setBusy(true);
    try {
      final response = await auth.updateUser(
        targetUser,
        prevUsername: prevUsername,
        prevPassword: prevPassword,
      );
      if (response) {
        await dialog.showDialog(
          title: 'Updated!',
          description: 'User updated successfully!',
        );
        navigator.back();
      }
    } catch (e) {
      await dialog.showDialog(
        title: 'Error',
        description: 'Failed to update user',
      );
    }
    setBusy(false);
  }

  void closeModal() {
    navigator.back();
  }
}
