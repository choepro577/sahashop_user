import 'dart:convert';
import 'package:sahashop_user/app_user/model/category.dart';

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
    this.quantityInStock,
    this.view,
    this.sold,
    this.likes,
    this.isNew,
    this.isTopSale,
    this.isFavorite,
    this.createdAt,
    this.updatedAt,
    this.distributes,
    this.attributes,
    this.images,
    this.categories,
    this.productDiscount,
    this.hasInDiscount,
    this.hasInCombo,
  });

  int? id;
  String? name;
  int? storeId;
  String? description;
  int? indexImageAvatar;
  double? price;
  String? barcode;
  int? quantityInStock;
  int? sold;
  int? view;
  int? likes;
  int? status;
  bool? isNew;
  bool? isTopSale;
  bool? isFavorite;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Distributes>? distributes;
  List<Attributes>? attributes;
  List<ImageProduct>? images;
  List<Category>? categories;
  ProductDiscount? productDiscount;
  bool? hasInDiscount;
  bool? hasInCombo;

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
        price: double.tryParse(json["price"].toString()) ?? 0 ,
        barcode: json["barcode"],
        status: json["status"],
        quantityInStock: json["quantity_in_stock"],
        sold: json["sold"],
        view: json["view"],
        likes: json['likes'],
        isNew: json['is_new'] ?? false,
        isFavorite: json['is_favorite'] ?? false,
        isTopSale: json['is_top_sale'] ?? false,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        distributes: json['distributes'] != null && json['distributes'] is List
            ? List<Distributes>.from(
                json["distributes"].map((x) => Distributes.fromJson(x)))
            : <Distributes>[],
        attributes: json['attributes']! != null && json['attributes'] is List
            ? List<Attributes>.from(
                json["attributes"].map((x) => Attributes.fromJson(x)))
            : <Attributes>[],
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
        "likes": likes,
        "quantity_in_stock": quantityInStock,
        "sold": sold,
        "view": view,
        "product_discount":
            productDiscount == null ? null : productDiscount!.toJson(),
        "has_in_discount": hasInDiscount,
        "has_in_combo": hasInCombo,
        "distributes": distributes == null
            ? null
            : List<dynamic>.from(distributes!.map((x) => x.toJson())),
        "attributes": attributes == null
            ? null
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "images":
            images == null ? null : images!.map((e) => e.imageUrl).toList(),
        "categories":
            categories == null ? null : categories!.map((e) => e.id).toList(),
      };
}

class ImageProduct {
  ImageProduct({
    this.id,
    this.imageUrl,
  });

  int? id;

  String? imageUrl;

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

  int? value;

  double? discountPrice;

  factory ProductDiscount.fromJson(Map<String, dynamic> json) =>
      ProductDiscount(
        value: json["value"],
        discountPrice:
            double.tryParse(json["discount_price"].toString())!.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "discount_price": discountPrice,
      };
}

class Distributes {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<ElementDistributes>? elementDistributes;

  Distributes(
      {this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.elementDistributes});

  Distributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['element_distributes'] != null) {
      elementDistributes = [];
      json['element_distributes'].forEach((v) {
        elementDistributes!.add(new ElementDistributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.elementDistributes != null) {
      data['element_distributes'] =
          this.elementDistributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ElementDistributes {
  String? name;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  ElementDistributes(
      {this.name, this.imageUrl, this.createdAt, this.updatedAt});

  ElementDistributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Attributes {
  int? id;
  int? storeId;
  int? productId;
  String? name;
  String? value;
  String? createdAt;
  String? updatedAt;

  Attributes(
      {this.id,
      this.storeId,
      this.productId,
      this.name,
      this.value,
      this.createdAt,
      this.updatedAt});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    productId = json['product_id'];
    name = json['name'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
