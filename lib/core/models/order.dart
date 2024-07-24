import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hook_diner/core/models/item.dart';

class Order {
  String? id;
  DocumentReference? customerId;
  int? orderNumber;
  double? totalPrice;
  String? orderStatus;

  Order({
    this.id,
    this.customerId,
    this.orderNumber,
    this.totalPrice,
    this.orderStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json, String id) => Order(
        id: json['id'] as String?,
        customerId: json['customer_id'] as DocumentReference?,
        orderNumber: json['order_number'] as int?,
        totalPrice: json['total_price'] as double?,
        orderStatus: json['order_status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer_id': customerId,
        'order_number': orderNumber,
        'total_price': totalPrice,
        'order_status': orderStatus,
      };
}
