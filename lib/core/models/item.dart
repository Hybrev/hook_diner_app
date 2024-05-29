import 'package:hook_diner/core/models/category.dart';

class Item {
  final int? id;
  final String? name;
  final int? quantity;
  final double? unitPrice;
  final double? costPrice;
  final double? sellingPrice;
  final String? expirationDate;
  final Category? category;

  const Item({
    this.id,
    this.name,
    this.quantity,
    this.unitPrice,
    this.costPrice,
    this.sellingPrice,
    this.expirationDate,
    this.category,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'] as int?,
        name: json['name'] as String?,
        quantity: json['quantity'] as int?,
        unitPrice: json['unit_price'] as double?,
        costPrice: json['cost_price'] as double?,
        sellingPrice: json['selling_price'] as double?,
        expirationDate: json['expiration_date'] as String?,
        category: json['category'] != null
            ? Category.fromJson(json['category'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'unit_price': unitPrice,
        'cost_price': costPrice,
        'selling_price': sellingPrice,
        'expiration_date': expirationDate,
        'category': category?.toJson(),
      };
}
