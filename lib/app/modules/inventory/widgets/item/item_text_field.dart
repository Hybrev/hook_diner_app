import 'package:flutter/material.dart';

class ItemTextField extends StatelessWidget {
  const ItemTextField({
    super.key,
    required this.fieldLabel,
    required this.controller,
    this.inputType = TextInputType.text,
    this.selectedDate,
    this.onPressed,
  });

  final TextInputType inputType;
  final String fieldLabel;
  final TextEditingController? controller;
  final DateTime? selectedDate;
  final Function()? onPressed;

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
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: "Enter ${fieldLabel.toLowerCase()}..."),
                  keyboardType: inputType,
                  maxLines: 1,
                  style: appTheme.textTheme.labelMedium,
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
