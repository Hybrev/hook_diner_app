import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/widgets/item/add/add_item_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/widgets/item/item_text_field.dart';
import 'package:hook_diner/app/shared/widgets/base_button.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class AddItemView extends StatelessWidget {
  const AddItemView({super.key, required this.viewModel});

  final InventoryViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return ViewModelBuilder<AddItemViewModel>.reactive(
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
              BaseButton(
                label: 'ADD',
                onPressed: () => viewModel.addItem(),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => locator<AddItemViewModel>(),
    );
  }
}
