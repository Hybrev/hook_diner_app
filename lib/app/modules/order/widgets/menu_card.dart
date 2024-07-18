import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/order/order_viewmodel.dart';
import 'package:change_case/change_case.dart';
import 'package:stacked/stacked.dart';

class MenuCard extends ViewModelWidget<OrderViewModel> {
  const MenuCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, OrderViewModel viewModel) {
    final appTheme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        onTap: () =>
            viewModel.addItemToOrder(viewModel.filteredMenuItems[index]),
        child: Row(
          children: [
            // ClipRRect(
            //   borderRadius: const BorderRadius.horizontal(
            //     left: Radius.circular(16),
            //   ),
            //   child: Image.network(
            //     'https://archive.org/download/placeholder-image/placeholder-image.jpg',
            //     fit: BoxFit.cover,
            //     width: 80,
            //     height: double.infinity,
            //   ),
            // ),
            Icon(
              index % 2 == 0
                  ? Icons.fastfood_rounded
                  : Icons.restaurant_rounded,
              size: 80,
              color: appTheme.colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    viewModel.filteredMenuItems[index].name?.toCapitalCase() ??
                        'Item Name',
                    style: appTheme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₱ ${viewModel.filteredMenuItems[index].price?.toStringAsFixed(2)}",
                    style: appTheme.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
