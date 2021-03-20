import 'package:flutter/material.dart';
import 'package:sahashop_user/components/config_app/font_type/font.dart';
import 'screens_config/category_product/category_product.dart';
import 'screens_config/header_config/banner_config.dart';
import 'screens_config/header_config/list_category.dart';
import 'screens_config/header_config/searchBar.dart';
import 'screens_config/home_screen/home_screen.dart';
import 'screens_config/icon_helpler/iconType/supportIcon.dart';
import '../../components/config_app/logo_type/logo.dart';
import '../../components/config_app/theme_color/theme_color.dart';

var UIDataConfig = [
  ParentConfig(name: "Cấu hình chính", icon: "config.svg", listChildConfig: [
    ChildConfig(name: "Theme", editWidget: MainConfigThemeColor()),
    ChildConfig(name: "Logo", editWidget: MainConfigLogo()),
    ChildConfig(name: "Kiểu chữ", editWidget: FontConfig()),
  ]),
  ParentConfig(name: "Nút hỗ trợ", icon: "support.svg", listChildConfig: [
    ChildConfig(name: "Contact", editWidget: SupportIcon()),
  ]),
  ParentConfig(name: "Thành phần chính", icon: "home.svg", listChildConfig: [
    ChildConfig(name: "Thanh tìm kiếm", editWidget: SearchBarConfig()),
    ChildConfig(name: "Hộp ví tích điểm", editWidget: BoxPionConfig()),
    ChildConfig(name: "Hộp ví tích điểm", editWidget: ListCategoryConfig()),
  ]),
  ParentConfig(name: "Màn hình trang chủ", icon: "home.svg", listChildConfig: [
    ChildConfig(name: "Mời chọn kiểu giao diện", editWidget: HomeScreenConfig(

    )),
  ]),
  ParentConfig(
      name: "Màn hình Danh mục sản phẩm",
      icon: "categories.svg",
      listChildConfig: [
        ChildConfig(
            name: "Mời chọn kiểu giao diện",
            editWidget: CategoryProductConfig()),
      ]),
  ParentConfig(
      name: "Màn hình Sản phẩm",
      icon: "product_screen.svg",
      listChildConfig: [
        ChildConfig(
          name: "Logo",
        )
      ]),
  ParentConfig(name: "Màn hình Liên hệ", icon: "bell.svg", listChildConfig: [
    ChildConfig(
      name: "Logo",
    )
  ]),
  ParentConfig(name: "Màn hình giỏ hàng", icon: "cart.svg", listChildConfig: [
    ChildConfig(
      name: "Logo",
    )
  ]),
];

class ParentConfig {
  String name;
  String icon;
  List<ChildConfig> listChildConfig;

  ParentConfig({this.name, this.listChildConfig, this.icon});
}

class ChildConfig {
  String name;
  Widget editWidget;

  ChildConfig({this.name, this.editWidget});
}
