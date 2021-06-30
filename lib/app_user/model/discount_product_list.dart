import 'dart:convert';

import 'package:sahashop_user/app_user/model/product.dart';

DiscountProductsList discountProductsListFromJson(String str) =>
    DiscountProductsList.fromJson(json.decode(str));

String discountProductsListToJson(DiscountProductsList data) =>
    json.encode(data.toJson());

class DiscountProductsList {
  DiscountProductsList({
    this.id,
    this.storeId,
    this.isEnd,
    this.name,
    this.description,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.value,
    this.setLimitAmount,
    this.amount,
    this.used,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  int? id;
  int? storeId;
  bool? isEnd;
  String? name;
  dynamic description;
  dynamic imageUrl;
  DateTime? startTime;
  DateTime? endTime;
  int? value;
  bool? setLimitAmount;
  dynamic amount;
  int? used;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Product>? products;

  factory DiscountProductsList.fromJson(Map<String, dynamic> json) =>
      DiscountProductsList(
        id: json["id"],
        storeId: json["store_id"],
        isEnd: json["is_end"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        value: json["value"],
        setLimitAmount: json["set_limit_amount"],
        amount: json["amount"],
        used: json["used"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "is_end": isEnd,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "start_time": startTime!.toIso8601String(),
        "end_time": endTime!.toIso8601String(),
        "value": value,
        "set_limit_amount": setLimitAmount,
        "amount": amount,
        "used": used,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}
