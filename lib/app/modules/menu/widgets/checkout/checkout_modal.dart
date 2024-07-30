import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/menu/order_menu_viewmodel.dart';
import 'package:hook_diner/app/modules/menu/widgets/checkout/checkout_item_list.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/app/shared/widgets/base_button.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:hook_diner/core/models/item.dart';
import 'package:stacked/stacked.dart';

class CheckOutModal extends StatelessWidget {
  const CheckOutModal({super.key, required this.orderedItems});

  final List<Item>? orderedItems;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<OrderMenuViewModel>.reactive(
      disposeViewModel: false,
      builder: (context, viewModel, child) => Scaffold(
        appBar: BaseAppBar(
          title: 'CHECKOUT',
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              onPressed: () {
                viewModel.clearOrder();
                viewModel.goBack();
              },
              icon: Icon(
                Icons.delete_rounded,
                color: appTheme.colorScheme.error,
              ),
            ),
          ],
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (MediaQuery.sizeOf(context).width > 320)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        viewModel.isRegularCustomer! &&
                                viewModel.customers!.isNotEmpty
                            ? 'Regular Customer'
                            : 'Customer Number',
                        style: appTheme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      viewModel.isRegularCustomer! &&
                              viewModel.customers!.isNotEmpty
                          ? DropdownButton<String>(
                              onChanged: (value) => viewModel
                                  .updateDropdownValue(value!, isRegular: true),
                              value: viewModel.customerName,
                              hint: const Text('Select...'),
                              items: viewModel.customers
                                  ?.map((e) => DropdownMenuItem<String>(
                                        value: e.id,
                                        child: Text(e.name!),
                                      ))
                                  .toList(),
                            )
                          : DropdownButton<String>(
                              onChanged: (value) => viewModel
                                  .updateDropdownValue(value!.toString()),
                              value: viewModel.orderCardNumber ?? '',
                              hint: const Text('Select...'),
                              items: viewModel.numberCards
                                  .map((e) => DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                            ),
                      Switch(
                        value: viewModel.isRegularCustomer! &&
                            viewModel.customers!.isNotEmpty,
                        activeColor: appTheme.colorScheme.primary,
                        onChanged: viewModel.customers?.isEmpty ?? true
                            ? null
                            : (value) => viewModel.updateCustomerStatus(value),
                      ),
                    ],
                  )
                else
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        viewModel.isRegularCustomer! &&
                                viewModel.customers!.isNotEmpty
                            ? 'Regular Customer'
                            : 'Customer Number',
                        style: appTheme.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      viewModel.isRegularCustomer! &&
                              viewModel.customers!.isNotEmpty
                          ? DropdownButton<String>(
                              onChanged: (value) => viewModel
                                  .updateDropdownValue(value!, isRegular: true),
                              value: viewModel.customerName,
                              hint: const Text('Select...'),
                              items: viewModel.customers
                                  ?.map((e) => DropdownMenuItem<String>(
                                        value: e.id,
                                        child: Text(e.name!),
                                      ))
                                  .toList(),
                            )
                          : DropdownButton<String>(
                              onChanged: (value) => viewModel
                                  .updateDropdownValue(value!.toString()),
                              hint: const Text('Select...'),
                              value: viewModel.orderCardNumber ?? '',
                              items: viewModel.numberCards
                                  .map((e) => DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
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
                const Divider(),
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
          child: BaseButton(
            label: 'PLACE ORDER',
            onPressed: () => viewModel.placeOrder(),
            loading: viewModel.isBusy,
            buttonIcon: null,
          ),
        ),
      ),
      viewModelBuilder: () => locator<OrderMenuViewModel>(),
    );
  }
}
