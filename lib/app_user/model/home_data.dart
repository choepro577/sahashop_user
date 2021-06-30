import 'package:sahashop_user/app_user/model/post.dart';
import 'package:sahashop_user/app_user/model/product.dart';

import 'banner.dart';
import 'category.dart';
import 'discount_product_list.dart';

class HomeData {
  HomeData({
    this.banner,
    this.allCategory,
    this.discountProducts,
    this.newProduct,
    this.bestSellProduct,
    this.newPost,
  });

  BannerList? banner;
  AllCategory? allCategory;
  DiscountProducts? discountProducts;
  NewProduct? newProduct;
  BestSellProduct? bestSellProduct;
  NewPost? newPost;

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        banner: BannerList.fromJson(json["banner"]),
        allCategory: AllCategory.fromJson(json["allCategory"]),
        discountProducts: DiscountProducts.fromJson(json["discountProducts"]),
        newProduct: NewProduct.fromJson(json["newProduct"]),
        bestSellProduct: BestSellProduct.fromJson(json["bestSellProduct"]),
        newPost: NewPost.fromJson(json["newPost"]),
      );

  Map<String, dynamic> toJson() => {
        "banner": banner!.toJson(),
        "allCategory": allCategory!.toJson(),
        "discountProducts": discountProducts!.toJson(),
        "newProduct": newProduct!.toJson(),
        "bestSellProduct": bestSellProduct!.toJson(),
        "newPost": newPost!.toJson(),
      };
}

class AllCategory {
  AllCategory({
    this.name,
    this.type,
    this.list,
  });

  String? name;
  String? type;
  List<Category>? list;

  factory AllCategory.fromJson(Map<String, dynamic> json) => AllCategory(
        name: json["name"],
        type: json["type"],
        list:
            List<Category>.from(json["list"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "list": List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class BannerList {
  BannerList({
    this.name,
    this.type,
    this.list,
  });

  String? name;
  String? type;
  List<BannerItem>? list;

  factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
        name: json["name"],
        type: json["type"],
        list: List<BannerItem>.from(
            json["list"].map((x) => BannerItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "list": List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}



class NewProduct {
  NewProduct({
    this.name,
    this.type,
    this.list,
  });

  String? name;
  String? type;
  List<Product>? list;

  factory NewProduct.fromJson(Map<String, dynamic> json) => NewProduct(
        name: json["name"],
        type: json["type"],
        list: List<Product>.from(json["list"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "list": List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class BestSellProduct {
  BestSellProduct({
    this.name,
    this.type,
    this.list,
  });

  String? name;
  String? type;
  List<Product>? list;

  factory BestSellProduct.fromJson(Map<String, dynamic> json) =>
      BestSellProduct(
        name: json["name"],
        type: json["type"],
        list: List<Product>.from(json["list"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "list": List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class DiscountProducts {
  DiscountProducts({
    this.name,
    this.type,
    this.list,
  });

  String? name;
  String? type;
  List<DiscountProductsList>? list;

  factory DiscountProducts.fromJson(Map<String, dynamic> json) =>
      DiscountProducts(
        name: json["name"],
        type: json["type"],
        list: List<DiscountProductsList>.from(
            json["list"].map((x) => DiscountProductsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "list": List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class NewPost {
  NewPost({
    this.name,
    this.type,
    this.list,
  });

  String? name;
  String? type;
  List<Post>? list;

  factory NewPost.fromJson(Map<String, dynamic> json) => NewPost(
        name: json["name"],
        type: json["type"],
        list: List<Post>.from(json["list"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "list": List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}
