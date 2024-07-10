import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String? id;
  String? name;
  int? quantity;
  double? price;
  String? expirationDate;
  DocumentReference? category;

  Item({
    this.id,
    this.name,
    this.quantity,
    this.price,
    this.expirationDate,
    this.category,
  });

  factory Item.fromJson(Map<String, dynamic> json, String id) => Item(
        id: json['id'] as String?,
        name: json['name'] as String?,
        quantity: json['quantity'] as int?,
        price: json['price'] as double?,
        expirationDate: json['expiration_date'] as String?,
        category: json['category'] as DocumentReference?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'price': price,
        'expiration_date': expirationDate,
        'category': category,
      };
}
