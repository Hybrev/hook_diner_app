import 'package:hook_diner/app/modules/users/users_viewmodel.dart';
import 'package:hook_diner/core/models/user.dart';

class AddEditUserViewModel extends UsersViewModel {
  void setUpModal(User? user) async {
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

  Future updateUser(User user) async {
    print('received user 4 UPDATE: ${user.toJson().toString()}');

    user = User(
      id: user.id,
      username: usernameController.text,
      password: passwordController.text,
      role: roleController.text,
    );

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

  void closeModal() {
    navigator.back();
  }
}
