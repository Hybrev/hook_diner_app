// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/customer%20orders/customer_orders_viewmodel.dart';
import 'package:hook_diner/app/modules/customer%20orders/widgets/customer_appbar.dart';
import 'package:hook_diner/app/modules/customer%20orders/widgets/order_grid.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class CustomerView extends StatelessWidget {
  const CustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerOrdersViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.initialize(),
      disposeViewModel: false,
      builder: (context, model, child) => const DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: CustomerAppBar(),
          body: Center(
            child: SafeArea(
              minimum: EdgeInsets.all(16),
              child: TabBarView(
                children: [
                  OrderGrid(status: 'unpaid'),
                  OrderGrid(status: 'paid'),
                  OrderGrid(status: 'cancelled')
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => locator<CustomerOrdersViewModel>(),
    );
  }
}
