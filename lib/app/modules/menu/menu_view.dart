// views/home_view.dart
import 'package:flutter/material.dart';

import 'package:hook_diner/app/modules/menu/menu_viewmodel.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<MenuViewModel>.reactive(
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
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            'Create Order',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          splashColor: appTheme.colorScheme.tertiary,
          icon: const Icon(Icons.add),
          onPressed: () => model.incrementCounter(), // Call view model method
        ),
      ),
      viewModelBuilder: () => locator<MenuViewModel>(),
    );
  }
}
