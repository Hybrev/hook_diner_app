import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/menu/order_menu_viewmodel.dart';
import 'package:hook_diner/app/shared/widgets/base_button.dart';
import 'package:hook_diner/app/shared/widgets/cancel_button.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:hook_diner/core/models/customer.dart';
import 'package:stacked/stacked.dart';

class AddEditCustomerModal extends StatelessWidget {
  const AddEditCustomerModal({super.key, this.editingCustomer});

  final Customer? editingCustomer;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return ViewModelBuilder<OrderMenuViewModel>.nonReactive(
      onViewModelReady: (viewModel) =>
          viewModel.setupCustomerModal(editingCustomer),
      builder: (context, viewModel, child) => SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                editingCustomer == null ? 'ADD CUSTOMER' : 'EDIT CUSTOMER',
                style: appTheme.textTheme.headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Customer Name',
                      style: appTheme.textTheme.labelLarge,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TextField(
                      style: appTheme.textTheme.labelLarge,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Enter name...',
                      ),
                      controller: viewModel.customerController,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CancelButton(),
                  BaseButton(
                    label: 'ADD',
                    loading: viewModel.isBusy,
                    onPressed: editingCustomer == null
                        ? () => viewModel.addCustomer()
                        : () => viewModel.updateCustomer(editingCustomer!),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => locator<OrderMenuViewModel>(),
    );
  }
}
