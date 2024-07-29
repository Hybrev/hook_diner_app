import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/customers/customer_viewmodel.dart';
import 'package:hook_diner/app/shared/widgets/filter_actions.dart';
import 'package:hook_diner/core/models/order.dart';
import 'package:stacked/stacked.dart';

class OrderGrid extends ViewModelWidget<CustomerViewModel> {
  const OrderGrid({required this.status, super.key});

  final String? status;

  @override
  Widget build(BuildContext context, CustomerViewModel viewModel) {
    final appTheme = Theme.of(context);
    final List<Order>? orders =
        status == 'unpaid' ? viewModel.unpaidOrders : viewModel.paidOrders;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilterActions(
            searchBarController: viewModel.searchBarController,
            onSearchBarChanged: (value) {},
            dropdownItems: [],
            dropdownController: viewModel.dropdownController,
            onDropdownChanged: (value) {},
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 840),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: 160,
                  maxCrossAxisExtent: 500,
                ),
                itemCount: orders?.length ?? 0,
                itemBuilder: (context, index) => InkWell(
                  child: Card(
                    color: appTheme.colorScheme.tertiary,
                    margin: const EdgeInsets.all(8.0),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Icon(
                          //   Icons.receipt_long_rounded,
                          //   color: appTheme.colorScheme.primary,
                          //   size: 80,
                          // ),
                          Text('${index + 1}',
                              textAlign: TextAlign.center,
                              style: appTheme.textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          const VerticalDivider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  orders![index].orderNumber != null
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              orders[index].orderNumber == null
                                  ? FutureBuilder(
                                      future: viewModel
                                          .getCustomerName(orders[index]),
                                      builder: (context, snapshot) => Text(
                                            snapshot.data ?? 'Loading...',
                                            style: appTheme
                                                .textTheme.titleMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ))
                                  : Text(
                                      '#${orders[index].orderNumber?.toString()}',
                                      style: appTheme.textTheme.titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                              Text(
                                '₱${orders[index].totalPrice?.toStringAsFixed(2)}',
                                style: appTheme.textTheme.titleLarge?.copyWith(
                                  color: appTheme.colorScheme.primary,
                                ),
                              ),
                              Text(
                                orders[index].orderDate.toString(),
                                style: appTheme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                orders[index].datePaid.toString(),
                                style: appTheme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
