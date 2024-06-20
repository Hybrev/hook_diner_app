import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String label;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextField(
        controller: controller,
        keyboardType:
            isPassword ? TextInputType.visiblePassword : TextInputType.text,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }
}
