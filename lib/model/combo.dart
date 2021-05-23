// To parse this JSON data, do
//
//     final combo = comboFromJson(jsonString);

import 'dart:convert';

import 'package:sahashop_user/model/product.dart';

Combo comboFromJson(String str) => Combo.fromJson(json.decode(str));

String comboToJson(Combo data) => json.encode(data.toJson());

class Combo {
  Combo({
    this.id,
    this.storeId,
    this.isEnd,
    this.name,
    this.description,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.discountType,
    this.valueDiscount,
    this.setLimitAmount,
    this.amount,
    this.used,
    this.createdAt,
    this.updatedAt,
    this.productsCombo,
  });

  int id;
  int storeId;
  bool isEnd;
  String name;
  String description;
  String imageUrl;
  DateTime startTime;
  DateTime endTime;
  int discountType;
  int valueDiscount;
  bool setLimitAmount;
  dynamic amount;
  int used;
  DateTime createdAt;
  DateTime updatedAt;
  List<ProductsCombo> productsCombo;

  factory Combo.fromJson(Map<String, dynamic> json) => Combo(
        id: json["id"],
        storeId: json["store_id"],
        isEnd: json["is_end"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        discountType: json["discount_type"],
        valueDiscount: json["value_discount"],
        setLimitAmount: json["set_limit_amount"],
        amount: json["amount"],
        used: json["used"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        productsCombo: List<ProductsCombo>.from(
            json["products_combo"].map((x) => ProductsCombo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "is_end": isEnd,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "discount_type": discountType,
        "value_discount": valueDiscount,
        "set_limit_amount": setLimitAmount,
        "amount": amount,
        "used": used,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "products_combo":
            List<dynamic>.from(productsCombo.map((x) => x.toJson())),
      };
}

class ProductsCombo {
  ProductsCombo({
    this.id,
    this.quantity,
    this.product,
  });

  int id;
  int quantity;
  Product product;

  factory ProductsCombo.fromJson(Map<String, dynamic> json) => ProductsCombo(
        id: json["id"],
        quantity: json["quantity"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "product": product.toJson(),
      };
}
