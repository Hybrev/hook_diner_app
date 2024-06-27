import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/models/item.dart';

class InventoryViewModel extends SharedViewModel {
  final String _title = 'Inventory';
  String get title => _title;

  List<Category>? _categories;
  List<Category>? get categories => _categories;

  List<Item>? _items;
  List<Item>? get items => _items;

  void initialize() {
    getCategories();
  }

  void getCategories() {
    setBusy(true);
    database.listenToCategories().listen((categories) {
      List<Category> updatedCategories = categories;
      if (updatedCategories.isNotEmpty) {
        _categories = updatedCategories;
        _categories?.sort((a, b) => a.title!.compareTo(b.title!));
        notifyListeners();
      }
      setBusy(false);
    });
  }

  void getItems() async {}

  void goBack() {
    navigator.back();
  }
}
