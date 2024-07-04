import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/widgets/data_tile.dart';

class MoreActionsButton extends DataTile {
  const MoreActionsButton(
    super.index, {
    super.key,
    required super.data,
    super.title = '',
    super.subtitle = '',
    required super.onEditTap,
    required super.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return PopupMenuButton<MenuItemButton>(
      position: PopupMenuPosition.under,
      icon: const Icon(Icons.more_vert),
      iconColor: appTheme.colorScheme.onSurface,
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: onEditTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Edit'),
              Icon(
                Icons.edit_rounded,
                color: appTheme.colorScheme.onBackground,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: onDeleteTap,
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
        ),
      ],
    );
  }
}
