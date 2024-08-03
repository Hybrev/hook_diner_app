import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String? id;
  DocumentReference? customerId;
  int? orderNumber;
  double? totalPrice;
  String? orderStatus;
  String? orderDate;
  String? datePaid;
  bool? isReady;

  Order({
    this.id,
    this.customerId,
    this.orderNumber,
    this.totalPrice,
    this.orderStatus,
    this.orderDate,
    this.datePaid,
    this.isReady,
  });

  factory Order.fromJson(Map<String, dynamic> json, String id) => Order(
        id: json['id'] as String?,
        customerId: json['customer_id'] as DocumentReference?,
        orderNumber: json['order_number'] as int?,
        totalPrice: json['total_price'] as double?,
        orderStatus: json['order_status'] as String?,
        orderDate: json['order_date'] as String?,
        datePaid: json['date_paid'] as String?,
        isReady: json['is_ready'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer_id': customerId,
        'order_number': orderNumber,
        'total_price': totalPrice,
        'order_status': orderStatus,
        'order_date': orderDate,
        'date_paid': datePaid,
        'is_ready': isReady,
      };
}
