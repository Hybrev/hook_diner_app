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
  final TextEditingController searchBarController = TextEditingController();

  void initialize() async {
    _menuItems = await database.getItems();
    notifyListeners();
  }

  void incrementCounter() {
    print('incrementing counter');
    notifyListeners();
  }
}
