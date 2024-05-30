import 'package:hook_diner/core/data/categories.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:stacked/stacked.dart';

class InventoryViewModel extends BaseViewModel {
  final String _title = 'Inventory';
  String get title => _title;

  final List<Category> _categories = categoryList;
  List<Category> get categories => _categories;

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
