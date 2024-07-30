import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/customer.dart';
import 'package:hook_diner/core/models/order.dart';

class CustomerOrdersViewModel extends SharedViewModel {
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

  final TextEditingController _unpaidDropdown = TextEditingController();
  TextEditingController get unpaidDropdown => _unpaidDropdown;

  final TextEditingController _paidDropdown = TextEditingController();
  TextEditingController get paidDropdown => _paidDropdown;

  void initialize() async {
    print('viewModel initialized');

    // _regularCustomers = await getCustomers()

    streamOrders();
    streamCustomers();
  }

  void streamOrders() {
    setBusy(true);

    database.listenToOrders().listen((orders) {
      if (orders.isNotEmpty) {
        orders.sort((a, b) => a.orderDate!.compareTo(b.orderDate!));
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

  void streamCustomers() {
    setBusy(true);

    database.listenToCustomers().listen((customers) {
      if (customers.isNotEmpty) {
        customers.sort((a, b) => a.name!.compareTo(b.name!));

        _regularCustomers = [
          Customer(id: 'all', name: 'All'),
          Customer(id: 'numbers', name: 'NUMBERS ONLY')
        ];
        notifyListeners();

        _regularCustomers?.addAll(customers);

        _unpaidDropdown.text = _regularCustomers?.first.id ?? '';
        _paidDropdown.text = _regularCustomers?.first.id ?? '';

        notifyListeners();
      }

      setBusy(false);
    });
  }

  // Future<List<Customer>?> getCustomers() async {
  //   setBusy(true);
  //   try {
  //     _regularCustomers = await database.getCustomers();

  //     if (_regularCustomers is! List<Customer>) {
  //       _regularCustomers = [];
  //     }
  //     _regularCustomers?.sort((a, b) => a.name!.compareTo(b.name!));

  //     notifyListeners();
  //   } on Exception catch (e) {
  //     print('error: $e');
  //     await dialog.showDialog(
  //         title: 'ERROR', description: 'Failed to fetch customers.');
  //     setBusy(false);
  //     goBack();
  //   }
  //   setBusy(false);
  //   return _regularCustomers;
  // }

  Future<String?> getCustomerName(Order order) async {
    final response = await database.getCustomerByOrder(order.customerId!);
    return response;
  }

  void updateCustomerFilter(String value, {required String status}) {
    switch (status) {
      case 'unpaid':
        _unpaidDropdown.text = value;
        switch (value) {
          case 'all':
            _unpaidOrders = _allOrders
                ?.where((order) => order.orderStatus == 'unpaid')
                .toList();
            break;

          case 'numbers':
            _unpaidOrders = _allOrders
                ?.where((order) => order.orderNumber != null)
                .toList();
            break;
          default:
            _unpaidOrders = _allOrders
                ?.where((order) =>
                    order.customerId?.id == value &&
                    order.orderNumber == null &&
                    order.orderStatus == 'unpaid')
                .toList();
            break;
        }
        break;

      case 'paid':
        _paidDropdown.text = value;
        switch (value) {
          case 'all':
            _paidOrders = _allOrders
                ?.where((order) => order.orderStatus == 'paid')
                .toList();
            break;

          case 'numbers':
            _paidOrders =
                _allOrders?.where((order) => order.customerId == null).toList();
            break;
          default:
            _paidOrders = _allOrders
                ?.where((order) =>
                    order.customerId?.id == value &&
                    order.orderNumber == null &&
                    order.orderStatus == 'paid')
                .toList();
            break;
        }
        break;

      default:
    }
    notifyListeners();
  }
}
