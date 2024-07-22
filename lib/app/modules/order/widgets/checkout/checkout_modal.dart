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
                if (MediaQuery.sizeOf(context).width > 600)
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
                      // const DropdownMenu(dropdownMenuEntries: []),
                      DropdownButton<String>(
                        onChanged: (value) {},
                        items: const [],
                      ),
                      Switch(
                        value: viewModel.isRegularCustomer!,
                        activeColor: appTheme.colorScheme.primary,
                        onChanged: (value) =>
                            viewModel.updateCustomerStatus(value),
                      ),
                    ],
                  )
                else
                  Column(
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
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // const DropdownMenu(dropdownMenuEntries: []),
                          DropdownButton<String>(
                            onChanged: (value) =>
                                viewModel.updateCustomerNumber(value!),
                            value: viewModel.customerNumber,
                            items: const [
                              DropdownMenuItem<String>(
                                value: '1',
                                child: Text('1'),
                              ),
                              DropdownMenuItem<String>(
                                value: '2',
                                child: Text('2'),
                              ),
                              DropdownMenuItem<String>(
                                value: '3',
                                child: Text('3'),
                              ),
                              DropdownMenuItem<String>(
                                value: '4',
                                child: Text('4'),
                              ),
                              DropdownMenuItem<String>(
                                value: '5',
                                child: Text('5'),
                              ),
                            ],
                          ),
                          Switch(
                            value: viewModel.isRegularCustomer!,
                            activeColor: appTheme.colorScheme.primary,
                            onChanged: (value) =>
                                viewModel.updateCustomerStatus(value),
                          ),
                        ],
                      ),
                    ],
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
