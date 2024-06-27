class Item {
  String? name;
  String? quantity;
  String? price;
  String? expirationDate;

  Item({this.name, this.quantity, this.price, this.expirationDate});

  Item.fromJson(Map<String, dynamic> json, String id) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    expirationDate = json['expiration_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    data['expiration_date'] = expirationDate;
    return data;
  }
}
