import 'package:hook_diner/core/models/category.dart';

class Item {
  final String? id;
  final String? name;
  final int? quantity;
  final double? price;
  final String? expirationDate;
  final Category? category;

  const Item({
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
        category: Category.fromJson(json['category']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'price': price,
        'expiration_date': expirationDate,
        'category': category?.toJson(),
      };
}
