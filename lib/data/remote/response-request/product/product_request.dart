import 'dart:convert';

import 'package:sahashop_user/model/product.dart';

ProductRequest productRequestFromJson(String str) =>
    ProductRequest.fromJson(json.decode(str));

String productRequestToJson(ProductRequest data) => json.encode(data.toJson());

class ProductRequest {
  ProductRequest({
    this.description,
    this.name,
    this.indexImageAvatar,
    this.price,
    this.barcode,
    this.status,
    this.quantityInStock,
    this.images,
    this.listDistribute,
    this.listAttribute,
    this.categories,
  });

  String? description;
  String? name;
  int? indexImageAvatar;
  double? price;
  String? barcode;
  int? status;
  int? quantityInStock;
  List<String>? images;
  List<DistributesRequest>? listDistribute;
  List<ListAttribute>? listAttribute;
  List<int>? categories;

  factory ProductRequest.fromJson(Map<String, dynamic> json) => ProductRequest(
        description: json["description"],
        name: json["name"],
        indexImageAvatar: json["index_image_avatar"],
        price: json["price"],
        barcode: json["barcode"],
        status: json["status"],
        quantityInStock: json['quantity_in_stock'],
        images: List<String>.from(json["images"].map((x) => x)),
        listDistribute: List<DistributesRequest>.from(
            json["list_distribute"].map((x) => DistributesRequest.fromJson(x))),
        listAttribute: List<ListAttribute>.from(
            json["list_attribute"].map((x) => ListAttribute.fromJson(x))),
        categories: List<int>.from(json["categories"].map((x) => x)),
      );

  factory ProductRequest.fromProduct(Product product) {
    List<ListAttribute> listAttributeRequest = [];
    product.attributes!.forEach((key) {
      if (key != null) {
        listAttributeRequest
            .add(ListAttribute(name: key.name, value: key.value));
      }
    });

    List<DistributesRequest> listDistribute = [];
    if (product.distributes != null) {
      listDistribute.addAll(product.distributes!.map((listDistribute) {
        ElementDistributes? ele = listDistribute.elementDistributes!.firstWhere(
            (elementDistribute) => elementDistribute.imageUrl != null);
        bool boolHasImage = false;
        if (ele != null) {
          boolHasImage = true;
        }
        return DistributesRequest(
            boolHasImage: boolHasImage,
            name: listDistribute.name,
            elementDistributes: listDistribute.elementDistributes!
                .map((e) => ElementDistributesRequest(
                    name: e.name, imageUrl: e.imageUrl))
                .toList());
      }).toList());
    }

    return ProductRequest(
      description: product.description,
      name: product.name,
      indexImageAvatar: product.indexImageAvatar,
      price: product.price,
      barcode: product.barcode,
      status: product.status,
      quantityInStock: product.quantityInStock,
      images: product.images!.map((e) => e.imageUrl!).toList(),
      listDistribute: listDistribute,
      listAttribute: listAttributeRequest,
      categories: product.categories!.map((e) => e.id!).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "name": name,
        "index_image_avatar": indexImageAvatar,
        "price": price,
        "barcode": barcode,
        "status": status,
        "quantity_in_stock":quantityInStock,
        "images": images!,
        "list_distribute":
            List<dynamic>.from(listDistribute!.map((x) => x.toJson())),
        "list_attribute":
            List<dynamic>.from(listAttribute!.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories!.map((x) => x)),
      };
}

class ListAttribute {
  ListAttribute({
    this.name,
    this.value,
  });

  String? name;
  String? value;

  factory ListAttribute.fromJson(Map<String, dynamic> json) => ListAttribute(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}

class DistributesRequest {
  int? id;
  String? name;
  bool? boolHasImage;
  String? createdAt;
  String? updatedAt;
  List<ElementDistributesRequest?>? elementDistributes;

  DistributesRequest(
      {this.id,
      this.name,
      this.createdAt,
      this.boolHasImage = false,
      this.updatedAt,
      this.elementDistributes});

  DistributesRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['element_distributes'] != null) {
      elementDistributes = [];
      json['element_distributes'].forEach((v) {
        elementDistributes!.add(new ElementDistributesRequest.fromJson(v));
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
          this.elementDistributes!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class ElementDistributesRequest {
  String? name;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  ElementDistributesRequest(
      {this.name, this.imageUrl, this.createdAt, this.updatedAt});

  ElementDistributesRequest.fromJson(Map<String, dynamic> json) {
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
