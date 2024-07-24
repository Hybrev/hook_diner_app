import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/customers/customer_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PaidOrders extends ViewModelWidget<CustomerViewModel> {
  const PaidOrders({super.key});

  @override
  Widget build(BuildContext context, CustomerViewModel viewModel) {
    return Center(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 600, childAspectRatio: 12),
        itemBuilder: (context, index) => GridTile(
          child: Text('test $index'),
        ),
      ),
    );
  }
}
