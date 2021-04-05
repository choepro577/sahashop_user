class Product {
  String description;
  String name;
  int indexImageAvatar;
  int price;
  String barcode;
  int status;
  List<String> images;
  List<Detail> detail;

  Product(
      {this.description,
        this.name,
        this.indexImageAvatar,
        this.price,
        this.barcode,
        this.status,
        this.images,
        this.detail});

  Product.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    name = json['name'];
    indexImageAvatar = json['index_image_avatar'];
    price = json['price'];
    barcode = json['barcode'];
    status = json['status'];
    images = json['images'].cast<String>();
    if (json['detail'] != null) {
      detail = new List<Detail>();
      json['detail'].forEach((v) {
        detail.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['name'] = this.name;
    data['index_image_avatar'] = this.indexImageAvatar;
    data['price'] = this.price;
    data['barcode'] = this.barcode;
    data['status'] = this.status;
    data['images'] = this.images;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  Atrribute atrribute;

  Detail({this.atrribute});

  Detail.fromJson(Map<String, dynamic> json) {
    atrribute = json['atrribute'] != null
        ? new Atrribute.fromJson(json['atrribute'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.atrribute != null) {
      data['atrribute'] = this.atrribute.toJson();
    }
    return data;
  }
}

class Atrribute {
  String name;
  List<String> items;

  Atrribute({this.name, this.items});

  Atrribute.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    items = json['items'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['items'] = this.items;
    return data;
  }
}