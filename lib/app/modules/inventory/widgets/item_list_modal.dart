import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';

class ItemListModal extends StatelessWidget {
  const ItemListModal(this.filterParams, {super.key, required this.viewModel});

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
            onPressed: () => viewModel.goBack(),
            icon: const Icon(Icons.close_rounded),
          ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => InkWell(
              onTap: () {},
              splashColor: appTheme.colorScheme.secondary,
              child: const GridTile(
                child: Text(
                  'item content here',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Item'),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
