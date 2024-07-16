import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/item.dart';

class OrderViewModel extends SharedViewModel {
  final String _title = 'Order Menu';
  String get title => _title;

  List<Item> _menuItems = [];
  List<Item> get menuItems => _menuItems;

  List<Item> _orderedItems = [];
  List<Item> get orderedItems => _orderedItems;

  int _totalItems = 0;
  int get totalItems => _totalItems;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  final TextEditingController searchBarController = TextEditingController();

  void initialize() async {
    setBusy(true);
    _menuItems = await database.getItems();
    _menuItems.sort((a, b) => a.name!.compareTo(b.name!));
    notifyListeners();

    for (var item in _menuItems) {
      print('item: ${item.toJson()}');
    }
  }

  void addItemToOrder(Item item) {
    _orderedItems.add(item);
    _totalPrice = _totalPrice + item.price!;
    _totalItems++;
    notifyListeners();
  }

  getItemCategory(String uid) {}

  void clearOrders() {
    _orderedItems = [];
    _totalItems = 0;
    _totalPrice = 0.0;
    notifyListeners();
  }
}
