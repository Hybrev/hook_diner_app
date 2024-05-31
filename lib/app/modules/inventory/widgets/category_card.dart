import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:stacked/stacked.dart';

class CategoryCard extends ViewModelWidget<InventoryViewModel> {
  const CategoryCard(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context, InventoryViewModel viewModel) {
    final appTheme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 4,
      child: InkWell(
        splashColor: appTheme.colorScheme.secondary,
        onTap: () => viewModel.showCategoryItems(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    image: AssetImage(
                      'lib/app/assets/img/categories/${viewModel.categories[index].imageUrl}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                viewModel.categories[index].title!.toUpperCase(),
                style: appTheme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
