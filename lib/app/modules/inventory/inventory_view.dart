import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/screens/categories_view.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    // final windowSize = MediaQuery.sizeOf(context);

    return ViewModelBuilder<InventoryViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.initialize(),
      fireOnViewModelReadyOnce: true,
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        appBar: const BaseAppBar(
          title: "CATEGORIES",
        ),
        body: const CategoriesView(),
        floatingActionButton: FloatingActionButton(
          splashColor: appTheme.colorScheme.tertiary,
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
      viewModelBuilder: () => locator<InventoryViewModel>(),
    );
  }
}
