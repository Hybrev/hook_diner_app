import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/menu/order_menu_viewmodel.dart';
import 'package:hook_diner/app/modules/menu/widgets/menu_card.dart';
import 'package:stacked/stacked.dart';

class MenuGrid extends ViewModelWidget<OrderMenuViewModel> {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context, OrderMenuViewModel viewModel) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 840),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          mainAxisExtent: 140,
          maxCrossAxisExtent: 500,
        ),
        itemCount: viewModel.filteredMenuItems!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => MenuCard(index: index),
      ),
    );
  }
}
