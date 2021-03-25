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
    this.detail,
  });

  String description;
  String name;
  int indexImageAvatar;
  int price;
  String barcode;
  int status;
  List<String> images;
  List<Detail> detail;

  factory ProductRequest.fromJson(Map<String, dynamic> json) => ProductRequest(
    description: json["description"],
    name: json["name"],
    indexImageAvatar: json["index_image_avatar"],
    price: json["price"],
    barcode: json["barcode"],
    status: json["status"],
    images: List<String>.from(json["images"].map((x) => x)),
    detail: List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "name": name,
    "index_image_avatar": indexImageAvatar,
    "price": price,
    "barcode": barcode,
    "status": status,
    "images": List<dynamic>.from(images.map((x) => x)),
    "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
  };
}

class Detail {
  Detail({
    this.atrribute,
  });

  Atrribute atrribute;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    atrribute: Atrribute.fromJson(json["atrribute"]),
  );

  Map<String, dynamic> toJson() => {
    "atrribute": atrribute.toJson(),
  };
}

class Atrribute {
  Atrribute({
    this.name,
    this.items,
  });

  String name;
  List<String> items;

  factory Atrribute.fromJson(Map<String, dynamic> json) => Atrribute(
    name: json["name"],
    items: List<String>.from(json["items"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "items": List<dynamic>.from(items.map((x) => x)),
  };
}
