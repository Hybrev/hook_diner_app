import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/order/order_viewmodel.dart';
import 'package:hook_diner/app/modules/order/widgets/checkout/checkout_item_list.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:hook_diner/core/models/item.dart';
import 'package:stacked/stacked.dart';

class CheckOutModal extends StatelessWidget {
  const CheckOutModal({super.key, required this.orderedItems});

  final List<Item>? orderedItems;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<OrderViewModel>.reactive(
      disposeViewModel: false,
      builder: (context, viewModel, child) => Scaffold(
        appBar: const BaseAppBar(
          title: 'ORDER LIST',
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      viewModel.isRegularCustomer!
                          ? 'Regular Customer'
                          : 'Customer Number',
                      style: appTheme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const DropdownMenu(dropdownMenuEntries: []),
                    // DropdownButton<String>(
                    //   onChanged: (value) {},
                    //   items: const [],
                    // ),
                    Switch(
                      value: viewModel.isRegularCustomer!,
                      activeColor: appTheme.colorScheme.primary,
                      onChanged: (value) =>
                          viewModel.updateCustomerStatus(value),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CheckoutItemList(viewModel, orderedItems: orderedItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TOTAL',
                        style: appTheme.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    Text('₱ ${viewModel.totalPrice.toStringAsFixed(2)}',
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
        bottomNavigationBar: BottomAppBar(
          elevation: 4,
          child: ElevatedButton(
            onPressed: () => viewModel.clearOrder(),
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              backgroundColor: appTheme.colorScheme.primary,
              foregroundColor: appTheme.colorScheme.onPrimary,
              elevation: 2,
            ),
            child: const Text(
              'PLACE ORDER',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      viewModelBuilder: () => locator<OrderViewModel>(),
    );
  }
}
