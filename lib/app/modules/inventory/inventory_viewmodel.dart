import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/models/item.dart';

class InventoryViewModel extends SharedViewModel {
  final String _title = 'Inventory';
  String get title => _title;

  List<Category>? _categories;
  List<Category>? get categories => _categories;

  List<Item>? _items;
  List<Item>? get items => _items;

  void initialize() {
    streamCategories();
  }

  void streamCategories() {
    setBusy(true);
    database.listenToCategories().listen((categories) {
      List<Category> updatedCategories = categories;
      if (updatedCategories.isNotEmpty) {
        _categories = updatedCategories;
        _categories?.sort((a, b) => a.title!.compareTo(b.title!));
        notifyListeners();
      }
      setBusy(false);
    });
  }

  void getItems(String? id) async {
    setBusy(true);

    _items = await database.getItemsInCategory(id);

    if (_items is! List<Item>) {
      await dialog.showDialog(
          title: 'Error', description: 'Failed to fetch items');
      setBusy(false);
      navigator.back();
      return;
    }
    notifyListeners();
    setBusy(false);
  }

  Future deleteCategory(Category category) async {
    final dialogResponse = await dialog.showConfirmationDialog(
      description: 'Are you sure you want to delete this user?',
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
          description: 'Failed to delete category',
        );
      }
    }
  }

  void goBack() {
    navigator.back();
  }
}
