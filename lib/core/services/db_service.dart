import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/models/item.dart';
import 'package:hook_diner/core/models/user.dart';

class DatabaseService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _itemsCollection =
      FirebaseFirestore.instance.collection('items');
  final CollectionReference _categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  /* CRUD */
  // User CRUD
  Future createUser(User user) async {
    try {
      await _usersCollection.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      final user = await _usersCollection.doc(uid).get();
      return User.fromJson(user.data() as Map<String, dynamic>);
    } catch (e) {
      return e.toString();
    }
  }

  // Item CRUD
  Future addItem(Item item) async {
    try {
      await _itemsCollection.doc(item.id).set(item.toJson());
    } catch (e) {
      return e.toString();
    }
  }

  // Caategory CRUD
  Future addCategory(Category category) async {
    try {
      await _itemsCollection.doc('${category.id}').set(category.toJson());
      return;
    } catch (e) {
      return e.toString();
    }
  }

  Future getCategories() async {
    try {
      final response = await _categoriesCollection.get();
      print('response: $response');
      return response;
    } catch (e) {}
  }
}
