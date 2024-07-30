import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/order%20menu/order_menu_viewmodel.dart';
import 'package:hook_diner/app/modules/order%20menu/widgets/checkout/checkout_modal.dart';
import 'package:hook_diner/app/modules/order%20menu/widgets/checkout/checkout_tile.dart';

class CheckoutItemList extends CheckOutModal {
  const CheckoutItemList(this.viewModel,
      {super.key, required super.orderedItems});

  final OrderMenuViewModel viewModel;

  @override
  Widget build(
    BuildContext context,
  ) {
    final appTheme = Theme.of(context);
    return Expanded(
      child: ListView.separated(
        itemCount: orderedItems?.length ?? 0,
        separatorBuilder: (context, index) => Divider(
          color: appTheme.colorScheme.secondary,
          height: 4,
        ),
        itemBuilder: (context, index) => CheckOutTile(
          orderedItems: orderedItems,
          index: index,
          onDismissed: () =>
              viewModel.removeItemFromOrder(orderedItems![index]),
        ),
      ),
    );
  }
}
