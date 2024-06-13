import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/screens/item_list_modal_view.dart';
import 'package:hook_diner/core/data/categories.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class InventoryViewModel extends BaseViewModel {
  final String _title = 'Inventory';
  String get title => _title;

  final NavigationService _navigator = locator<NavigationService>();

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

  void showActionModal(BuildContext ctx, {required Widget dialogContent}) {
    showDialog(
        context: ctx,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(16.0), // Match shape's borderRadius
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: dialogContent,
              ),
            ),
          );
        });
  }

  void showCategoryItems(
    BuildContext ctx,
  ) {
    showDialog(
        context: ctx,
        builder: (context) {
          final dialogContent =
              ItemListModalView(viewModel: InventoryViewModel(), '');
          final showFullScreenDialog = MediaQuery.sizeOf(context).width < 600;

          if (showFullScreenDialog) {
            return Dialog.fullscreen(
              child: dialogContent,
            );
          }

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0), // Adjust as desired
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(16.0), // Match shape's borderRadius
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: dialogContent,
              ),
            ),
          );
        });
  }
}
