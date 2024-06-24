import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/widgets/data_tile.dart';

class DataList extends StatelessWidget {
  const DataList({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onEditTap,
    required this.onDeleteTap,
  });
  final String title;
  final String subtitle;

  final Function()? onEditTap;
  final Function()? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ListView.separated(
      itemCount: 20,
      shrinkWrap: true,
      separatorBuilder: (context, index) => Divider(
        height: 8,
        color: appTheme.colorScheme.secondary,
      ),
      itemBuilder: (context, index) => DataTile(
        index,
        title: title,
        subtitle: subtitle,
        onEditTap: onEditTap,
        onDeleteTap: onDeleteTap,
      ),
    );
  }
}
