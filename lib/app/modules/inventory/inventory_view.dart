import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/screens/add_item_modal.dart';
import 'package:hook_diner/app/modules/inventory/screens/categories_view.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    // final windowSize = MediaQuery.sizeOf(context);

    return ViewModelBuilder<InventoryViewModel>.nonReactive(
      onViewModelReady: (viewModel) => viewModel.initialize(),
      fireOnViewModelReadyOnce: true,
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        appBar: const BaseAppBar(
          title: "CATEGORIES",
        ),
        body: const CategoriesView(),
        floatingActionButton: SpeedDial(
          icon: Icons.add_rounded,
          activeIcon: Icons.close_rounded,
          backgroundColor: appTheme.colorScheme.onBackground,
          overlayColor: appTheme.colorScheme.secondary,
          spacing: 8,
          spaceBetweenChildren: 8,
          children: [
            SpeedDialChild(
              label: "Item",
              backgroundColor: appTheme.colorScheme.onTertiary,
              child: Icon(
                Icons.note_add_rounded,
                color: appTheme.colorScheme.tertiary,
              ),
              onTap: () => model.showActionModal(
                context,
                dialogContent: AddItemModal(viewModel: model),
              ),
            ),
            SpeedDialChild(
              label: "Category",
              backgroundColor: appTheme.colorScheme.onTertiary,
              child: Icon(
                Icons.category_rounded,
                color: appTheme.colorScheme.tertiary,
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => locator<InventoryViewModel>(),
    );
  }
}
