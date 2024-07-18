import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/order/order_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FilterActions extends ViewModelWidget<OrderViewModel> {
  const FilterActions({super.key});

  @override
  Widget build(BuildContext context, OrderViewModel viewModel) {
    final appTheme = Theme.of(context);
    if (MediaQuery.sizeOf(context).width > 600) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DropdownButton<String>(
            value: viewModel.selectedCategoryController.text,
            style: appTheme.textTheme.labelLarge,
            focusColor: Theme.of(context).colorScheme.tertiary,
            items: viewModel.categories
                .map((e) => DropdownMenuItem<String>(
                      value: e.id,
                      child: Text(e.title!),
                    ))
                .toList(),
            onChanged: (value) => viewModel.updateCategoryFilter(value!),
          ),
          SearchBar(
            onChanged: (value) => viewModel.updateSearchText(value),
            constraints: const BoxConstraints(maxWidth: 400),
            trailing: [
              Tooltip(
                message: 'Search',
                child: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ],
            controller: viewModel.searchBarController,
          ),
        ],
      );
    }
    return Column(
      children: [
        SearchBar(
          constraints: const BoxConstraints(maxWidth: 480),
          trailing: [
            Tooltip(
              message: 'Search',
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ),
          ],
          controller: viewModel.searchBarController,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: DropdownButton<String>(
            value: viewModel.selectedCategoryController.text,
            focusColor: Theme.of(context).colorScheme.tertiary,
            items: viewModel.categories
                .map((e) => DropdownMenuItem<String>(
                      value: e.id,
                      child: Text(e.title ?? ''),
                    ))
                .toList(),
            onChanged: (value) => viewModel.updateCategoryFilter(value!),
          ),
        ),
      ],
    );
  }
}
