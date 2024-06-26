import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/widgets/item/itemlist_modal_view.dart';
import 'package:stacked/stacked.dart';

class CategoryCard extends ViewModelWidget<InventoryViewModel> {
  const CategoryCard(this.index, {super.key});

  final int index;
  @override
  Widget build(BuildContext context, InventoryViewModel viewModel) {
    final appTheme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 2,
      child: InkWell(
        splashColor: appTheme.colorScheme.secondary,
        onTap: () => showDialog(
          context: context,
          builder: (context) {
            final dialogContent = ItemListModalView(viewModel: viewModel, '');
            final showFullScreenDialog = MediaQuery.sizeOf(context).width < 600;

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
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                IconData(
                    int.parse(
                        '0x${viewModel.categories?[index].icon ?? 'f0164'}'),
                    fontFamily: 'MaterialIcons'),
                size: MediaQuery.of(context).size.width * 0.25,
                color: appTheme.colorScheme.primary,
              ),
              Text(
                viewModel.categories?[index].title?.toUpperCase() ??
                    "Category ${index + 1}",
                style: appTheme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
