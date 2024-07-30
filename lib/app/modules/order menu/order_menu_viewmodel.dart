import 'dart:async';

import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/models/customer.dart';
import 'package:hook_diner/core/models/item.dart';
import 'package:hook_diner/core/models/order.dart';

class OrderMenuViewModel extends SharedViewModel {
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

  final List<String> _numberCards =
      List<String>.generate(20, (i) => (i + 1).toString());

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
    _categories?.insert(0, Category(id: 'all', title: 'ALL'));

    _categories = _categories
        ?.map(
          (category) => category = Category(
            id: category.id,
            title: category.title?.toTitleCase(),
          ),
        )
        .toList();

    searchBarController.text = '';
    selectedCategoryController.text = _categories?.first.id.toString() ?? '';

    streamMenuItems();
    streamCustomers();

    _isRegularCustomer = false;
    _orderCardNumber = '1';

    notifyListeners();
    setBusy(false);
  }

  void setupCustomerModal(Customer? editingCustomer) {
    customerController.text = editingCustomer?.name ?? '';
    notifyListeners();
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
      if (customers.isEmpty) {
        _isRegularCustomer = false;
        notifyListeners();
      }
      customers.sort((a, b) => a.name!.compareTo(b.name!));
      _customers = customers;
      _customerName = _customers?.first.id ?? '';

      notifyListeners();

      setBusy(false);
    });
  }

  void addCustomer() async {
    setBusy(true);

    final Customer newCustomer = Customer(
      name: customerController.text,
    );
    try {
      final response = await database.addCustomer(newCustomer);

      if (response) {
        await dialog.showDialog(
          title: 'SUCESS',
          description: 'Customer added successfully!',
        );
      }
      goBack();
    } catch (e) {
      await dialog.showDialog(
        title: 'ERROR',
        description: 'Failed to add customer.',
      );
    } finally {
      goBack();
      setBusy(false);
    }

    notifyListeners();
  }

  void updateCustomer(Customer customer) async {
    customer = Customer(
      id: customer.id,
      name: customerController.text,
    );

    setBusy(true);
    try {
      final response = await database.updateCustomer(customer);
      notifyListeners();
      if (response) {
        await dialog.showDialog(
          title: 'SUCCESS',
          description: 'Customer updated successfully!',
        );
      }
      goBack();
    } catch (e) {
      await dialog.showDialog(
        title: 'ERROR',
        description: 'Failed to update customer.',
      );
    }
    goBack();
    setBusy(false);
  }

  Future deleteCustomer(Customer customer) async {
    final dialogResponse = await dialog.showConfirmationDialog(
      description: 'Are you sure you want to delete this customer?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse!.confirmed) {
      setBusy(true);

      try {
        await database.deleteCustomer(customer.id!);
        _customers!.removeWhere((c) => c.id == customer.id);
        notifyListeners();
        await dialog.showDialog(
          title: 'SUCCESS',
          description: 'Customer deleted successfully!',
        );
      } catch (e) {
        await dialog.showDialog(
          title: 'ERROR',
          description: 'Failed to delete customer.',
        );
      } finally {
        goBack();
        setBusy(false);
      }
    }
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
    _filteredMenuItems = value == 'all'
        ? _menuItems
        : _menuItems?.where((item) => item.category?.id == value).toList() ??
            [];

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
