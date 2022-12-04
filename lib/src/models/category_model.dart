import 'dart:convert';

import 'package:cupdelivery/src/models/item_model.dart';

class CategoryModel {
  int id;
  String title;
  List<ItemModel> items;

  CategoryModel({
    required this.id,
    required this.title,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      items:
          List<ItemModel>.from(map['items']?.map((x) => ItemModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() => 'CategoryModel(id: $id, title: $title, items: $items)';
}
