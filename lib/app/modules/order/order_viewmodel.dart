import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/item.dart';

class OrderViewModel extends SharedViewModel {
  final String _title = 'Order Menu';
  String get title => _title;

  List<Item> _items = [];
  List<Item> get items => _items;

  List<Item> _orderedItems = [];
  List<Item> get orderedItems => _orderedItems;
  final TextEditingController searchBarController = TextEditingController();

  void initialize() async {
    database.listenToItems();
  }

  void incrementCounter() {
    print('incrementing counter');
    notifyListeners();
  }
}
