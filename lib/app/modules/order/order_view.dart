// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/order/order_viewmodel.dart';
import 'package:hook_diner/app/modules/order/widgets/customer/add_customer_modal.dart';
import 'package:hook_diner/app/modules/order/widgets/menu_grid.dart';
import 'package:hook_diner/app/modules/order/widgets/checkout/checkout_modal.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/app/shared/widgets/filter_actions.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<OrderViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.initialize(),
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
          appBar: const BaseAppBar(
            title: 'ORDER MENU',
            centerTitle: true,
          ),
          body: Center(
            child: model.isBusy
                ? const CircularProgressIndicator()
                : model.menuItems != null &&
                        (model.orderedItems.isNotEmpty ||
                            model.categories != null)
                    ? SafeArea(
                        minimum: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ACTIONS ROW FOR FILTERING ITEMS
                            FilterActions(
                              searchBarController: model.searchBarController,
                              dropdownController:
                                  model.selectedCategoryController,
                              dropdownItems: model.categories ?? [],
                              onDropdownChanged: (value) =>
                                  model.updateCategoryFilter(value),
                              onSearchBarChanged: (value) =>
                                  model.updateSearchText(value),
                            ),
                            const SizedBox(height: 8),
                            // GRID OF AVAILABLE ITEMS
                            const Expanded(child: MenuGrid()),
                            const SizedBox(height: 8),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.remove_shopping_cart_outlined,
                            size: 120,
                            color: appTheme.colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No items found!',
                            style: appTheme.textTheme.titleLarge,
                          ),
                        ],
                      ),
          ),
          // TOTAL PRICE COST OF ORDER
          bottomNavigationBar: Visibility(
            visible: model.orderedItems.isNotEmpty,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 840,
              ),
              child: Card(
                shadowColor: appTheme.colorScheme.onSurface,
                elevation: 2,
                color: appTheme.colorScheme.primary,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => model.showCustomModal(
                    context,
                    dialogContent: CheckOutModal(
                      orderedItems: model.orderedItems,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TOTAL (${model.totalItems} items)',
                          style: appTheme.textTheme.labelLarge?.copyWith(
                            color: appTheme.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          'PHP ${model.totalPrice.toStringAsFixed(2)}',
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
          ),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            elevation: 2,
            child: const Icon(Icons.person_add_alt_1_rounded),
            onPressed: () => model.showCustomModal(context,
                dialogContent: const AddCustomerModal(), isAddEdit: true),
          )),
      viewModelBuilder: () => locator<OrderViewModel>(),
    );
  }
}
