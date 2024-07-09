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
    priceController.text = item?.price.toString() ?? '';
    quantityController.text = item?.quantity.toString() ?? '';

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
          title: 'Error',
          description: 'Failed to fetch categories',
        );
        setBusy(false);

        return null;
      }
      setBusy(false);
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
      print('response: $response');
      if (response == true) {
        await dialog.showDialog(
          title: 'Success',
          description: 'Item added successfully',
        );
        navigator.back();
      }
    } catch (e) {
      print('error: $e');
    }
    setBusy(false);
  }

  void updateCategory(String categoryValue) {
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
