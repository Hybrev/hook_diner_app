import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/order/order_viewmodel.dart';
import 'package:hook_diner/app/modules/order/widgets/menu_card.dart';
import 'package:stacked/stacked.dart';

class MenuGrid extends ViewModelWidget<OrderViewModel> {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context, OrderViewModel viewModel) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 840),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 8,
          mainAxisExtent: 120,
          maxCrossAxisExtent: 500,
        ),
        itemCount: viewModel.menuItems.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => MenuCard(
          index: index,
        ),
      ),
    );
  }
}
