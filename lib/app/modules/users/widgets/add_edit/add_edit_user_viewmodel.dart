import 'package:hook_diner/app/modules/users/users_viewmodel.dart';
import 'package:hook_diner/core/models/user.dart';

class AddEditUserViewModel extends UsersViewModel {
  void setUpModal(User user) async {
    usernameController.text = user.username ?? '';
    passwordController.text = user.password ?? '';
    roleController.text = user.role ?? '';
  }

  void updateRole(String role) {
    roleController.text = role;
    notifyListeners();
  }

  void closeModal() {
    navigator.back();
  }
}
