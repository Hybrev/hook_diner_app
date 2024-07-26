import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/models/customer.dart';
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
    '10',
    '11',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
  ];
  List<String> get numberCards => _numberCards;

  List<Customer>? _customers;
  List<Customer>? get customers => _customers;

  int _totalItems = 0;
  int get totalItems => _totalItems;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  final TextEditingController customerController = TextEditingController();
  final TextEditingController searchBarController = TextEditingController();
  final TextEditingController selectedCategoryController =
      TextEditingController();

  bool? _isRegularCustomer;
  bool? get isRegularCustomer => _isRegularCustomer;

  String? _orderCardNumber;
  String? get orderCardNumber => _orderCardNumber;

  String? _customerName;
  String? get customerName => _customerName;

  void initialize() async {
    setBusy(true);

    _categories = await database.getCategories();
    _categories?.insert(0, Category(id: 'all', title: 'All'));

    searchBarController.text = '';
    selectedCategoryController.text = _categories?.first.id.toString() ?? '';

    streamMenuItems();
    streamCustomers();

    _isRegularCustomer = false;
    _orderCardNumber = '1';

    _customerName = _customers?.first.id ?? '';

    notifyListeners();
    setBusy(false);
  }

  void streamMenuItems() {
    database.listenToItems().listen((items) {
      items.sort((a, b) => a.name!.compareTo(b.name!));

      _menuItems = items;
      _filteredMenuItems = items;

      notifyListeners();
      setBusy(false);
    });
  }

  void streamCustomers() {
    database.listenToCustomers().listen((customers) {
      customers.sort((a, b) => a.name!.compareTo(b.name!));

      _customers = customers;
      notifyListeners();
      setBusy(false);
    });
  }

  void updateCustomerStatus(bool value) {
    _isRegularCustomer = value;
    notifyListeners();
  }

  void updateDropdownValue(String value, {bool isRegular = false}) {
    switch (isRegular) {
      case true:
        _customerName = value;
        notifyListeners();
        break;
      default:
        _orderCardNumber = value;
        notifyListeners();
    }
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

  void addCustomer() async {
    setBusy(true);
    final Customer newCustomer = Customer(
      name: customerController.text,
    );

    try {
      final response = await database.addCustomer(newCustomer);

      if (response) {
        setBusy(false);

        await dialog.showDialog(
          title: 'SUCESS',
          description: 'Customer added successfully!',
        );
      }
    } catch (e) {
      await dialog.showDialog(
        title: 'ERROR',
        description: 'Failed to add customer.',
      );
    } finally {
      goBack();
    }

    notifyListeners();
  }

  void placeOrder() async {
    setBusy(true);
    final Order newOrder = Order(
      totalPrice: _totalPrice.toDouble(),
      orderStatus: 'unpaid',
      orderDate:
          '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}',
    );

    if (_isRegularCustomer == false) {
      newOrder.orderNumber = int.tryParse(_orderCardNumber ?? '');
    }
    notifyListeners();

    try {
      setBusy(true);
      final response = await database.addOrder(
        newOrder,
        orderedItems: _orderedItems,
        customerId: _customerName,
      );
      switch (response) {
        case 'Exception: out-of-stock':
          goBack();
          clearOrder();
          await dialog.showDialog(
            title: 'ERROR',
            description: 'Not enough items in stock.',
          );
          break;
        case true:
          goBack();
          clearOrder();
          await dialog.showDialog(
            title: 'SUCCESS',
            description: 'Your order has been placed successfully!',
          );
      }
    } catch (e) {
      print('error: $e');
      await dialog.showDialog(
        title: 'ERROR',
        description: 'Failed to place order.',
      );
    } finally {
      setBusy(false);
    }
  }

  void removeItemFromOrder(Item item) {
    _orderedItems.remove(item);
    _totalPrice = _totalPrice - item.price!;
    _totalItems--;
    notifyListeners();
    if (_orderedItems.isEmpty) {
      goBack();
    }
  }

  void clearOrder() {
    _orderedItems = [];
    _totalItems = 0;
    _totalPrice = 0.0;
    notifyListeners();
  }
}
