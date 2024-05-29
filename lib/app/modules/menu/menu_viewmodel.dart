import 'package:stacked/stacked.dart';

class MenuViewModel extends BaseViewModel {
  final String _title = 'Order Menu';
  String get title => _title;

  String? data;
  int counter = 0;

  void initialize() async {
    print('viewModel initialized');
  }

  void incrementCounter() {
    print('incrementing counter');
    counter++;
    data = 'Counter: $counter';
    notifyListeners();
  }
}
