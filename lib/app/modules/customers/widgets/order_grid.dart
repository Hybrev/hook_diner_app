import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/customers/customer_viewmodel.dart';
import 'package:hook_diner/app/modules/customers/widgets/order_card.dart';
import 'package:hook_diner/app/shared/widgets/filter_actions.dart';
import 'package:hook_diner/core/models/order.dart';
import 'package:stacked/stacked.dart';

class OrderGrid extends ViewModelWidget<CustomerViewModel> {
  const OrderGrid({required this.status, super.key});

  final String? status;

  @override
  Widget build(BuildContext context, CustomerViewModel viewModel) {
    final orders =
        status == 'unpaid' ? viewModel.unpaidOrders : viewModel.paidOrders;

    final appTheme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // filter to show regular customer orders or all orders
          FilterActions(
            searchBarController: viewModel.searchBarController,
            onSearchBarChanged: (value) {},
            dropdownItems: viewModel.customers ?? [],
            dropdownController: viewModel.dropdownController,
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
