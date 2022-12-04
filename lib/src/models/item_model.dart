import 'dart:convert';

class ItemModel {
  int id;
  String title;
  String description;
  String price;
  String unit;
  String picture;

  ItemModel({
    this.id = 0,
    required this.title,
    required this.description,
    required this.price,
    required this.unit,
    required this.picture,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'unit': unit,
      'picture': picture,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? '0',
      unit: map['unit'] ?? '',
      picture: map['picture'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemModel(id: $id, title: $title, description: $description, price: $price, unit: $unit, picture: $picture)';
  }
}
