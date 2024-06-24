import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/widgets/item/add/add_item_view.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/app/shared/widgets/data_tile.dart';

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
              dialogContent: const AddItemView(),
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
          child: ListView.separated(
            itemCount: viewModel.items.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(
              height: 8,
              color: appTheme.colorScheme.secondary,
            ),
            itemBuilder: (context, index) => DataTile(
              index,
              data: viewModel.items,
              title: viewModel.items[index].name!,
              subtitle:
                  '${viewModel.items[index].price!.toString()} - ${viewModel.items[index].quantity!.toString()}',
              onEditTap: () {},
              onDeleteTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
