import 'dart:convert';

ProductRequest productRequestFromJson(String str) => ProductRequest.fromJson(json.decode(str));

String productRequestToJson(ProductRequest data) => json.encode(data.toJson());

class ProductRequest {
  ProductRequest({
    this.description,
    this.name,
    this.indexImageAvatar,
    this.price,
    this.barcode,
    this.status,
    this.images,
    this.listDistribute,
    this.listAttribute,
    this.categories,
  });

  String description;
  String name;
  int indexImageAvatar;
  double price;
  String barcode;
  int status;
  List<String> images;
  List<ListDistribute> listDistribute;
  List<ListAttribute> listAttribute;
  List<int> categories;

  factory ProductRequest.fromJson(Map<String, dynamic> json) => ProductRequest(
    description: json["description"],
    name: json["name"],
    indexImageAvatar: json["index_image_avatar"],
    price: json["price"],
    barcode: json["barcode"],
    status: json["status"],
    images: List<String>.from(json["images"].map((x) => x)),
    listDistribute: List<ListDistribute>.from(json["list_distribute"].map((x) => ListDistribute.fromJson(x))),
    listAttribute: List<ListAttribute>.from(json["list_attribute"].map((x) => ListAttribute.fromJson(x))),
    categories: List<int>.from(json["categories"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "name": name,
    "index_image_avatar": indexImageAvatar,
    "price": price,
    "barcode": barcode,
    "status": status,
    "images": List<dynamic>.from(images.map((x) => x)),
    "list_distribute": List<dynamic>.from(listDistribute.map((x) => x.toJson())),
    "list_attribute": List<dynamic>.from(listAttribute.map((x) => x.toJson())),
    "categories": List<dynamic>.from(categories.map((x) => x)),
  };
}

class ListAttribute {
  ListAttribute({
    this.name,
    this.value,
  });

  String name;
  String value;

  factory ListAttribute.fromJson(Map<String, dynamic> json) => ListAttribute(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
  };
}

class ListDistribute {
  ListDistribute({
    this.name,
    this.list,
  });

  String name;
  List<ListElement> list;

  factory ListDistribute.fromJson(Map<String, dynamic> json) => ListDistribute(
    name: json["name"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    this.name,
    this.imageUrl,
  });

  String name;
  String imageUrl;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    name: json["name"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image_url": imageUrl,
  };
}
