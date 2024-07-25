import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/order.dart';

class CustomerViewModel extends SharedViewModel {
  final String _title = 'Customer List';
  String get title => _title;

  List<Order>? _unpaidOrders;
  List<Order>? get unpaidOrders => _unpaidOrders;

  List<Order>? _paidOrders;
  List<Order>? get paidOrders => _paidOrders;

  String? data;
  int currentIndex = 0;

  void initialize() async {
    print('viewModel initialized');

    streamOrders();
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
}
