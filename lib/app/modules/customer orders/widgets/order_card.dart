import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/customer%20orders/customer_orders_viewmodel.dart';
import 'package:hook_diner/app/modules/customer%20orders/widgets/order_details_modal.dart';
import 'package:hook_diner/core/models/order.dart';
import 'package:stacked/stacked.dart';

class OrderCard extends ViewModelWidget<CustomerOrdersViewModel> {
  const OrderCard(this.index, {super.key, required this.order});

  final int index;
  final Order order;

  @override
  Widget build(BuildContext context, CustomerOrdersViewModel viewModel) {
    final appTheme = Theme.of(context);
    return Card(
      color: appTheme.colorScheme.tertiary,
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        splashColor: appTheme.colorScheme.secondary,
        highlightColor: appTheme.colorScheme.secondary,
        onTap: () => viewModel.showCustomModal(
          context,
          dialogContent: OrderDetailsModal(
            receivedOrder: order,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Text('${index + 1}',
                    textAlign: TextAlign.center,
                    style: appTheme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              const VerticalDivider(),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        order.orderNumber != null
                            ? 'Card Number:'
                            : 'Customer Name:',
                        style: appTheme.textTheme.titleMedium),
                    Text(
                      'Total Price:',
                      style: appTheme.textTheme.titleMedium,
                    ),
                    Text(
                      'Date Ordered:',
                      style: appTheme.textTheme.titleMedium,
                    ),
                    if (order.datePaid != null)
                      Text(
                        'Date Paid:',
                        style: appTheme.textTheme.titleMedium,
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    order.orderNumber == null
                        ? FutureBuilder(
                            future: viewModel.getCustomerName(order),
                            builder: (context, snapshot) => Text(
                                  snapshot.data ?? 'LOADING',
                                  style:
                                      appTheme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: snapshot.data != null
                                        ? appTheme.colorScheme.onSurface
                                        : appTheme.colorScheme.error,
                                  ),
                                ))
                        : Text(
                            '#${order.orderNumber?.toString()}',
                            style: appTheme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                    Text(
                      '₱${order.totalPrice?.toStringAsFixed(2)}',
                      style: appTheme.textTheme.titleLarge?.copyWith(
                        color: appTheme.colorScheme.primary,
                      ),
                    ),
                    Text(
                      order.orderDate.toString(),
                      style: appTheme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    if (order.datePaid != null)
                      Text(
                        order.datePaid.toString(),
                        style: appTheme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
