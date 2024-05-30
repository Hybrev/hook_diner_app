// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/customers/customer_viewmodel.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class CustomerView extends StatelessWidget {
  const CustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<CustomerViewModel>.reactive(
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
      viewModelBuilder: () => locator<CustomerViewModel>(),
    );
  }
}
