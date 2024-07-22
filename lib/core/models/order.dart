import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hook_diner/core/models/item.dart';

class Order {
  String? id;
  String? name;
  DocumentReference? customerId;
  List<Item>? items;
  double? totalPrice;
  String? orderStatus;

  Order({
    this.id,
    this.name,
    this.customerId,
    this.items,
    this.totalPrice,
    this.orderStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json, String id) => Order(
        id: json['id'] as String?,
        name: json['name'] as String?,
        customerId: json['customer_id'] as DocumentReference?,
        items: json['items'] as List<Item>?,
        totalPrice: json['total_price'] as double?,
        orderStatus: json['order_status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'customer_id': customerId,
        'items': items,
        'total_price': totalPrice,
        'order_status': orderStatus,
      };
}
