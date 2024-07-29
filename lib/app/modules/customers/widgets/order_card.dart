import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/customers/customer_viewmodel.dart';
import 'package:hook_diner/core/models/order.dart';
import 'package:stacked/stacked.dart';

class OrderCard extends ViewModelWidget<CustomerViewModel> {
  const OrderCard(this.index, {super.key, required this.order});

  final int index;
  final Order order;

  @override
  Widget build(BuildContext context, CustomerViewModel viewModel) {
    final appTheme = Theme.of(context);
    return Card(
      color: appTheme.colorScheme.tertiary,
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                snapshot.data ?? 'Loading...',
                                style: appTheme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
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
    );
  }
}
