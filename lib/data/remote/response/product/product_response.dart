import 'dart:convert';

import 'package:sahashop_user/model/category.dart';

ProductResponse productResponseFromJson(String str) => ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) => json.encode(data.toJson());

class ProductResponse {
  ProductResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int code;
  bool success;
  String msgCode;
  DataProductCreate data;

  factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    data: DataProductCreate.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "data": data.toJson(),
  };
}

class DataProductCreate {
  DataProductCreate({
    this.description,
    this.name,
    this.indexImageAvatar,
    this.storeId,
    this.price,
    this.barcode,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.images,
    this.details,
    this.categories,
  });

  String description;
  String name;
  int indexImageAvatar;
  int storeId;
  int price;
  String barcode;
  int status;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  List<dynamic> images;
  List<Detail> details;
  List<Category> categories;

  factory DataProductCreate.fromJson(Map<String, dynamic> json) => DataProductCreate(
    description: json["description"],
    name: json["name"],
    indexImageAvatar:int.tryParse( json["index_image_avatar"]) ?? 0,
    storeId: json["store_id"],
    price: int.tryParse( json["price"])  ?? 0,
    barcode: json["barcode"],
    status:  int.tryParse( json["status"])??0,
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id:  json["id"],
    images: List<dynamic>.from(json["images"].map((x) => x)),
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "name": name,
    "index_image_avatar": indexImageAvatar,
    "store_id": storeId,
    "price": price,
    "barcode": barcode,
    "status": status,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
    "images": List<dynamic>.from(images.map((x) => x)),
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Detail {
  Detail({
    this.id,
    this.name,
    this.attributes,
  });

  int id;
  String name;
  List<Attribute> attributes;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    name: json["name"],
    attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
  };
}

class Attribute {
  Attribute({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
