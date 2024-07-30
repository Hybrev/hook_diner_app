import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/customer.dart';
import 'package:hook_diner/core/models/order.dart';

class CustomerViewModel extends SharedViewModel {
  final String _title = 'Customer List';
  String get title => _title;

  String _searchText = '';
  String get searchText => _searchText;

  List<Customer>? _regularCustomers;
  List<Customer>? get customers => _regularCustomers;

  List<Order>? _allOrders;

  List<Order>? _unpaidOrders;
  List<Order>? get unpaidOrders => _unpaidOrders;

  List<Order>? _paidOrders;
  List<Order>? get paidOrders => _paidOrders;

  TextEditingController searchBarController = TextEditingController();
  TextEditingController dropdownController = TextEditingController();

  void initialize() async {
    print('viewModel initialized');

    _regularCustomers = await getCustomers();
    _regularCustomers?.insert(0, Customer(id: 'all', name: 'All'));

    print('regular customers: $_regularCustomers');
    dropdownController.text = _regularCustomers?.first.id ?? '';
    notifyListeners();

    streamOrders();
  }

  void streamOrders() {
    setBusy(true);

    database.listenToOrders().listen((orders) {
      if (orders.isNotEmpty) {
        _allOrders = orders;
        _unpaidOrders = _allOrders
            ?.where((order) => order.orderStatus == 'unpaid')
            .toList();
        _paidOrders =
            _allOrders?.where((order) => order.orderStatus == 'paid').toList();
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Future<List<Customer>?> getCustomers() async {
    setBusy(true);
    try {
      _regularCustomers = await database.getCustomers();

      if (_regularCustomers is! List<Customer>) {
        _regularCustomers = [];
      }
      _regularCustomers?.sort((a, b) => a.name!.compareTo(b.name!));

      notifyListeners();
    } on Exception catch (e) {
      print('error: $e');
      await dialog.showDialog(
          title: 'ERROR', description: 'Failed to fetch customers.');
      setBusy(false);
      goBack();
    }
    setBusy(false);
    return _regularCustomers;
  }

  Future<String?> getCustomerName(Order order) async {
    final response = await database.getCustomerByOrder(order.customerId!);
    return response;
  }

  void updateCustomerFilter(String value, {required String status}) {
    dropdownController.text = value;

    switch (value) {
      case 'all':
        _unpaidOrders = _allOrders
            ?.where((order) => order.orderStatus == 'unpaid')
            .toList();
        _paidOrders =
            _allOrders?.where((order) => order.orderStatus == 'paid').toList();
        break;
      default:
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
    notifyListeners();
  }
}
