import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/customer%20orders/customer_orders_viewmodel.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/app/shared/widgets/base_button.dart';
import 'package:hook_diner/core/models/order.dart';
import 'package:stacked/stacked.dart';

class OrderDetailsModal extends StatelessWidget {
  const OrderDetailsModal({super.key, required this.receivedOrder});

  final Order receivedOrder;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<CustomerOrdersViewModel>.reactive(
      onViewModelReady: (viewModel) =>
          viewModel.setupOrderDetailsModal(order: receivedOrder),
      builder: (context, viewModel, child) => Scaffold(
        appBar: BaseAppBar(
          title: 'ORDER DETAILS',
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_sweep_rounded),
              onPressed: () {},
            ),
          ],
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Center(
            child: viewModel.orderItems == null
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            receivedOrder.orderNumber == null
                                ? 'Customer Name:'
                                : 'Order Number:',
                            style: appTheme.textTheme.titleLarge,
                          ),
                          receivedOrder.orderNumber == null
                              ? FutureBuilder(
                                  future:
                                      viewModel.getCustomerName(receivedOrder),
                                  builder: (context, snapshot) => Text(
                                        snapshot.data ?? '...',
                                        style: appTheme.textTheme.titleLarge
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ))
                              : Text(
                                  '#${receivedOrder.orderNumber?.toString()}',
                                  style: appTheme.textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                      const Divider(height: 24),
                      // ORDER LIST
                      ListTile(
                        title: Text(
                          'ORDER LIST',
                          style: appTheme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          'PRICE',
                          style: appTheme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: viewModel.orderItems?.length ?? 0,
                          separatorBuilder: (context, index) => Divider(
                            color: appTheme.colorScheme.secondary,
                            height: 0,
                          ),
                          itemBuilder: (context, index) => ListTile(
                            leading: Text(
                              "${index + 1}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            title: Text(
                              viewModel.orderItems?[index].name
                                      ?.toTitleCase() ??
                                  'Item Name',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            trailing: Text(
                                viewModel.orderItems?[index].price.toString() ??
                                    '0.00',
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TOTAL',
                              style: appTheme.textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          Text(
                              '₱ ${receivedOrder.totalPrice?.toStringAsFixed(2)}',
                              style: appTheme.textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          const SizedBox(
            height: 16,
          ),
          Text('Powered by Hook Diner', style: appTheme.textTheme.bodySmall),
        ],
        bottomNavigationBar: receivedOrder.orderStatus != 'paid'
            ? Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: BottomAppBar(
                      elevation: 4,
                      child: BaseButton(
                        onPressed: () {},
                        loading: viewModel.isBusy,
                        buttonIcon: Icons.cancel_rounded,
                        backgroundColor: appTheme.colorScheme.error,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BottomAppBar(
                      elevation: 4,
                      child: BaseButton(
                        label: 'MARK AS PAID',
                        onPressed: () =>
                            viewModel.markOrderAsPaid(order: receivedOrder),
                        loading: viewModel.isBusy,
                        buttonIcon: null,
                      ),
                    ),
                  ),
                ],
              )
            : null,
      ),
      viewModelBuilder: () => CustomerOrdersViewModel(),
    );
  }
}
