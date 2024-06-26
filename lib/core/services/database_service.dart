import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/models/item.dart';
import 'package:hook_diner/core/models/user.dart';

class DatabaseService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _itemsCollection =
      FirebaseFirestore.instance.collection('items');
  CollectionReference get items => _itemsCollection;

  final CollectionReference _categoriesCollection =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference get categories => _categoriesCollection;

  final StreamController<List<User>> _usersController =
      StreamController<List<User>>.broadcast();

  final StreamController<List<Item>> _itemsController =
      StreamController<List<Item>>.broadcast();

  final StreamController<List<Category>> _categoriesController =
      StreamController<List<Category>>.broadcast();

// STREAMS
  // USER
  Stream listenToUsers() {
    _usersCollection.snapshots().listen((response) {
      if (response.docs.isNotEmpty) {
        final users = response.docs
            .map((snapshot) => User.fromJson(
                snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((element) => element.username != null)
            .toList();

        _usersController.add(users);
      }
    });

    return _usersController.stream;
  }

  // ITEM
  Stream listenToItems() {
    _itemsCollection.snapshots().listen((response) {
      if (response.docs.isNotEmpty) {
        final items = response.docs
            .map((snapshot) => Item.fromJson(
                snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((element) =>
                element.name != null &&
                element.category?.id == _categoriesCollection.id)
            .toList();

        _itemsCollection.add(items);
      }
    });

    return _itemsController.stream;
  }

/* GENERAL CRUD */
  // ADD
  Future addData(Map<String, dynamic> data, String id,
      CollectionReference<Object?> collection) async {
    try {
      await collection.doc(id).set(data);
    } catch (e) {
      return e.toString();
    }
  }

  // UPDATE
  Future updateData(CollectionReference<Object?> collection, String id,
      Map<String, dynamic> data) async {
    try {
      await collection.doc(id).update(data);
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  // DELETE
  Future deleteData(CollectionReference<Object?> collection, String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      return e.toString();
    }
  }

// USER
  Future addUser(User user) async {
    try {
      await _usersCollection.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.toString();
    }
  }

  // GET
  Future getUsers() async {
    try {
      final response = await _usersCollection.get();
      if (response.docs.isNotEmpty) {
        return response.docs
            .map((snapshot) => User.fromJson(
                snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((element) => element.username != null)
            .toList();
      }
      print('response: $response');
    } catch (e) {
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      final user = await _usersCollection.doc(uid).get();
      return User.fromJson(user.data() as Map<String, dynamic>, uid);
    } catch (e) {
      return e.toString();
    }
  }

  Future updateUser(User user) async {
    try {
      await _usersCollection.doc(user.id).update(user.toJson());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future deleteUser(String id) async {
    try {
      await _usersCollection.doc(id).delete();
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
    } catch (e) {
      return e.toString();
    }
  }
}
