import 'package:flutter/material.dart';
import 'package:hook_diner/core/data/categories.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/services/date_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class InventoryViewModel extends BaseViewModel {
  final String _title = 'Inventory';
  String get title => _title;

  final NavigationService _navigator = locator<NavigationService>();
  final DateService dateService = locator<DateService>();

  final List<Category> _categories = categoryList;
  List<Category> get categories => _categories;

  String? data;

  DateTime? _expirationDate;
  DateTime? get expirationDate => _expirationDate;

  void initialize() async {
    print('viewModel initialized');
  }

  void goBack() {
    _navigator.back();
  }

  void presentDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year + 1, DateTime.december, 31);
    _expirationDate = await showDatePicker(
        context: context, initialDate: now, firstDate: now, lastDate: lastDate);
    notifyListeners();
  }

  void showActionModal(BuildContext ctx, {required Widget dialogContent}) {
    showDialog(
        context: ctx,
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: dialogContent,
              ),
            ),
          );
        });
  }
}
