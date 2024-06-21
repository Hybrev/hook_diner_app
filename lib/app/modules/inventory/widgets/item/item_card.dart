import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: Text(
          "$index",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        title: const Text('Two-line ListTile'),
        subtitle: const Text('Here is a second line'),
        trailing: PopupMenuButton<MenuItemButton>(
          position: PopupMenuPosition.under,
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Edit'),
                  Icon(Icons.edit_rounded),
                ],
              ),
              onTap: () {},
            ),
            PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delete',
                    style: TextStyle(color: appTheme.colorScheme.error),
                  ),
                  Icon(Icons.delete_rounded, color: appTheme.colorScheme.error),
                ],
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
