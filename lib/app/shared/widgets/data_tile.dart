import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/widgets/more_actions.dart';

class DataTile extends StatelessWidget {
  const DataTile(
    this.index, {
    super.key,
    required this.data,
    this.leading = "",
    required this.title,
    required this.subtitle,
    this.onEditTap,
    this.onDeleteTap,
  });

  final List<dynamic> data;
  final int index;

  final String leading;
  final String title;
  final String subtitle;

  final Function()? onEditTap;
  final Function()? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        leading != "" ? leading : "${index + 1}",
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: MoreActionsButton(
        index,
        data: data,
        onEditTap: onEditTap,
        onDeleteTap: onDeleteTap,
      ),
    );
  }
}
