import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:sahashop_user/model/category.dart';
part 'product.g.dart';

Product productFromJson(String str) => Product.fromJson(jsonDecode(str));

String productToJson(Product data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class Product {
  Product({
    this.id,
    this.name,
    this.storeId,
    this.description,
    this.indexImageAvatar,
    this.price,
    this.barcode,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.details,
    this.images,
    this.categories,
    this.productDiscount,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int storeId;
  @HiveField(3)
  String description;
  @HiveField(4)
  int indexImageAvatar;
  @HiveField(5)
  int price;
  @HiveField(6)
  String barcode;
  @HiveField(7)
  int status;
  @HiveField(8)
  DateTime createdAt;
  @HiveField(9)
  DateTime updatedAt;
  @HiveField(10)
  List<Details> details;
  @HiveField(11)
  List<ImageProduct> images;
  @HiveField(12)
  List<Category> categories;
  @HiveField(13)
  ProductDiscount productDiscount;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        storeId: json["store_id"],
        description: json["description"],
        indexImageAvatar: 0,
        productDiscount: json["product_discount"] == null
            ? null
            : ProductDiscount.fromJson(json["product_discount"]),
        price: json["price"],
        barcode: json["barcode"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        details:
            List<Details>.from(json["details"].map((x) => Details.fromJson(x))),
        images: List<ImageProduct>.from(
            json["images"].map((x) => ImageProduct.fromJson(x))),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "store_id": storeId,
        "description": description,
        "index_image_avatar": 0,
        "price": price,
        "barcode": name,
        "status": status,
        "product_discount":
            productDiscount == null ? null : productDiscount.toJson(),
        "details": details == null
            ? null
            : List<dynamic>.from(details.map((x) => x.toJson())),
        "images":
            images == null ? null : images.map((e) => e.imageUrl).toList(),
        "categories":
            categories == null ? null : categories.map((e) => e.id).toList(),
      };
}

@HiveType(typeId: 2)
class Details {
  Details({
    this.id,
    this.name,
    this.attributes,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<Attributes> attributes;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        name: json["name"],
        attributes: List<Attributes>.from(
            json["attributes"].map((x) => Attributes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 3)
class Attributes {
  Attributes({
    this.id,
    this.name,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

@HiveType(typeId: 4)
class ImageProduct {
  ImageProduct({
    this.id,
    this.imageUrl,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String imageUrl;

  factory ImageProduct.fromJson(Map<String, dynamic> json) => ImageProduct(
        id: json["id"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
      };
}

@HiveType(typeId: 5)
class ProductDiscount {
  ProductDiscount({
    this.value,
    this.discountPrice,
  });

  @HiveField(0)
  int value;

  @HiveField(1)
  int discountPrice;

  factory ProductDiscount.fromJson(Map<String, dynamic> json) =>
      ProductDiscount(
        value: json["value"],
        discountPrice: json["discount_price"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "discount_price": discountPrice,
      };
}
