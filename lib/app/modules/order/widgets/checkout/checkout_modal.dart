import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/order/order_viewmodel.dart';
import 'package:hook_diner/app/modules/order/widgets/checkout/checkout_tile.dart';
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
        body: Center(
          child: ListView.separated(
            itemCount: orderedItems?.length ?? 0,
            separatorBuilder: (context, index) => Divider(
              color: appTheme.colorScheme.primary,
            ),
            itemBuilder: (context, index) => CheckOutTile(
              orderedItems: orderedItems,
              index: index,
              onDismissed: () =>
                  viewModel.removeItemFromOrder(orderedItems![index]),
            ),
          ),
        ),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          ElevatedButton(
            onPressed: () => viewModel.clearOrder(),
            style: ElevatedButton.styleFrom(
              backgroundColor: appTheme.colorScheme.error,
              foregroundColor: appTheme.colorScheme.onError,
            ),
            child: const Text('CLEAR ORDER'),
          ),
          ElevatedButton(
            onPressed: () => viewModel.clearOrder(),
            style: ElevatedButton.styleFrom(
              backgroundColor: appTheme.colorScheme.primary,
              foregroundColor: appTheme.colorScheme.onPrimary,
            ),
            child: const Text('PLACE ORDER'),
          ),
        ],
      ),
      viewModelBuilder: () => locator<OrderViewModel>(),
    );
  }
}
