import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/models/item.dart';

class OrderViewModel extends SharedViewModel {
  final String _title = 'Order Menu';
  String get title => _title;

  List<Item> _menuItems = [];
  List<Item> get menuItems => _menuItems;

  List<Item> _filteredMenuItems = [];
  List<Item> get filteredMenuItems => _filteredMenuItems;

  List<Item> _orderedItems = [];
  List<Item> get orderedItems => _orderedItems;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  int _totalItems = 0;
  int get totalItems => _totalItems;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  final TextEditingController searchBarController = TextEditingController();
  final TextEditingController selectedCategoryController =
      TextEditingController();

  bool? _isRegularCustomer;
  bool? get isRegularCustomer => _isRegularCustomer;

  void initialize() async {
    setBusy(true);

    _categories = await database.getCategories();
    _categories.insert(0, Category(id: 'all', title: 'All'));

    searchBarController.text = '';
    selectedCategoryController.text = _categories.first.id.toString();

    _menuItems = await database.getItems();
    _filteredMenuItems = _menuItems;

    _isRegularCustomer = false;

    notifyListeners();
    setBusy(false);

    /* STREAM APPROACH, REMOVED FOR NOW */
    // database.listenToItems().listen((items) {
    //   items.sort((a, b) => a.name!.compareTo(b.name!));

    //   List<Item> updatedItems = items;
    //   if (updatedItems.isNotEmpty) {
    //     _menuItems = updatedItems;

    //     // filters out the available items & sorts alphabetically

    //     _filteredMenuItems =
    //         _menuItems.where((item) => item.quantity! > 0).toList();
    //     notifyListeners();
    //   }
    //   setBusy(false);
    // });
  }

  void updateCustomerStatus(bool value) {
    _isRegularCustomer = value;
    notifyListeners();
  }

  void updateCategoryFilter(String value) {
    selectedCategoryController.text = value;
    switch (value != 'all') {
      case true:
        _filteredMenuItems =
            _menuItems.where((item) => item.category?.id == value).toList();
        break;
      default:
        _filteredMenuItems = _menuItems;
        break;
    }
    notifyListeners();
  }

  void updateSearchText(String value) {
    searchBarController.text = value;

    _filteredMenuItems = _menuItems
        .where((item) => item.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void addItemToOrder(Item item) {
    _orderedItems.add(item);
    _totalPrice = _totalPrice + item.price!;
    _totalItems++;
    notifyListeners();
  }

  void removeItemFromOrder(Item item) {
    print('item: ${item.toJson()}');
    _orderedItems.remove(item);
    _totalPrice = _totalPrice - item.price!;
    _totalItems--;
    notifyListeners();
    if (_orderedItems.isEmpty) {
      navigator.back();
    }
  }

  Future<String> getItemCategory(Item item) {
    return database.getItemCategory(item);
  }

  void clearOrder() {
    _orderedItems = [];
    _totalItems = 0;
    _totalPrice = 0.0;
    notifyListeners();
    navigator.back();
  }
}
