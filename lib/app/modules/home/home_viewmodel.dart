import 'package:stacked/stacked.dart';

class HomeViewModel extends IndexTrackingViewModel {
  @override
  int currentIndex = 2;

  @override
  void setIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }
}
