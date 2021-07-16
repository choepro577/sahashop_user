import 'package:flutter/material.dart';
import 'package:sahashop_user/app_customer/screen_default/theme_color/theme_color.dart';
import 'package:sahashop_user/app_user/screen/config_app/screens_config/font_type/font.dart';
import 'package:sahashop_user/app_user/screen/config_app/screens_config/logo_type/logo.dart';
import 'package:sahashop_user/app_user/screen/config_app/screens_config/product_screen/product_screen.dart';
import 'screens_config/button_style/button_style.dart';
import 'screens_config/category_product/category_product.dart';
import 'screens_config/home_buttons/button_config.dart';
import 'screens_config/home_screen/home_screen.dart';
import 'screens_config/icon_helpler/iconType/supportIcon.dart';
import 'screens_config/layout_sort/layout_config.dart';
import 'screens_config/main_component_config/banner_config.dart';
import 'screens_config/main_component_config/image_carousel/select_image_carousel.dart';
import 'screens_config/main_component_config/product_item.dart';

class UIDataConfig {
  final UIData = [
    ParentConfig(
        name: "Cấu hình chính",
        icon: "main_config.svg",
        listChildConfig: [
          ChildConfig(
              name: "Màu sắc đặc trưng", editWidget: MainConfigThemeColor()),
          ChildConfig(name: "Logo App của bạn", editWidget: MainConfigLogo()),
          ChildConfig(name: "Kiểu chữ", editWidget: FontConfig()),
        ]),
    ParentConfig(name: "Nút hỗ trợ", icon: "contact.svg", listChildConfig: [
      ChildConfig(name: "Contact", editWidget: SupportIcon()),
    ]),
    ParentConfig(
        name: "Màn hình trang chủ",
        icon: "home.svg",
        listChildConfig: [
          ChildConfig(name: "Kiểu giao diện", editWidget: HomeScreenConfig()),
          ChildConfig(
              name: "Nút điều hướng chính", editWidget: ButtonHomeConfig()),
          ChildConfig(name: "Kiểu nút", editWidget: ButtonTypeConfig()),
          ChildConfig(name: "Sắp xếp bố cục", editWidget: LayoutConfig()),
        ]),
    ParentConfig(
        name: "Thành phần chính",
        icon: "main_component.svg",
        listChildConfig: [
          ChildConfig(name: "Sản phẩm", editWidget: ProductItemConfig()),
          ChildConfig(name: "Ảnh banner", editWidget: SelectCarouselImages()),
          ChildConfig(name: "Kiểu banner ", editWidget: BoxPionConfig()),
        ]),
    ParentConfig(
        name: "Màn hình Danh mục sản phẩm",
        icon: "category.svg",
        listChildConfig: [
          ChildConfig(
              name: "Mời chọn kiểu giao diện",
              editWidget: CategoryProductConfig()),
        ]),
    ParentConfig(
        name: "Màn hình sản phẩm",
        icon: "product.svg",
        listChildConfig: [
          ChildConfig(
              name: "Màn hình sản phẩm", editWidget: ProductScreenConfig())
        ]),
    ParentConfig(name: "Màn hình Liên hệ", icon: "call.svg", listChildConfig: [
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
