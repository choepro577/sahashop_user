import 'dart:convert';

import 'package:sahashop_user/model/category.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

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
  });

  int id;
  String name;
  int storeId;
  String description;
  int indexImageAvatar;
  int price;
  String barcode;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  List<Details> details;
  List<ImageProduct> images;
  List<Category> categories;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        storeId: json["store_id"],
        description: json["description"],
        indexImageAvatar: json["index_image_avatar"],
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
        "index_image_avatar": indexImageAvatar,
        "price": price,
        "barcode": barcode,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Details {
  Details({
    this.id,
    this.name,
    this.attributes,
  });

  int id;
  String name;
  List<Attributes> attributes;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        name: json["name"],
        attributes: List<Attributes>.from(
            json["attributes"].map((x) => Attributes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
      };
}

class Attributes {
  Attributes({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ImageProduct {
  ImageProduct({
    this.id,
    this.imageUrl,
  });

  int id;
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
