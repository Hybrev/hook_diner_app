import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: appTheme.colorScheme.error,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      icon: Icon(
        Icons.close_rounded,
        color: appTheme.colorScheme.onError,
      ),
      label: Text(
        'CANCEL',
        style: appTheme.textTheme.labelLarge?.copyWith(
          color: appTheme.colorScheme.onError,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
