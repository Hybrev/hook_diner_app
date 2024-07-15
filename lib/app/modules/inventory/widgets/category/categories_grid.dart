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
      child: viewModel.categories.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 840),
                child: GridView.builder(
                  itemCount: viewModel.categories.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 8,
                    maxCrossAxisExtent: 340,
                  ),
                  itemBuilder: (context, index) => viewModel.isBusy
                      ? const Center(child: CircularProgressIndicator())
                      : CategoryCard(index),
                ),
              ),
            )
          : SafeArea(
              minimum: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_shopping_cart_outlined,
                    size: 120,
                    color: appTheme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'NO CATEGORIES FOUND',
                    style: appTheme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
    );
  }
}
