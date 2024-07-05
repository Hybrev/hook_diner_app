import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';

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

  DateTime? _expirationDate;
  DateTime? get expirationDate => _expirationDate;

  void setUpActionModal() {
    _nameController?.text = '';
    _priceController?.text = '';
    _expirationDateController?.text = '';
    _quantityController?.text = '';
    notifyListeners();

    database.listenToCategories();
  }

  void addItem() {
    setBusy(true);

    debugPrint('button pressed');
    setBusy(false);
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
