import 'package:flutter/material.dart';
import 'package:hook_diner/core/models/category.dart';

class ItemTextField extends StatelessWidget {
  const ItemTextField({
    super.key,
    required this.fieldLabel,
    required this.controller,
    this.inputType = TextInputType.text,
    this.selectedDate,
    this.onPressed,
    this.onDropdownChanged,
    this.items,
  });

  final TextInputType inputType;
  final String fieldLabel;
  final TextEditingController? controller;
  final DateTime? selectedDate;
  final Function()? onPressed;

  final Function(String)? onDropdownChanged;
  final List<Category>? items;
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
              ? !fieldLabel.toLowerCase().contains('category')
                  ? TextField(
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: "Enter ${fieldLabel.toLowerCase()}..."),
                      keyboardType: inputType,
                      maxLines: 1,
                      style: appTheme.textTheme.labelLarge,
                    )
                  : DropdownButton<String>(
                      isExpanded: true,
                      value: controller?.text,
                      style: appTheme.textTheme.labelLarge,
                      focusColor: Theme.of(context).colorScheme.tertiary,
                      underline: const Divider(height: 0),
                      items: items
                          ?.map((e) => DropdownMenuItem<String>(
                                value: e.id,
                                alignment: Alignment.center,
                                child: Text(e.title!),
                              ))
                          .toList(),
                      onChanged: (value) => onDropdownChanged!(value!),
                    )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}',
                    ),
                    IconButton(
                      onPressed: onPressed,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
