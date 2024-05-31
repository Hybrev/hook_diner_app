import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/widgets/item_list_modal.dart';
import 'package:hook_diner/core/data/categories.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class InventoryViewModel extends BaseViewModel {
  final String _title = 'Inventory';
  String get title => _title;

  NavigationService _navigator = locator<NavigationService>();

  final List<Category> _categories = categoryList;
  List<Category> get categories => _categories;

  String? data;
  int counter = 0;

  void initialize() async {
    print('viewModel initialized');
  }

  void goBack() {
    _navigator.back();
  }

  void showCategoryItems(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          final dialogContent =
              ItemListModal(viewModel: InventoryViewModel(), '');
          final showFullScreenDialog = MediaQuery.sizeOf(context).width < 600;

          if (showFullScreenDialog) {
            return Dialog.fullscreen(
              child: dialogContent,
            );
          }

          return Dialog(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: dialogContent,
            ),
          );
        });
  }
}
