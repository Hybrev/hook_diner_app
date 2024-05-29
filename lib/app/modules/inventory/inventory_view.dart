// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<InventoryViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.initialize(),
      fireOnViewModelReadyOnce: true,
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(
            model.title,
            style: appTheme.textTheme.displaySmall,
          ),
        ),
      ),
      viewModelBuilder: () => locator<InventoryViewModel>(),
    );
  }
}
