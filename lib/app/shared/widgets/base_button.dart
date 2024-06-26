import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
  });

  final Function() onPressed;
  final bool loading;
  final String label;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: appTheme.colorScheme.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
      ),
      icon: loading
          ? CircularProgressIndicator(
              color: appTheme.colorScheme.onPrimary,
            )
          : Icon(
              Icons.add_rounded,
              color: appTheme.colorScheme.onPrimary,
            ),
      label: Text(
        'Save',
        style: appTheme.textTheme.labelLarge?.copyWith(
          color: appTheme.colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
