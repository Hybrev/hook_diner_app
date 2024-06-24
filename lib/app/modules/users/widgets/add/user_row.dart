import 'package:flutter/material.dart';

class UserRow extends StatelessWidget {
  const UserRow({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        )),
        Expanded(
            child: label != 'Role'
                ? TextField(controller: controller)
                : DropdownButton(
                    isExpanded: true,
                    value: controller.text,
                    items: const [
                      DropdownMenuItem<String>(
                        value: '',
                        enabled: false,
                        child: Text('Select One'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'cashier',
                        child: Text('Cashier'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'purchaser',
                        child: Text('Purchaser'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'admin',
                        child: Text('Admin'),
                      ),
                    ],
                    onChanged: (String? value) {
                      onChanged!(value!);
                    },
                  )),
      ],
    );
  }
}
