import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/widgets/category/add_edit/add_edit_category_view.dart';
import 'package:hook_diner/app/modules/inventory/widgets/item/add_edit/add_edit_item_view.dart';
import 'package:hook_diner/app/modules/inventory/widgets/item/itemlist_modal_view.dart';
import 'package:hook_diner/app/shared/widgets/more_actions.dart';
import 'package:stacked/stacked.dart';

class CategoryCard extends ViewModelWidget<InventoryViewModel> {
  const CategoryCard(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context, InventoryViewModel viewModel) {
    final appTheme = Theme.of(context);

    return GridTile(
      header: Align(
        alignment: Alignment.topRight,
        child: MoreActionsButton(
          index,
          onEditTap: () => viewModel.showActionModal(
            context,
            dialogContent: AddEditCategoryView(
              editingCategory: viewModel.categories?[index],
            ),
          ),
          onDeleteTap: () =>
              viewModel.deleteCategory(viewModel.categories![index]),
          data: viewModel.categories!,
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          viewModel.categories?[index].title?.toUpperCase() ??
              "Category ${index + 1}",
          style: appTheme.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
      child: Card(
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            splashColor: appTheme.colorScheme.secondary,
            // shows list of items
            onTap: () => showDialog(
                  context: context,
                  builder: (context) {
                    final dialogContent = ItemListModalView(
                      category: viewModel.categories![index],
                      items: viewModel.items,
                      // if add item button is pressed
                      onPressAddItem: () => viewModel.showActionModal(
                        context,
                        dialogContent: const AddEditItemView(),
                      ),
                    );
                    final showFullScreenDialog =
                        MediaQuery.sizeOf(context).width < 600;

                    if (showFullScreenDialog) {
                      return Dialog.fullscreen(
                        child: dialogContent,
                      );
                    }

                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: dialogContent,
                        ),
                      ),
                    );
                  },
                ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Icon(
                Icons.category_outlined,
                size: MediaQuery.sizeOf(context).shortestSide * 0.25,
                color: appTheme.colorScheme.primary,
              ),
            )),
      ),
    );
  }
}
