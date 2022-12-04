import 'dart:convert';

class CartItemModel {
  int id;
  int quantity;
  int item;
  String title;
  String description;
  String price;
  String unit;
  String picture;

  CartItemModel({
    required this.id,
    required this.quantity,
    required this.item,
    required this.title,
    required this.description,
    required this.price,
    required this.unit,
    required this.picture,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'item': item,
      'title': title,
      'description': description,
      'price': price,
      'unit': unit,
      'picture': picture,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      item: map['item']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? '',
      unit: map['unit'] ?? '',
      picture: map['picture'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartItemModel(id: $id, quantity: $quantity, item: $item, title: $title, description: $description, price: $price, unit: $unit, picture: $picture)';
  }

  totalPrice() => double.parse(price) * quantity;
  
}
