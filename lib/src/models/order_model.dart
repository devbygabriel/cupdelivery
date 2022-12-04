import 'dart:convert';

import 'package:cupdelivery/src/models/cart_item_model.dart';

class OrderModel {
  int id;
  String total;
  String qrCodeImage;
  String copyAndPaste;
  String due;
  String status;
  DateTime? createdDatetime;
  List<CartItemModel>? items = [];

  bool get isOverDue => DateTime.parse(due).isBefore(DateTime.now());

  OrderModel({
    required this.id,
    required this.total,
    required this.qrCodeImage,
    required this.copyAndPaste,
    required this.due,
    required this.status,
    this.createdDatetime,
    this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'total': total,
      'qr_code_image': qrCodeImage,
      'copia_e_cola': copyAndPaste,
      'due': due,
      'status': status,
      'createdDatetime': createdDatetime?.millisecondsSinceEpoch,
      'items': items?.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id']?.toInt() ?? 0,
      total: map['total'].toString(),
      qrCodeImage: map['qr_code_image'] ?? '',
      copyAndPaste: map['copia_e_cola'] ?? '',
      due: map['due'] ?? '',
      status: map['status'] ?? '',
      createdDatetime: map['createdDatetime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdDatetime'])
          : null,
      items: map['items'] != null
          ? List<CartItemModel>.from(
              map['items']?.map((x) => CartItemModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, total: $total, qrCodeImage: $qrCodeImage, copyAndPaste: $copyAndPaste, due: $due, status: $status, createdDatetime: $createdDatetime, items: $items)';
  }
}
