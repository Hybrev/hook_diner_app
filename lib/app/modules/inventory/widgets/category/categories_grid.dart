import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/widgets/category/category_card.dart';
import 'package:stacked/stacked.dart';

class CategoriesGrid extends ViewModelWidget<InventoryViewModel> {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context, InventoryViewModel viewModel) {
    final appTheme = Theme.of(context);

    return Center(
        child: viewModel.categories!.isNotEmpty
            ? !viewModel.isBusy
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 840),
                      child: GridView.builder(
                        itemCount: viewModel.categories!.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          maxCrossAxisExtent: 340,
                        ),
                        itemBuilder: (context, index) => CategoryCard(index),
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator())
            : SafeArea(
                minimum:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_shopping_cart_outlined,
                      size: 120,
                      color: appTheme.colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No categories found!',
                      style: appTheme.textTheme.titleLarge,
                    ),
                  ],
                ),
              ));
  }
}
