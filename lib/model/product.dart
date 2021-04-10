import 'package:sahashop_user/model/category.dart';

class Product {
  String description;
  String name;
  int indexImageAvatar;
  int price;
  String barcode;
  int status;
  List<ImageProduct> images;
  List<Details> details;
  List<Category> categories;

  Product(
      {this.description,
      this.name,
      this.indexImageAvatar,
      this.price,
      this.barcode,
      this.status,
      this.images,
      this.details,
      this.categories});

  Product.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    name = json['name'];
    indexImageAvatar = json['index_image_avatar'];
    price = json['price'];
    barcode = json['barcode'];
    status = json['status'];
    if (json['images'] != null) {
      images = new List<ImageProduct>();
      json['images'].forEach((v) {
        images.add(new ImageProduct.fromJson(v));
      });
    }
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    };
    if (json['categories'] != null) {
    categories = new List<Category>();
    json['categories'].forEach((v) {
    categories.add(new Category.fromJson(v));
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
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
    data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class ImageProduct {
  int id;
  String imageUrl;

  ImageProduct({this.id, this.imageUrl});

  ImageProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Details {
  int id;
  String name;
  List<Attributes> attributes;

  Details({this.id, this.name, this.attributes});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['attributes'] != null) {
      attributes = new List<Attributes>();
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  int id;
  String name;

  Attributes({this.id, this.name});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}