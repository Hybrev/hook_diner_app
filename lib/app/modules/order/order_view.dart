// views/home_view.dart
import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/order/order_viewmodel.dart';
import 'package:hook_diner/app/modules/order/widgets/filter_actions.dart';
import 'package:hook_diner/app/modules/order/widgets/menu_grid.dart';
import 'package:hook_diner/app/modules/order/widgets/checkout/checkout_modal.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
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
        appBar: const BaseAppBar(title: 'MENU'),
        body: Center(
          child: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ACTIONS ROW FOR FILTERING ITEMS
                const FilterActions(),
                const SizedBox(height: 8),
                // GRID OF AVAILABLE ITEMS
                const Expanded(child: MenuGrid()),
                const SizedBox(height: 8),

                // TOTAL PRICE COST OF ORDER
                Visibility(
                  visible: model.orderedItems.isNotEmpty,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 840,
                    ),
                    child: Card(
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
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => locator<OrderViewModel>(),
    );
  }
}
