import 'package:flutter/material.dart';
import 'package:sahashop_user/app_user/data/example/product.dart';
import 'banner/banner_style_2/banner_type_2.dart';
import 'banner/banner_style_4/banner_type_4.dart';
import 'banner/banner_style_3/banner_type_3.dart';
import 'banner/banner_style_1/banner_type_1.dart';
import '../screen_default/cart_screen/cart_screen_1.dart';
import 'banner/banner_style_5/banner_type_1.dart';
import 'category_product_screen/category_product_style_1/category_product_screen_1.dart';
import 'category_product_screen/category_product_style_2/category_product_screen_2.dart';
import 'home/home_style_1/home_style_1.dart';
import 'home/home_style_2/home_style_2.dart';
import 'home/home_style_3/home_style_3.dart';
import 'home/home_style_4/home_style_4.dart';
import 'home/home_style_5/home_style_5.dart';
import 'product_item_widget/product_item_style_1/product_item_widget_style_1.dart';
import 'product_item_widget/product_item_style_2/product_item_widget_style_2.dart';
import 'product_item_widget/product_item_style_3/product_item_widget_style_3.dart';
import 'product_item_widget/product_item_style_4/product_item_widget_style_4.dart';
import 'product_item_widget/product_item_style_5/product_item_widget_style_5.dart';
import 'product_screen/product_style_1/product_screen_1.dart';
import 'product_screen/product_style_2/product_screen_2.dart';
import 'product_screen/product_style_3/product_screen_3.dart';
import 'product_screen/product_style_4/product_screen_4.dart';
import 'product_screen/product_style_5/product_screen_5.dart';

class RepositoryWidgetCustomer {
  List<Widget> LIST_HOME_SCREEN = [
    HomeScreenStyle1(),
    HomeScreenStyle2(),
    HomeScreenStyle3(),
    HomeScreenStyle4(),
    HomeScreenStyle5(),
  ];

  List<Widget> LIST_CATEGORY_PRODUCT_SCREEN = [
    CategoryProductStyle1(),
    CategoryProductStyle2(),
  ];

  List<Widget> LIST_PRODUCT_SCREEN = [
    ProductScreen1(),
    ProductScreen2(),
    ProductScreen3(),
    ProductScreen4(),
    ProductScreen5(),
  ];

  List<Widget> LIST_ITEM_PRODUCT_WIDGET = [
    ProductItemWidgetStyle1(product: EXAMPLE_LIST_PRODUCT[0]),
    ProductItemWidgetStyle2(product: EXAMPLE_LIST_PRODUCT[0]),
    ProductItemWidgetStyle3(product: EXAMPLE_LIST_PRODUCT[0]),
    ProductItemWidgetStyle4(product: EXAMPLE_LIST_PRODUCT[0]),
    ProductItemWidgetStyle5(product: EXAMPLE_LIST_PRODUCT[0]),
  ];

  List<Widget> LIST_WIDGET_BANNER = [
    BannerType1(height: 220),
    BannerType2(height: 220),
    BannerType3(height: 220),
    BannerType4(height: 220),
    BannerType5(height: 220),
  ];
}
