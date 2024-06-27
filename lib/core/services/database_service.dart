import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/models/item.dart';
import 'package:hook_diner/core/models/user.dart';

class DatabaseService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  final StreamController<List<User>> _usersController =
      StreamController<List<User>>.broadcast();

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

// CATEGORIES
  // STREAM
  Stream listenToCategories() {
    _categoriesCollection.snapshots().listen((response) {
      if (response.docs.isNotEmpty) {
        final categories = response.docs
            .map((snapshot) {
              return Category.fromJson(
                  snapshot.data() as Map<String, dynamic>, snapshot.id);
            })
            .where((element) => element.title != null)
            .toList();

        _categoriesController.add(categories);
      }
    });
    return _categoriesController.stream;
  }

  // GET ALL in CATEGORY
  Future getItemsInCategory(String id) async {
    try {
      final response =
          await _categoriesCollection.doc(id).collection('items').get();
      if (response.docs.isNotEmpty) {
        return response.docs
            .map((snapshot) => Item.fromJson(snapshot.data(), snapshot.id))
            .where((element) => element.name != null)
            .toList();
      }
    } catch (e) {
      return e.toString();
    }
  }

  /* ITEM */
  // Stream listenToItems() {
  //   _itemsCollection.snapshots().listen((response) {
  //     if (response.docs.isNotEmpty) {
  //       final items = response.docs
  //           .map((snapshot) => Item.fromJson(
  //               snapshot.data() as Map<String, dynamic>, snapshot.id))
  //           .where((element) => element.name != null)
  //           .toList();

  //       _itemsCollection.add(items);
  //     }
  //   });

  //   return _itemsController.stream;
  // }

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

      return true;
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

  // Category CRUD
  Future addCategory(Category category) async {
    try {
      // create document for new data
      final docRef = _categoriesCollection.doc();
      await docRef.set(category.toJson());

      // get newly created  document id & set to category id
      final docId = docRef.id;
      category.id = docId;

      docRef.update(category.toJson());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future getCategories() async {
    try {
      final response = await _categoriesCollection.get();
      return response;
    } catch (e) {
      return e.toString();
    }
  }
}
