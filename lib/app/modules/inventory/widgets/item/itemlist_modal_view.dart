import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/app/shared/widgets/data_tile.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/models/item.dart';
import 'package:stacked/stacked.dart';

class ItemListModalView extends StatelessWidget {
  const ItemListModalView({
    super.key,
    this.filterParams = '',
    required this.items,
    required this.onPressAddItem,
    required this.category,
  });

  final String filterParams;

  final Category category;
  final List<Item>? items;

  final Function() onPressAddItem;
  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<InventoryViewModel>.reactive(
      disposeViewModel: false,
      onViewModelReady: (viewModel) => viewModel.getItems(category.id),
      viewModelBuilder: () => locator<InventoryViewModel>(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: BaseAppBar(
          title: 'ITEMS',
          actions: [
            IconButton(
                onPressed: onPressAddItem, icon: const Icon(Icons.add_rounded)),
          ],
          automaticallyImplyLeading: true,
          centerTitle: true,
        ),
        body: !viewModel.isBusy && viewModel.items != null
            ? SafeArea(
                minimum:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListView.separated(
                  itemCount: viewModel.items?.length ?? 10,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      Divider(height: 8, color: appTheme.colorScheme.secondary),
                  itemBuilder: (context, index) => DataTile(
                    index,
                    data: viewModel.items ?? [],
                    title: viewModel.items![index].name!,
                    subtitle: '₱ ${viewModel.items![index].price.toString()}'
                        '\n${viewModel.items![index].quantity.toString()} pcs',
                    onEditTap: () {},
                    onDeleteTap: () {},
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
