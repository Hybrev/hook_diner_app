import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
  });

  final Function onPressed;
  final bool loading;
  final String label;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final mediaData = MediaQuery.sizeOf(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: appTheme.colorScheme.primary,
        padding: EdgeInsets.symmetric(
          horizontal: mediaData.width * 0.15,
          vertical: 12,
        ),
        foregroundColor: appTheme.colorScheme.onPrimary,
        shadowColor: appTheme.colorScheme.secondary,
        textStyle: appTheme.textTheme.titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
        elevation: 4,
      ),
      onPressed: () => onPressed,
      child: loading
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(label),
    );
  }
}
