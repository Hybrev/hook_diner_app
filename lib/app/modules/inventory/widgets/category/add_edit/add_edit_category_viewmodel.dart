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

  void updateCategory(Category category) async {
    category = Category(
      id: category.id,
      title: _categoryController.text,
    );

    setBusy(true);
    try {
      final response = await database.updateCategory(category);
      notifyListeners();
      if (response) {
        await dialog.showDialog(
          title: 'Category Updated!',
          description: 'Category updated successfully!',
        );
        goBack();
      }
    } catch (e) {
      await dialog.showDialog(
        title: 'Error',
        description: 'Failed to update category',
      );
    }
    setBusy(false);
  }

  void addCategory() async {
    final Category category = Category(
      title: _categoryController.text,
    );
    notifyListeners();

    try {
      setBusy(true);

      final response = await database.addCategory(category);

      if (response) {
        setBusy(false);
        goBack();

        await dialog.showDialog(
          title: 'Success',
          description: 'Category added successfully!!',
        );
      }
    } catch (e) {
      print('error: $e');
      await dialog.showDialog(
        title: 'Error',
        description: 'Failed to add category',
      );
    } finally {
      goBack();
    }
  }
}
