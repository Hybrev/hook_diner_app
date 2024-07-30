import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/customer%20orders/customer_orders_viewmodel.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/app/shared/widgets/base_button.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:hook_diner/core/models/order.dart';
import 'package:stacked/stacked.dart';

class OrderDetailsModal extends StatelessWidget {
  const OrderDetailsModal({super.key, required this.receivedOrder});

  final Order receivedOrder;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<CustomerOrdersViewModel>.nonReactive(
      disposeViewModel: false,
      onViewModelReady: (viewModel) =>
          viewModel.setupOrderDetailsModal(order: receivedOrder),
      builder: (context, viewModel, child) => Scaffold(
        appBar: const BaseAppBar(
          title: 'ORDER DETAILS',
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (MediaQuery.sizeOf(context).width > 320)
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
                    )
                  else
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [],
                    ),
                  const SizedBox(height: 16),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('TOTAL',
                          style: appTheme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Text('₱ ${receivedOrder.totalPrice?.toStringAsFixed(2)}',
                          style: appTheme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
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
        bottomNavigationBar: BottomAppBar(
          elevation: 4,
          child: BaseButton(
            label: 'MARK AS PAID',
            onPressed: () {},
            loading: viewModel.isBusy,
            buttonIcon: null,
          ),
        ),
      ),
      viewModelBuilder: () => locator<CustomerOrdersViewModel>(),
    );
  }
}
