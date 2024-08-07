import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:hook_diner/core/models/customer.dart';
import 'package:hook_diner/core/models/item.dart';
import 'package:hook_diner/core/models/order.dart' as order_model;
import 'package:hook_diner/core/models/user.dart';

class DatabaseService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  final CollectionReference _itemsCollection =
      FirebaseFirestore.instance.collection('items');

  final CollectionReference _ordersCollection =
      FirebaseFirestore.instance.collection('orders');

  final CollectionReference _customersCollection =
      FirebaseFirestore.instance.collection('customers');

  final StreamController<List<User>> _usersController =
      StreamController<List<User>>.broadcast();

  final StreamController<List<Category>> _categoriesController =
      StreamController<List<Category>>.broadcast();

  final StreamController<List<Item>> _itemsController =
      StreamController<List<Item>>.broadcast();

  final StreamController<List<order_model.Order>> _ordersController =
      StreamController<List<order_model.Order>>.broadcast();

  final StreamController<List<Customer>> _customersController =
      StreamController<List<Customer>>.broadcast();

/* STREAM FUNCTIONS */
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

  // CATEGORY
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

  // ITEM
  Stream<List<Item>> listenToItems() {
    _itemsCollection.snapshots().listen((response) {
      if (response.docs.isNotEmpty) {
        final items = response.docs
            .map((snapshot) {
              return Item.fromJson(
                  snapshot.data() as Map<String, dynamic>, snapshot.id);
            })
            .where((element) => element.name != null)
            .toList();

        _itemsController.add(items);
      }
    });
    return _itemsController.stream;
  }

  // ORDER
  Stream<List<order_model.Order>> listenToOrders() {
    _ordersCollection.snapshots().listen((response) {
      if (response.docs.isNotEmpty) {
        final orders = response.docs.map((snapshot) {
          return order_model.Order.fromJson(
              snapshot.data() as Map<String, dynamic>, snapshot.id);
        }).toList();

        _ordersController.add(orders);
      }
    });
    return _ordersController.stream;
  }

  // CUSTOMER
  Stream<List<Customer>> listenToCustomers() {
    _customersCollection.snapshots().listen((response) {
      if (response.docs.isNotEmpty) {
        final customers = response.docs
            .map((snapshot) => Customer.fromJson(
                snapshot.data() as Map<String, dynamic>, snapshot.id))
            .toList();
        _customersController.add(customers);
      }
    });
    return _customersController.stream;
  }

/* ITEM */

  Future getItems() async {
    try {
      final response = await _itemsCollection.get();

      if (response.docs.isNotEmpty) {
        final items = response.docs
            .map((snapshot) => Item.fromJson(
                snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((element) => element.name != null)
            .toList();
        items.sort((a, b) => a.name!.compareTo(b.name!));
        return items;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Item>?> getItemsInOrder(String? id) async {
    try {
      final orderItems = <Item>[];
      final response =
          await _ordersCollection.doc(id).collection('items').get();
      for (var items in response.docs) {
        final DocumentReference itemRef = items.data()['item_id'];
        orderItems.add(await getItemFromReference(itemRef, orderItems));
      }
      return orderItems;
    } catch (e) {
      return [];
    }
  }

  Future getItemFromReference(
      DocumentReference itemRef, List<Item> items) async {
    try {
      final response = await _itemsCollection.doc(itemRef.id).get();
      return Item.fromJson(response.data() as Map<String, dynamic>, itemRef.id);
    } catch (e) {
      return e.toString();
    }
  }

  // GET in CATEGORY
  Future getItemsInCategory(String? id) async {
    try {
      // Category document reference for given id
      final categoryDoc = await _categoriesCollection.doc(id).get();

      // uses document above in filtering items found in category
      final response = await _itemsCollection
          .where('category', isEqualTo: categoryDoc.reference)
          .get();

      // filter out items without name
      if (response.docs.isNotEmpty) {
        final items = response.docs
            .map((snapshot) => Item.fromJson(
                snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((element) => element.name != null)
            .toList();
        items.sort((a, b) => a.name!.compareTo(b.name!));

        return items;
      }
    } catch (e) {
      return e.toString();
    }
  }

  // ADD
  Future addItem(Item item, {required String categoryId}) async {
    try {
      // finds reference based on categoryId
      DocumentReference categoryRef = _categoriesCollection.doc(categoryId);
      item.category = categoryRef;

      // write the item data and get its reference & id
      final itemRef = _itemsCollection.doc();
      await itemRef.set(item.toJson());

      final docId = itemRef.id;
      item.id = docId;

      itemRef.update(item.toJson());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  // UPDATE
  Future updateItem(Item item, {required String categoryId}) async {
    DocumentReference categoryRef = _categoriesCollection.doc(categoryId);
    item.category = categoryRef;
    try {
      await _itemsCollection.doc(item.id).update(item.toJson());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  // DELETE
  Future deleteItem(String id) async {
    try {
      await _itemsCollection.doc(id).delete();
    } catch (e) {
      return e.toString();
    }
  }

/*  USER */
  // GET ALL
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

  // GET ONE
  Future getUser(String uid) async {
    try {
      final user = await _usersCollection.doc(uid).get();
      return User.fromJson(user.data() as Map<String, dynamic>, uid);
    } catch (e) {
      return e.toString();
    }
  }

  // ADD
  Future addUser(User user) async {
    try {
      await _usersCollection.doc(user.id).set(user.toJson());

      return true;
    } catch (e) {
      return e.toString();
    }
  }

  // UPDATE
  Future updateUser(User user) async {
    try {
      await _usersCollection.doc(user.id).update(user.toJson());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  // DELETE
  Future deleteUser(String id) async {
    try {
      await _usersCollection.doc(id).delete();
    } catch (e) {
      return e.toString();
    }
  }

/* CATEGORY */
  // GET ALL
  Future getCategories() async {
    try {
      final response = await _categoriesCollection.get();

      // filter out categories without title
      if (response.docs.isNotEmpty) {
        return response.docs
            .map((snapshot) => Category.fromJson(
                snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((element) => element.title != null)
            .toList();
      }
    } catch (e) {
      return e.toString();
    }
  }

  // ADD
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

  // UPDATE
  Future updateCategory(Category category) async {
    try {
      await _categoriesCollection.doc(category.id).update(category.toJson());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

// DELETE
  Future deleteCategory(String id) async {
    try {
      await _categoriesCollection.doc(id).delete();
    } catch (e) {
      return e.toString();
    }
  }

/* ORDER */
  Future addOrder(order_model.Order order,
      {required List<Item> orderedItems, String? customerId}) async {
    try {
      // adds order info w/ auto-gen ID
      final docRef = _ordersCollection.doc();
      await docRef.set(order.toJson());

      // get newly created  document id & set to order id
      final orderId = docRef.id;
      order.id = orderId;

      // finds reference based on list of ordered items
      Map<String, dynamic> item = {
        'item_id': '',
      };

      for (var i = 0; i < orderedItems.length; i++) {
        // gets each item id for reference
        DocumentReference itemRef = _itemsCollection.doc(orderedItems[i].id);
        item = {'item_id': itemRef};

        // deducts quantity from item
        try {
          await updateItemQuantity(orderedItems, i);
        } on Exception catch (e) {
          if (e.toString() == 'Exception: out-of-stock') {
            return e.toString();
          }
        }
        await _ordersCollection.doc(orderId).collection('items').add(item);
      }

      // checks if order is made by a regular customer
      if (customerId != null && customerId.isNotEmpty) {
        order.customerId = _customersCollection.doc(customerId);
      }

      docRef.update(order.toJson());

      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateItemQuantity(List<Item> orderedItems, int i,
      {String? action}) async {
    final docRef = _itemsCollection.doc(orderedItems[i].id);
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      final currentQuantity = snapshot.get('quantity') as int;
      final initialQuantity = orderedItems[i].quantity!;

      switch (action) {
        case 'restock':
          await docRef.update({
            'quantity': currentQuantity + 1,
          });
          break;
        default:
          if (currentQuantity - 1 < 0) {
            // Handle out-of-stock scenario: return 'out-of-stock' code
            await docRef.update({
              'quantity': initialQuantity,
            });
            throw Exception('out-of-stock');
          }
          await docRef.update({
            'quantity': currentQuantity - 1,
          });

          break;
      }
    }
  }

  Future markOrderAsReady(String id) async {
    try {
      await _ordersCollection.doc(id).update({
        'is_ready': true,
      });
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future updateOrderStatus(
      String id, String status, List<Item>? orderedItems) async {
    try {
      if (status != 'paid' && orderedItems != null) {
        await _ordersCollection.doc(id).update({
          'order_status': status,
        });

        for (var i = 0; i < orderedItems.length; i++) {
          // adds quantity back to item stock
          await updateItemQuantity(orderedItems, i, action: 'restock');
        }

        return true;
      }
      await _ordersCollection.doc(id).update({
        'order_status': status,
        'date_paid':
            '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}'
      });
      return true;
    } catch (e) {
      return e.toString();
    }
  }

/* CUSTOMER */
  Future addCustomer(Customer customer) async {
    try {
      // create document for new data
      final docRef = _customersCollection.doc();
      await docRef.set(customer.toJson());

      // get newly created  document id & set to category id
      final docId = docRef.id;
      customer.id = docId;

      docRef.update(customer.toJson());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future getCustomers() async {
    try {
      final response = await _customersCollection.get();

      if (response.docs.isNotEmpty) {
        final customers = response.docs
            .map((snapshot) => Customer.fromJson(
                snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((element) => element.name != null)
            .toList();
        customers.sort((a, b) => a.name!.compareTo(b.name!));
        return customers;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getCustomerByOrder(DocumentReference customer) async {
    final customerSnapshot = await _customersCollection.doc(customer.id).get();

    final String? name = customerSnapshot.get('name');
    return name ?? 'Unknown Customer';
  }

  // UPDATE
  Future updateCustomer(Customer customer) async {
    try {
      await _customersCollection.doc(customer.id).update(customer.toJson());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

// DELETE
  Future deleteCustomer(String id) async {
    try {
      await _customersCollection.doc(id).delete();
    } catch (e) {
      return e.toString();
    }
  }
}
