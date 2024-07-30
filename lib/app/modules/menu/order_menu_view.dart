// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hook_diner/app/modules/inventory/widgets/category/add_edit/add_edit_category_view.dart';
import 'package:hook_diner/app/modules/menu/order_menu_viewmodel.dart';
import 'package:hook_diner/app/modules/menu/widgets/regular%20customers/add_edit_customer_modal.dart';
import 'package:hook_diner/app/modules/menu/widgets/regular%20customers/customer_list.dart';
import 'package:hook_diner/app/modules/menu/widgets/menu_grid.dart';
import 'package:hook_diner/app/modules/menu/widgets/checkout/checkout_modal.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/app/shared/widgets/filter_actions.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class OrderMenuView extends StatelessWidget {
  const OrderMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<OrderMenuViewModel>.reactive(
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
                          Expanded(
                            child: model.filteredMenuItems?.isEmpty ?? true
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
                                        'No items found!',
                                        style: appTheme.textTheme.titleLarge,
                                      ),
                                    ],
                                  )
                                : const MenuGrid(),
                          ),
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
        floatingActionButton: SpeedDial(
          icon: Icons.person_rounded,
          activeIcon: Icons.close_rounded,
          backgroundColor: appTheme.colorScheme.primary,
          overlayColor: appTheme.colorScheme.secondary,
          elevation: 2,
          spacing: 8,
          spaceBetweenChildren: 8,
          children: [
            SpeedDialChild(
              label: "Customer List",
              backgroundColor: appTheme.colorScheme.tertiary,
              child: Icon(
                Icons.groups_rounded,
                color: appTheme.colorScheme.primary,
              ),
              onTap: () => model.showCustomModal(
                context,
                dialogContent: const CustomerList(),
              ),
            ),
            SpeedDialChild(
              label: "Add Customer",
              backgroundColor: appTheme.colorScheme.tertiary,
              child: Icon(
                Icons.person_add_alt_1_rounded,
                color: appTheme.colorScheme.primary,
              ),
              onTap: () => model.showCustomModal(
                context,
                isAddEdit: true,
                dialogContent: const AddEditCustomerModal(),
              ),
              visible: model.categories?.isNotEmpty ?? false,
            ),
          ],
        ),
      ),
      viewModelBuilder: () => locator<OrderMenuViewModel>(),
    );
  }
}
