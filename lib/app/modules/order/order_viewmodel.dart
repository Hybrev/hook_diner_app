import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/models/item.dart';

class OrderViewModel extends SharedViewModel {
  final String _title = 'Order Menu';
  String get title => _title;

  List<Item> _menuItems = [];
  List<Item> get menuItems => _menuItems;

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

  void initialize() async {
    setBusy(true);

    _categories = await database.getCategories();
    notifyListeners();
    _categories.insert(0, Category(id: 'all', title: 'All'));
    selectedCategoryController.text = _categories.first.id.toString();

    database.listenToItems().listen((items) {
      List<Item> updatedItems = items;
      if (updatedItems.isNotEmpty) {
        _menuItems = updatedItems;

        // filters out the available items & sorts alphabetically

        _menuItems = _menuItems.where((item) => item.quantity! > 0).toList();
        _menuItems.sort((a, b) => a.name!.compareTo(b.name!));
        notifyListeners();
      }
      setBusy(false);
    });
  }

  void addItemToOrder(Item item) {
    _orderedItems.add(item);
    _totalPrice = _totalPrice + item.price!;
    _totalItems++;
    notifyListeners();

    print('item category: ${item.category}');
  }

  Future<String> getItemCategory(Item item) {
    return database.getItemCategory(item);
  }

  void updateCategoryFilter(String value) {
    selectedCategoryController.text = value;
    notifyListeners();
  }

  void clearOrders() {
    _orderedItems = [];
    _totalItems = 0;
    _totalPrice = 0.0;
    notifyListeners();
  }
}
