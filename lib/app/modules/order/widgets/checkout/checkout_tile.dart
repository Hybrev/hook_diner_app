import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/order/widgets/checkout/checkout_modal.dart';
import 'package:change_case/change_case.dart';

class CheckOutTile extends CheckOutModal {
  const CheckOutTile({
    super.key,
    required super.orderedItems,
    required this.index,
    required this.onDismissed,
  });

  final int index;
  final Function onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) => onDismissed(),
      child: ListTile(
        leading: Text(
          "${index + 1}",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        title: Text(
          orderedItems?[index].name?.toCapitalCase() ?? 'Item Name',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        trailing: Text(
          '₱ ${orderedItems?[index].price!.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
