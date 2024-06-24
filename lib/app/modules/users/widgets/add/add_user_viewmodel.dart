import 'package:hook_diner/app/modules/users/users_viewmodel.dart';

class AddUserViewModel extends UsersViewModel {
  void initializeControllers() async {
    print('modal viewModel initialized');
    usernameController.text = '';
    passwordController.text = '';
    roleController.text = '';
  }

  void updateRole(String role) {
    roleController.text = role;
    notifyListeners();
  }

  void closeModal() {
    navigator.back();
  }
}
