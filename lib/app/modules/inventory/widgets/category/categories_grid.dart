import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/widgets/category/category_card.dart';
import 'package:stacked/stacked.dart';

class CategoriesGrid extends ViewModelWidget<InventoryViewModel> {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context, InventoryViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 840),
          child: GridView.builder(
            itemCount: viewModel.categories?.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: 8,
              maxCrossAxisExtent: 340,
            ),
            itemBuilder: (context, index) => viewModel.isBusy
                ? const Center(child: CircularProgressIndicator())
                : CategoryCard(index),
          ),
        ),
      ),
    );
  }
}
