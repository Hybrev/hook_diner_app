import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/core/models/item.dart';

class OrderListModal extends StatelessWidget {
  const OrderListModal({super.key, required this.orderedItems});

  final List<Item>? orderedItems;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'ORDER LIST',
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: orderedItems?.length ?? 0,
          itemBuilder: (context, index) => ListTile(
            title: Text(orderedItems?[index].name ?? 'Item Name'),
            subtitle: Text(orderedItems?[index].price.toString() ?? '0'),
            trailing: Text(orderedItems?[index].quantity.toString() ?? '0'),
          ),
        ),
      ),
    );
  }
}
