import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/data/categories.dart';
import 'package:hook_diner/core/models/category.dart';

class InventoryViewModel extends SharedViewModel {
  final String _title = 'Inventory';
  String get title => _title;

  final List<Category> _categories = categoryList;
  List<Category> get categories => _categories;

  String? data;

  void goBack() {
    navigator.back();
  }
}
