import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/core/models/item.dart';

class AddEditItemViewModel extends InventoryViewModel {
  TextEditingController? _nameController;
  TextEditingController? get nameController => _nameController;

  TextEditingController? _priceController;
  TextEditingController? get priceController => _priceController;

  TextEditingController? _expirationDateController;
  TextEditingController? get expirationDateController =>
      _expirationDateController;

  TextEditingController? _quantityController;
  TextEditingController? get quantityController => _quantityController;

  final TextEditingController _categoryController = TextEditingController();
  TextEditingController get categoryController => _categoryController;

  DateTime? _expirationDate;
  DateTime? get expirationDate => _expirationDate;

  void setUpActionModal(Item? item) async {
    fetchCategories();
    _nameController?.text = item?.name ?? '';
    _priceController?.text = item?.price.toString() ?? '9.75';
    _expirationDateController?.text = item?.expirationDate ??
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

    _quantityController?.text = item?.quantity.toString() ?? '0';
    _categoryController.text = availableCategories!.first.id.toString();
  }

  void addItem() {
    setBusy(true);
    debugPrint('button pressed');
    setBusy(false);
  }

  void updateCategory(String categoryValue) {
    _categoryController.text = categoryValue;

    print('category: $categoryValue');
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
    notifyListeners();
  }
}
