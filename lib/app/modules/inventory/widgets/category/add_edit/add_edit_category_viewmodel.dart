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
          description: 'Category updated successfully',
        );
        navigator.back();
      }
    } catch (e) {
      await dialog.showDialog(
        title: 'Error',
        description: 'Failed to updated category',
      );
    }
    setBusy(false);
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

  Future deleteUser(Category category) async {
    final dialogResponse = await dialog.showConfirmationDialog(
      description: 'Are you sure you want to delete this category?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse!.confirmed) {
      setBusy(true);

      try {
        await database.deleteCategory(category.id!);
        setBusy(false);

        await dialog.showDialog(
          title: 'Category Deleted',
          description: 'Category deleted successfully',
        );
      } catch (e) {
        setBusy(false);

        await dialog.showDialog(
          title: 'Error',
          description: 'Failed to delete user',
        );
      } finally {
        navigator.back();
      }
    }
  }
}
