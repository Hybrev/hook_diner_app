import 'package:hook_diner/app/shared/viewmodel.dart';

class CustomerViewModel extends SharedViewModel {
  final String _title = 'Customer List';
  String get title => _title;

  String? data;
  int currentIndex = 0;

  void initialize() async {
    print('viewModel initialized');
  }
}
