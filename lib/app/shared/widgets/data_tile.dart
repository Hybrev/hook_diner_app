import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/widgets/data_list.dart';
import 'package:hook_diner/app/shared/widgets/more_actions.dart';

class DataTile extends DataList {
  const DataTile(
    this.index, {
    super.key,
    required super.title,
    required super.subtitle,
    super.onEditTap,
    super.onDeleteTap,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Text(
          "${index + 1}",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: MoreActionsButton(
          index,
          onEditTap: onEditTap,
          onDeleteTap: onDeleteTap,
        ));
  }
}
