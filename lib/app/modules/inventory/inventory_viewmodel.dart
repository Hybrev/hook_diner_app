import 'package:hook_diner/app/shared/viewmodel.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/models/item.dart';

class InventoryViewModel extends SharedViewModel {
  final String _title = 'Inventory';
  String get title => _title;

  List<Category>? _categories = [];
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
        _categories!.sort((a, b) => a.title!.compareTo(b.title!));
        notifyListeners();
      } else {
        _categories = [];
        notifyListeners();
        setBusy(false);
      }
      setBusy(false);
    });
  }

  Future<List<Item>?> getItems(String? id) async {
    setBusy(true);
    try {
      _items = await database.getItemsInCategory(id);

      if (_items is! List<Item>) {
        _items = [];
      }
      notifyListeners();
    } on Exception catch (_) {
      await dialog.showDialog(
          title: 'ERROR', description: 'Failed to fetch items');
      setBusy(false);
      goBack();
    }
    setBusy(false);
    return _items;
  }

  Future deleteCategory(Category category) async {
    final dialogResponse = await dialog.showConfirmationDialog(
      description: 'Are you sure you want to delete this category?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse!.confirmed) {
      setBusy(true);

      final categoryItems = await getItems(category.id);

      if (categoryItems!.isNotEmpty) {
        await dialog.showDialog(
          title: 'ERROR - Cannot Delete',
          description: 'Category contains items.',
        );
        setBusy(false);
        return;
      }

      try {
        await database.deleteCategory(category.id!);
        _categories!.removeWhere((c) => c.id == category.id);
        notifyListeners();
        await dialog.showDialog(
          title: 'SUCCESS',
          description: 'Category deleted successfully!',
        );
      } catch (e) {
        await dialog.showDialog(
          title: 'ERROR',
          description: 'Failed to delete category.',
        );
      } finally {
        setBusy(false);
      }
    }
  }

  void deleteItem(Item item) async {
    final dialogResponse = await dialog.showConfirmationDialog(
      description: 'Are you sure you want to delete this item?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse!.confirmed) {
      setBusy(true);

      try {
        await database.deleteItem(item.id!);
        setBusy(false);
        getItems(item.category!.id);

        await dialog.showDialog(
          title: 'SUCCESS',
          description: 'Item deleted successfully!',
        );
      } catch (e) {
        setBusy(false);

        await dialog.showDialog(
          title: 'Error',
          description: 'Failed to delete item',
        );
      }
    }
    setBusy(false);
  }
}
