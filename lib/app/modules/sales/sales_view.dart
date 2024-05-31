// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/sales/sales_viewmodel.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class SalesView extends StatelessWidget {
  const SalesView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<SalesViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.initialize(),
      fireOnViewModelReadyOnce: true,
      disposeViewModel: false,
      viewModelBuilder: () => locator<SalesViewModel>(),
      builder: (context, model, child) => Scaffold(
        appBar: const BaseAppBar(title: "SALES"),
        body: Center(
          child: Text(
            model.title,
            style: appTheme.textTheme.displaySmall,
          ),
        ),
      ),
    );
  }
}
