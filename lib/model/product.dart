import 'dart:convert';
import 'package:sahashop_user/model/category.dart';

Product productFromJson(String str) => Product.fromJson(jsonDecode(str));

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
    this.productDiscount,
    this.hasInDiscount,
    this.hasInCombo,
  });

  int id;
  String name;
  int storeId;
  String description;
  int indexImageAvatar;
  double price;
  String barcode;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  List<Details> details;
  List<ImageProduct> images;
  List<Category> categories;
  ProductDiscount productDiscount;
  bool hasInDiscount;
  bool hasInCombo;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        storeId: json["store_id"],
        description: json["description"],
        indexImageAvatar: 0,
        productDiscount: json["product_discount"] == null
            ? null
            : ProductDiscount.fromJson(json["product_discount"]),
        hasInDiscount: json["has_in_discount"],
        hasInCombo: json["has_in_combo"],
        price: double.parse(json["price"].toString()),
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
        "has_in_discount": hasInDiscount,
        "has_in_combo": hasInCombo,
        "details": details == null
            ? null
            : List<dynamic>.from(details.map((x) => x.toJson())),
        "images":
            images == null ? null : images.map((e) => e.imageUrl).toList(),
        "categories":
            categories == null ? null : categories.map((e) => e.id).toList(),
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
        name: json["name"],
        attributes: List<Attributes>.from(
            json["attributes"].map((x) => Attributes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
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

class ProductDiscount {
  ProductDiscount({
    this.value,
    this.discountPrice,
  });

  int value;

  double discountPrice;

  factory ProductDiscount.fromJson(Map<String, dynamic> json) =>
      ProductDiscount(
        value: json["value"],
        discountPrice:
            double.tryParse(json["discount_price"].toString()).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "discount_price": discountPrice,
      };
}
