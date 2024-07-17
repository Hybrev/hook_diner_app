import 'package:hook_diner/core/models/item.dart';

class Order {
  final int? id;
  final double totalPrice;
  final int customerId;
  final List<Item>? items;

  const Order({
    this.id,
    required this.totalPrice,
    required this.customerId,
    this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'] as int?,
        totalPrice: json['total_amount'] as double,
        customerId: json['customer_id'] as int,
        items: json['items'] != null
            ? (json['items'] as List)
                .map((item) => Item.fromJson(item, item.id))
                .toList()
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'total_amount': totalPrice, // Use snake_case for consistency
        'customer_id': customerId,
        'items': items?.map((item) => item.toJson()).toList(),
      };
}
