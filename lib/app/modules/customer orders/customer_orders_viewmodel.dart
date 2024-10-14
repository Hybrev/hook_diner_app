import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/customer.dart';
import 'package:hook_diner/core/models/item.dart';
import 'package:hook_diner/core/models/order.dart';
import 'package:hook_diner/core/models/user.dart';

class CustomerOrdersViewModel extends SharedViewModel {
  final String _title = 'Customer List';
  String get title => _title;

  User? _currentUser;
  User? get currentUser => _currentUser;

  String? _selectedDate;
  String? get selectedDate => _selectedDate;

  double _totalEarnings = 0.0;
  double get totalEarnings => _totalEarnings;

  List<Customer>? _regularCustomers;
  List<Customer>? get customers => _regularCustomers;

  List<Order>? _allOrders;

  List<Order>? _unpaidOrders;
  List<Order>? get unpaidOrders => _unpaidOrders;

  List<Order>? _paidOrders;
  List<Order>? get paidOrders => _paidOrders;

  List<Order>? _cancelledOrders;
  List<Order>? get cancelledOrders => _cancelledOrders;

  List<Item>? _orderItems;
  List<Item>? get orderItems => _orderItems;

  final TextEditingController _unpaidDropdown = TextEditingController();
  TextEditingController get unpaidDropdown => _unpaidDropdown;

  final TextEditingController _paidDropdown = TextEditingController();
  TextEditingController get paidDropdown => _paidDropdown;

  final TextEditingController _cancelledDropdown = TextEditingController();
  TextEditingController get cancelledDropdown => _cancelledDropdown;

  void initialize() async {
    _selectedDate = 'Select Date...';
    _currentUser = await auth.getCurrentUser();
    notifyListeners();

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

        _cancelledOrders = _allOrders
            ?.where((order) => order.orderStatus == 'cancelled')
            .toList();

        _totalEarnings = getPaidOrderEarnings();
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

        // sets intial filters before adding customers
        _regularCustomers = [
          Customer(id: 'all', name: 'ALL'),
          Customer(id: 'numbers', name: '* NUMBERS ONLY'),
        ];
        notifyListeners();

        // adds customer data
        _regularCustomers?.addAll(customers);

        _unpaidDropdown.text = _regularCustomers?.first.id ?? '';
        _paidDropdown.text = _regularCustomers?.first.id ?? '';
        _cancelledDropdown.text = _regularCustomers?.first.id ?? '';

        notifyListeners();
      }

      setBusy(false);
    });
  }

  Future<String?> getCustomerName(Order order) async {
    final response = await database.getCustomerByOrder(order.customerId!);
    return response.toTitleCase();
  }

  double getPaidOrderEarnings() {
    double total = 0.0;
    for (var order in _paidOrders!) {
      total += order.totalPrice!;
    }
    return total;
  }

  void getOrdersFromDate(BuildContext context) async {
    final response = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );

// gets date value & filters paid orders to date
    if (response != null) {
      _selectedDate = '${response.month}/${response.day}/${response.year}';
      _paidOrders = _allOrders
          ?.where((order) => order.datePaid == _selectedDate)
          .toList();
      _totalEarnings = getPaidOrderEarnings();

      notifyListeners();
    }
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
                ?.where((order) =>
                    order.orderNumber != null && order.orderStatus == 'unpaid')
                .toList();
            _unpaidOrders
                ?.sort((a, b) => a.orderNumber!.compareTo(b.orderNumber!));
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
                ?.where((order) =>
                    order.orderStatus == 'paid' &&
                    order.datePaid == _selectedDate)
                .toList();
            break;

          case 'numbers':
            _paidOrders = _allOrders
                ?.where((order) =>
                    order.customerId == null && order.orderStatus == 'paid')
                .toList();
            _paidOrders
                ?.sort((a, b) => a.orderNumber!.compareTo(b.orderNumber!));

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
        _totalEarnings = getPaidOrderEarnings();
        break;

      default:
        _cancelledDropdown.text = value;
        switch (value) {
          case 'all':
            _cancelledOrders = _allOrders
                ?.where((order) => order.orderStatus == 'cancelled')
                .toList();
            break;

          case 'numbers':
            _cancelledOrders = _allOrders
                ?.where((order) =>
                    order.orderNumber != null &&
                    order.orderStatus == 'cancelled')
                .toList();
            _cancelledOrders
                ?.sort((a, b) => a.orderNumber!.compareTo(b.orderNumber!));
            break;
          default:
            _cancelledOrders = _allOrders
                ?.where((order) =>
                    order.customerId?.id == value &&
                    order.orderNumber == null &&
                    order.orderStatus == 'cancelled')
                .toList();
            break;
        }
        break;
    }
    notifyListeners();
  }

  void setupOrderDetailsModal({required Order order}) async {
    _currentUser = await auth.getCurrentUser();
    notifyListeners();
    print('current user: ${_currentUser?.toJson()}');

    getItems(order.id);
  }

  void getItems(String? id) async {
    try {
      setBusy(true);
      _orderItems = await database.getItemsInOrder(id) ?? [];
      notifyListeners();
      setBusy(false);
    } on Exception catch (_) {
      await dialog.showDialog(
          title: 'ERROR', description: 'Failed to fetch items.');
      setBusy(false);
      goBack();
    }
  }

  void markAsDone({required Order order}) async {
    final dialogResponse = await dialog.showConfirmationDialog(
      title: 'CONFIRM - MARK AS DONE',
      description:
          'Are you sure you want to mark order as done? \n\nNOTE: This action cannot be undone.',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse!.confirmed) {
      setBusy(true);

      try {
        final response = await database.markOrderAsReady(order.id!);
        if (response) {
          await dialog.showDialog(
            title: 'SUCCESS',
            description: 'Marked as done successfully!',
          );
        }
      } catch (e) {
        await dialog.showDialog(
          title: 'ERROR',
          description: 'Failed to mark as done.',
        );
      } finally {
        setBusy(false);
        goBack();
      }
    }
  }

  void updateOrder(Order order, {required String status}) async {
    final dialogResponse = await dialog.showConfirmationDialog(
      title: 'CONFIRM - ${status.toUpperCase()}',
      description:
          'Are you sure you want to mark order as "$status"? \n\nNOTE: This action cannot be undone.',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse!.confirmed) {
      setBusy(true);
      String description;
      switch (status) {
        case 'paid':
          description = 'Marked as paid successfully!';
          break;
        default:
          description = 'Successfully cancelled order!';
      }
      notifyListeners();

      try {
        final response =
            await database.updateOrderStatus(order.id!, status, _orderItems);
        if (status != 'paid') {}
        if (response) {
          await dialog.showDialog(
            title: 'SUCCESS',
            description: description,
          );
        }
      } catch (e) {
        await dialog.showDialog(
          title: 'ERROR',
          description: 'Failed to mark as "$status".',
        );
      } finally {
        setBusy(false);
        goBack();
      }
    }
  }
}
