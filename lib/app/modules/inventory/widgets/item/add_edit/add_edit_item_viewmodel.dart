import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/models/item.dart';

class AddEditItemViewModel extends InventoryViewModel {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  DateTime? _expirationDate;
  DateTime? get expirationDate => _expirationDate;

  List<Category>? _availableCategories;
  List<Category>? get availableCategories => _availableCategories;

  void setUpActionModal(Item? item) async {
    nameController.text = item?.name ?? '';
    priceController.text = item?.price.toString() ?? '1.00';
    quantityController.text = item?.quantity.toString() ?? '1';

    _expirationDate = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    _availableCategories = await fetchCategories();
    categoryController.text = item?.category?.id.toString() ??
        _availableCategories!.first.id.toString();

    notifyListeners();
  }

  Future<List<Category>?> fetchCategories() async {
    setBusy(true);
    try {
      final fetchedData = await database.getCategories();
      notifyListeners();

      if (fetchedData is! List<Category>) {
        await dialog.showDialog(
          title: 'ERROR',
          description: 'Failed to fetch categories',
        );
        setBusy(false);
        return null;
      }
      setBusy(false);
      notifyListeners();
      return fetchedData;
    } catch (e) {
      setBusy(false);
    }
    return null;
  }

  void addItem() async {
    setBusy(true);
    debugPrint('button pressed');

    final Item newItem = Item(
      name: nameController.text,
      quantity: int.parse(quantityController.text),
      price: double.parse(priceController.text),
      expirationDate:
          '${_expirationDate?.month}/${_expirationDate?.day}/${_expirationDate?.year}',
    );
    try {
      final response = await database.addItem(
        newItem,
        categoryId: categoryController.text,
      );
      if (response == true) {
        await dialog.showDialog(
          title: 'SUCCESS',
          description: 'Item added successfully!',
        );
      }
      goBack();
    } catch (e) {
      print('error: $e');
    } finally {
      goBack();
      setBusy(false);
    }
  }

  void updateItem(Item item) async {
    item = Item(
      id: item.id,
      name: nameController.text,
      quantity: int.parse(quantityController.text),
      price: double.parse(priceController.text),
      expirationDate:
          '${_expirationDate?.month}/${_expirationDate?.day}/${_expirationDate?.year}',
    );

    setBusy(true);
    try {
      final response =
          await database.updateItem(item, categoryId: categoryController.text);
      print('response: $response');
      notifyListeners();
      if (response) {
        await dialog.showDialog(
          title: 'SUCCESS',
          description: 'Item updated successfully!',
        );
      }
      goBack();
    } catch (e) {
      print('error: $e');
      await dialog.showDialog(
        title: 'ERROR',
        description: 'Failed to update item',
      );
    } finally {
      goBack();
      setBusy(false);
    }
  }

  void updateCategoryValue(String categoryValue) {
    categoryController.text = categoryValue;
    notifyListeners();
  }

  void presentDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year + 1, DateTime.december, 31);
    _expirationDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: lastDate,
    );

    _expirationDate ??= DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    notifyListeners();
  }
}
