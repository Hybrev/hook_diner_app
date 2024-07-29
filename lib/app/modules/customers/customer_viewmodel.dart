import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/customer.dart';
import 'package:hook_diner/core/models/order.dart';

class CustomerViewModel extends SharedViewModel {
  final String _title = 'Customer List';
  String get title => _title;

  String _searchText = '';
  String get searchText => _searchText;

  String _customerName = '';
  String get customerName => _customerName;

  List<Customer>? _customers;
  List<Customer>? get customers => _customers;

  List<Order>? _unpaidOrders;
  List<Order>? get unpaidOrders => _unpaidOrders;

  List<Order>? _paidOrders;
  List<Order>? get paidOrders => _paidOrders;

  TextEditingController searchBarController = TextEditingController();
  TextEditingController dropdownController = TextEditingController();

  void initialize() async {
    print('viewModel initialized');

    streamOrders();
    streamCustomers();
    notifyListeners();
  }

  void streamOrders() {
    setBusy(true);

    database.listenToOrders().listen((orders) {
      if (orders.isNotEmpty) {
        _unpaidOrders =
            orders.where((order) => order.orderStatus == 'unpaid').toList();
        _paidOrders =
            orders.where((order) => order.orderStatus == 'paid').toList();
        notifyListeners();
      }
      setBusy(false);
    });
  }

  void streamCustomers() {
    database.listenToCustomers().listen((customers) {
      customers.sort((a, b) => a.name!.compareTo(b.name!));
      _customers = customers;
      _customerName = _customers?.first.id ?? '';

      notifyListeners();

      setBusy(false);
    });
  }

  Future<String?> getCustomerName(Order order) async {
    final response = await database.getCustomerByOrder(order.customerId!);
    return response;
  }

  void updateCustomerFilter(String value, {required String status}) {
    dropdownController.text = value;

    switch (status) {
      case 'unpaid':
        _unpaidOrders = _unpaidOrders
            ?.where((order) => order.customerId?.id == value)
            .toList();
        break;

      case 'paid':
        _paidOrders = _paidOrders
            ?.where((order) => order.customerId?.id == value)
            .toList();
        break;

      default:
        break;
    }
  }
}
