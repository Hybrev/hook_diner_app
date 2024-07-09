import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String? name;
  int? quantity;
  double? price;
  String? expirationDate;
  DocumentReference? category;

  Item({
    this.name,
    this.quantity,
    this.price,
    this.expirationDate,
    this.category,
  });

  Item.fromJson(Map<String, dynamic> json, String id) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    expirationDate = json['expiration_date'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    data['expiration_date'] = expirationDate;
    data['category'] = category;
    return data;
  }
}
