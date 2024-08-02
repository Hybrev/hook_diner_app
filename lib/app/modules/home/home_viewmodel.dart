import 'package:hook_diner/core/models/user.dart';
import 'package:hook_diner/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends IndexTrackingViewModel {
  final AuthService _auth = AuthService();
  User? _currentUser;
  User? get currentUser => _currentUser;

  @override
  int currentIndex = 0;

  @override
  void setIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }

  void initialize() async {
    _currentUser = await _auth.getCurrentUser();
    notifyListeners();
    print('viewmodel user details: ${_currentUser!.toJson()}');
  }
}
