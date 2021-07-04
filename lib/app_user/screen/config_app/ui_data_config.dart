import 'package:flutter/material.dart';
import 'package:sahashop_user/app_customer/screen_default/theme_color/theme_color.dart';
import 'package:sahashop_user/app_user/screen/config_app/screens_config/font_type/font.dart';
import 'package:sahashop_user/app_user/screen/config_app/screens_config/logo_type/logo.dart';
import 'package:sahashop_user/app_user/screen/config_app/screens_config/product_screen/product_screen.dart';
import 'screens_config/category_product/category_product.dart';
import 'screens_config/home_screen/home_screen.dart';
import 'screens_config/icon_helpler/iconType/supportIcon.dart';
import 'screens_config/main_component_config/banner_config.dart';
import 'screens_config/main_component_config/image_carousel/select_image_carousel.dart';
import 'screens_config/main_component_config/product_item.dart';

class UIDataConfig {
  final UIData = [
    ParentConfig(name: "Cấu hình chính", icon: "config.svg", listChildConfig: [
      ChildConfig(name: "Theme", editWidget: MainConfigThemeColor()),
      ChildConfig(name: "Logo", editWidget: MainConfigLogo()),
      ChildConfig(name: "Kiểu chữ", editWidget: FontConfig()),
    ]),
    ParentConfig(name: "Nút hỗ trợ", icon: "support.svg", listChildConfig: [
      ChildConfig(name: "Contact", editWidget: SupportIcon()),
    ]),
    ParentConfig(
        name: "Màn hình trang chủ",
        icon: "home.svg",
        listChildConfig: [
          ChildConfig(
              name: "Mời chọn kiểu giao diện", editWidget: HomeScreenConfig()),
        ]),
    ParentConfig(
        name: "Thành phần chính",
        icon: "home.svg",
        listChildConfig: [
          ChildConfig(name: "Item sản phẩm", editWidget: ProductItemConfig()),
          ChildConfig(name: "Ảnh banner", editWidget: SelectCarouselImages()),
          ChildConfig(name: "Kiểu banner ", editWidget: BoxPionConfig()),
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
        name: "Màn hình sản phẩm",
        icon: "product_screen.svg",
        listChildConfig: [
          ChildConfig(name: "", editWidget: ProductScreenConfig())
        ]),

    ParentConfig(name: "Màn hình Liên hệ", icon: "bell.svg", listChildConfig: [
      ChildConfig(
        name: "Logo",
      )
    ]),
  ];
}

class ParentConfig {
  String? name;
  String? icon;
  List<ChildConfig>? listChildConfig;

  ParentConfig({this.name, this.listChildConfig, this.icon});
}

class ChildConfig {
  String? name;
  Widget? editWidget;

  ChildConfig({this.name, this.editWidget});
}
