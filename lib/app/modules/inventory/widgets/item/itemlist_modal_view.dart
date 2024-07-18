import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/widgets/item/add_edit/add_edit_item_view.dart';
import 'package:hook_diner/app/modules/inventory/widgets/item/add_edit/add_edit_item_viewmodel.dart';
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

    return ViewModelBuilder<AddEditItemViewModel>.reactive(
      disposeViewModel: false,
      onViewModelReady: (viewModel) => viewModel.getItems(category.id),
      viewModelBuilder: () => locator<AddEditItemViewModel>(),
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
        body: Center(
          child: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: !viewModel.isBusy && viewModel.items != null
                ? viewModel.items!.isNotEmpty
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Item Info',
                                style: appTheme.textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Expiration Date',
                                style: appTheme.textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Divider(
                              height: 8, color: appTheme.colorScheme.secondary),
                          ListView.separated(
                            itemCount: viewModel.items?.length ?? 10,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => Divider(
                                height: 8,
                                color: appTheme.colorScheme.secondary),
                            itemBuilder: (context, index) => DataTile(
                              index,
                              data: viewModel.items ?? [],
                              title: viewModel.items![index].name!,
                              subtitle:
                                  '₱ ${viewModel.items![index].price?.toStringAsFixed(2)}'
                                  '\n${viewModel.items![index].quantity.toString()} pcs',
                              trailingText: viewModel
                                      .items![index].expirationDate
                                      ?.toString() ??
                                  '',
                              onEditTap: () => viewModel.showCustomModal(
                                context,
                                dialogContent: AddEditItemView(
                                  editingItem: viewModel.items![index],
                                ),
                              ),
                              onDeleteTap: () =>
                                  viewModel.deleteItem(viewModel.items![index]),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.remove_shopping_cart_outlined,
                            size: 120,
                            color: appTheme.colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No items found!',
                            style: appTheme.textTheme.titleLarge,
                          ),
                        ],
                      )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
