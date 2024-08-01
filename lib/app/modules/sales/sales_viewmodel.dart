import 'package:stacked/stacked.dart';

class SalesViewModel extends BaseViewModel {
  final String _title = 'COMING SOON';
  String get title => _title;

  String? data;
  int counter = 0;

  void initialize() async {}

  void incrementCounter() {
    counter++;
    data = 'Counter: $counter';
    notifyListeners();
  }
}
