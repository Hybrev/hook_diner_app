import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.buttonIcon = Icons.add_rounded,
  });

  final Function() onPressed;
  final bool loading;
  final String label;
  final IconData? buttonIcon;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: appTheme.colorScheme.primary,
        foregroundColor: appTheme.colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
      ),
      onPressed: onPressed,
      child: !loading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (buttonIcon != null)
                  Icon(
                    buttonIcon,
                    color: appTheme.colorScheme.onPrimary,
                  ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: appTheme.textTheme.labelLarge?.copyWith(
                    color: appTheme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )
          : CircularProgressIndicator(
              color: appTheme.colorScheme.onPrimary,
            ),
    );
  }
}
