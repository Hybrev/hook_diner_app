import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/models/item.dart';
import 'package:hook_diner/core/models/order.dart';

class OrderViewModel extends SharedViewModel {
  final String _title = 'Order Menu';
  String get title => _title;

  List<Item>? _menuItems;
  List<Item>? get menuItems => _menuItems;

  List<Item>? _filteredMenuItems;
  List<Item>? get filteredMenuItems => _filteredMenuItems;

  List<Item> _orderedItems = [];
  List<Item> get orderedItems => _orderedItems;

  List<Category>? _categories = [];
  List<Category>? get categories => _categories;

  final List<String> _numberCards = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  List<String> get numberCards => _numberCards;

  int _totalItems = 0;
  int get totalItems => _totalItems;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  final TextEditingController searchBarController = TextEditingController();
  final TextEditingController selectedCategoryController =
      TextEditingController();

  bool? _isRegularCustomer;
  bool? get isRegularCustomer => _isRegularCustomer;

  String? _orderCardNumber;
  String? get orderCardNumber => _orderCardNumber;

  void initialize() async {
    setBusy(true);

    _categories = await database.getCategories();
    _categories?.insert(0, Category(id: 'all', title: 'All'));

    searchBarController.text = '';
    selectedCategoryController.text = _categories?.first.id.toString() ?? '';

    _menuItems = await database.getItems();
    _filteredMenuItems = _menuItems;

    _isRegularCustomer = false;
    _orderCardNumber = '1';

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

  Future<String> getItemCategory(Item item) {
    return database.getItemCategory(item);
  }

  void updateCustomerStatus(bool value) {
    _isRegularCustomer = value;
    notifyListeners();
  }

  void updateOrderCardNumber(String value) {
    _orderCardNumber = value;
    notifyListeners();
  }

  void updateCategoryFilter(String value) {
    selectedCategoryController.text = value;
    switch (value != 'all') {
      case true:
        _filteredMenuItems =
            _menuItems?.where((item) => item.category?.id == value).toList();
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
        ?.where(
            (item) => item.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void addItemToOrder(Item item) {
    _orderedItems.add(item);
    _totalPrice = _totalPrice + item.price!;
    _totalItems++;
    notifyListeners();
  }

  void placeOrder() async {
    print('ordered items: ${_orderedItems.length}');

    setBusy(true);
    final Order newOrder = Order(
      orderNumber:
          _orderCardNumber != null ? int.tryParse(_orderCardNumber!) : null,
      totalPrice: _totalPrice.toDouble(),
      orderStatus: 'unpaid',
      orderDate:
          '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}',
    );
    notifyListeners();

    try {
      setBusy(true);
      final response =
          await database.addOrder(newOrder, orderedItems: _orderedItems);
      if (response) {
        setBusy(false);
        goBack();
        ();
        await dialog.showDialog(
          title: 'SUCCESS',
          description: 'Your order has been placed successfully!',
        );
        clearOrder();
      }
    } catch (e) {
      print('error: $e');
      await dialog.showDialog(
        title: 'ERROR',
        description: 'Failed to place order.',
      );
      goBack();
      ();
    }
  }

  void removeItemFromOrder(Item item) {
    _orderedItems.remove(item);
    _totalPrice = _totalPrice - item.price!;
    _totalItems--;
    notifyListeners();
    if (_orderedItems.isEmpty) {
      goBack();
      ();
    }
  }

  void clearOrder() {
    _orderedItems = [];
    _totalItems = 0;
    _totalPrice = 0.0;
    notifyListeners();
  }
}
