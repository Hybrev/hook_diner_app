import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/customers/customer_view.dart';
import 'package:hook_diner/app/modules/inventory/widgets/item_text_field.dart';

class AddItem extends CustomerView {
  const AddItem({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return SafeArea(
      minimum: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('ADD ITEM',
              style: appTheme.textTheme.headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          Divider(color: appTheme.colorScheme.primary),
          const ItemTextField(
              fieldLabel: 'Item Name', inputType: TextInputType.text),
          const ItemTextField(
              fieldLabel: 'Quantity', inputType: TextInputType.number),
          const ItemTextField(
              fieldLabel: 'Unit Price', inputType: TextInputType.number),
          const ItemTextField(
              fieldLabel: 'Cost Price', inputType: TextInputType.number),
          const ItemTextField(
              fieldLabel: 'Selling Price', inputType: TextInputType.number),
          const ItemTextField(
              fieldLabel: 'Expiration Date', inputType: TextInputType.datetime),
        ],
      ),
    );
  }
}
