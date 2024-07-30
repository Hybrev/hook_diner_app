import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/customer%20orders/customer_orders_viewmodel.dart';
import 'package:hook_diner/app/modules/customer%20orders/widgets/order_card.dart';
import 'package:hook_diner/app/shared/widgets/filter_actions.dart';
import 'package:hook_diner/core/models/order.dart';
import 'package:stacked/stacked.dart';

class OrderGrid extends ViewModelWidget<CustomerOrdersViewModel> {
  const OrderGrid({required this.status, super.key});

  final String? status;

  @override
  Widget build(BuildContext context, CustomerOrdersViewModel viewModel) {
    final orders =
        status == 'unpaid' ? viewModel.unpaidOrders : viewModel.paidOrders;

    final appTheme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // filter to show regular customer orders or all orders
          FilterActions(
            onSearchBarChanged: (value) {},
            dropdownItems: viewModel.customers ?? [],
            dropdownController: status == 'unpaid'
                ? viewModel.unpaidDropdown
                : viewModel.paidDropdown,
            onDropdownChanged: (value) =>
                viewModel.updateCustomerFilter(value, status: status!),
          ),

          const SizedBox(height: 16),
          Expanded(
            child: orders?.isEmpty ?? true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_shopping_cart_outlined,
                        size: 120,
                        color: appTheme.colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No orders found!',
                        style: appTheme.textTheme.titleLarge,
                      ),
                    ],
                  )
                : ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 840),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisExtent: 160,
                        maxCrossAxisExtent: 500,
                      ),
                      itemCount: orders?.length,
                      itemBuilder: (context, index) => InkWell(
                        child:
                            OrderCard(index, order: orders?[index] ?? Order()),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
