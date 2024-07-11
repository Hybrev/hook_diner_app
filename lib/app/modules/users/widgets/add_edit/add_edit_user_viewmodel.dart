import 'package:hook_diner/app/modules/users/users_viewmodel.dart';
import 'package:hook_diner/core/models/user.dart';

class AddEditUserViewModel extends UsersViewModel {
  late final String prevUsername;
  late final String prevPassword;

  void setUpModal(User? user) async {
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

    User user = User(
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
        title: 'User Added',
        description: 'User added successfully',
      );
      navigator.back();
    } catch (e) {
      await dialog.showDialog(
        title: 'Error',
        description: 'Failed to add user',
      );
    }
    setBusy(false);
  }

  Future updateUser(User targetUser) async {
    targetUser = User(
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
          title: 'User Updated!',
          description: 'User updated successfully',
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
