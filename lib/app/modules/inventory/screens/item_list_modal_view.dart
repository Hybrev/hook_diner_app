import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/screens/add_item_modal.dart';
import 'package:hook_diner/app/modules/inventory/widgets/item_card.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';

class ItemListModalView extends StatelessWidget {
  const ItemListModalView(this.filterParams,
      {super.key, required this.viewModel});

  final String filterParams;
  final InventoryViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Scaffold(
      appBar: BaseAppBar(
        title: 'ITEMS',
        actions: [
          IconButton(
            onPressed: () => viewModel.showActionModal(
              context,
              dialogContent: AddItemModal(
                viewModel: viewModel,
              ),
            ),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Center(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => ItemCard(index),
          ),
        ),
      ),
    );
  }
}
