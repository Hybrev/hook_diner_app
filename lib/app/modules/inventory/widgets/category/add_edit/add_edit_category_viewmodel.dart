import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/core/models/category.dart';

class AddEditCategoryViewModel extends InventoryViewModel {
  final TextEditingController _categoryController = TextEditingController();
  TextEditingController? get categoryController => _categoryController;

  void setUpModal(Category? category) {
    _categoryController.text = category?.title ?? '';
    notifyListeners();
  }

  void addCategory() async {
    final Category category = Category(
      title: _categoryController.text,
    );
    notifyListeners();

    print('received category: ${category.toJson().toString()}');
    try {
      setBusy(true);

      final response = await database.addCategory(category);

      if (response) {
        setBusy(false);
        navigator.back();

        await dialog.showDialog(
          title: 'Success',
          description: 'Category added successfully!',
        );
      }
    } catch (e) {
      print('error: $e');
      await dialog.showDialog(
        title: 'Error',
        description: 'Failed to add category',
      );
      navigator.back();
    }
  }
}
