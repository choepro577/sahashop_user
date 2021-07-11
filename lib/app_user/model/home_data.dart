import 'package:sahashop_user/app_user/model/button_home.dart';
import 'package:sahashop_user/app_user/model/post.dart';
import 'package:sahashop_user/app_user/model/product.dart';
import 'banner.dart';
import 'category.dart';
import 'discount_product_list.dart';

enum HomeLayoutEnum {
  BUTTONS,
  CATEGORY,
  PRODUCTS_DISCOUNT,
  PRODUCTS_TOP_SALES,
  PRODUCTS_NEW,
  POSTS_NEW,
}

Map homeLayoutMap = {
  HomeLayoutEnum.BUTTONS: "HOME_BUTTON",
  HomeLayoutEnum.CATEGORY: "CATEGORY",
  HomeLayoutEnum.PRODUCTS_DISCOUNT: "PRODUCTS_DISCOUNT",
  HomeLayoutEnum.PRODUCTS_TOP_SALES: "PRODUCTS_TOP_SALES",
  HomeLayoutEnum.PRODUCTS_NEW: "PRODUCTS_NEW",
  HomeLayoutEnum.POSTS_NEW: "POSTS_NEW",
};

class HomeData {
  HomeData({
    this.listLayout,
    this.banner,
  });

  List<LayoutHome>? listLayout;
  BannerList? banner;

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
      banner: BannerList.fromJson(json["banner"]),
      listLayout: List<LayoutHome>.from(
          json["layouts"].map((x) => LayoutHome.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "banner": banner!.toJson(),
        "layouts": List<dynamic>.from(listLayout!.map((x) => x.toJson())),
      };
}

class LayoutHome {
  String? title;
  String? model;
  String? typeLayout;
  String? typeActionMore;
  bool? hide;
  List<dynamic>? list;

  LayoutHome(
      {this.title,
      this.model,
      this.typeLayout,
      this.typeActionMore,
      this.hide,
      this.list});

  factory LayoutHome.fromJson(Map<String, dynamic> json) {
    var list = [];

    if (json["list"] != null && json["list"] is List) {
      if (json["model"] == "HomeButton")
        list = List<HomeButton>.from(
            json["list"].map((x) => HomeButton.fromJson(x)));

      if (json["model"] == "Product")
        list = List<Product>.from(json["list"].map((x) => Product.fromJson(x)));

      if (json["model"] == "Category")
        list =
            List<Category>.from(json["list"].map((x) => Category.fromJson(x)));

      if (json["model"] == "Post")
        list = List<Post>.from(json["list"].map((x) => Post.fromJson(x)));

    }

    return LayoutHome(
      title: json["title"],
      typeLayout: json["type_layout"],
      model: json["model"],
      typeActionMore: json["type_action_more"],
      hide: json["hide"],
      list: list,
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "type_layout": typeLayout,
        "type_action_more": typeActionMore,
        "hide": hide
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
