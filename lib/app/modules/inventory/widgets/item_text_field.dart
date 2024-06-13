import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/screens/add_item.dart';

class ItemTextField extends AddItem {
  const ItemTextField(
      {super.key,
      required this.fieldLabel,
      this.inputType = TextInputType.text});

  final TextInputType inputType;
  final String fieldLabel;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Text(
            fieldLabel,
            style: appTheme.textTheme.labelLarge,
          ),
        ),
        Expanded(
          child: !fieldLabel.toLowerCase().contains('date')
              ? TextField(
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Enter ${fieldLabel.toLowerCase()}..."),
                  keyboardType: inputType,
                  maxLines: 1,
                  style: appTheme.textTheme.labelMedium,
                )
              : ElevatedButton(
                  onPressed: () {},
                  child: const Text('Select Date...'),
                ),
        )
      ],
    );
  }
}
