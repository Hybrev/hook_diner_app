import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/order/order_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MenuCard extends ViewModelWidget<OrderViewModel> {
  const MenuCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, OrderViewModel viewModel) {
    final appTheme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      color: Colors.amber,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            child: Image.network(
              'https://archive.org/download/placeholder-image/placeholder-image.jpg',
              fit: BoxFit.cover,
              width: 120,
              height: double.infinity,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.menuItems[index].name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    viewModel.menuItems[index].price.toString(),
                    style: TextStyle(
                      color: appTheme.colorScheme.onSurface,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
