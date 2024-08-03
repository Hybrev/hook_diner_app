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
    final List<Order>? orders;
    switch (status) {
      case 'unpaid':
        orders = viewModel.unpaidOrders;
        break;
      case 'paid':
        orders = viewModel.paidOrders;
        break;
      default:
        orders = viewModel.cancelledOrders;
    }

    final appTheme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // filter to show regular customer orders or all orders
          FilterActions(
            onDateChanged: status == 'paid'
                ? () => viewModel.getOrdersFromDate(context)
                : null,
            selectedDate: viewModel.selectedDate,
            dropdownItems: viewModel.customers ?? [],
            dropdownController: status != 'cancelled'
                ? status == 'unpaid'
                    ? viewModel.unpaidDropdown
                    : viewModel.paidDropdown
                : viewModel.cancelledDropdown,
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
                      itemBuilder: (context, index) => OrderCard(
                        index,
                        order: orders![index],
                      ),
                    ),
                  ),
          ),
          Visibility(
            visible: viewModel.selectedDate != null && status == 'paid',
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 840,
              ),
              child: Card(
                shadowColor: appTheme.colorScheme.primary.withOpacity(0.25),
                elevation: 2,
                color: appTheme.colorScheme.onSurface,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TOTAL INCOME (${viewModel.selectedDate})',
                        style: appTheme.textTheme.labelLarge?.copyWith(
                          color: appTheme.colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        'PHP ${viewModel.totalEarnings.toStringAsFixed(2)}',
                        style: appTheme.textTheme.labelLarge?.copyWith(
                          color: appTheme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
