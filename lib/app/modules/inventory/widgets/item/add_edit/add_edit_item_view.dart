import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/widgets/item/add_edit/add_edit_item_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/widgets/item/item_text_field.dart';
import 'package:hook_diner/app/shared/widgets/base_button.dart';
import 'package:hook_diner/app/shared/widgets/cancel_button.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class AddEditItemView extends StatelessWidget {
  const AddEditItemView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return ViewModelBuilder<AddEditItemViewModel>.reactive(
      disposeViewModel: false,
      builder: (context, viewModel, child) => SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('ADD ITEM',
                  style: appTheme.textTheme.headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Divider(color: appTheme.colorScheme.primary),
              ItemTextField(
                fieldLabel: 'Item Name',
                inputType: TextInputType.text,
                controller: viewModel.nameController,
              ),
              ItemTextField(
                fieldLabel: 'Quantity',
                inputType: TextInputType.number,
                controller: viewModel.quantityController,
              ),
              ItemTextField(
                fieldLabel: 'Unit Price',
                inputType: TextInputType.number,
                controller: viewModel.priceController,
              ),
              ItemTextField(
                fieldLabel: 'Expiration Date',
                inputType: TextInputType.datetime,
                selectedDate: viewModel.expirationDate,
                onPressed: () => viewModel.presentDatePicker(context),
                controller: null,
              ),
              Divider(color: appTheme.colorScheme.primary),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CancelButton(),
                  BaseButton(
                    label: 'ADD',
                    onPressed: () => viewModel.addItem(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => locator<AddEditItemViewModel>(),
    );
  }
}
