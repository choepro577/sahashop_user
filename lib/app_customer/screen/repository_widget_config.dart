import 'package:flutter/material.dart';
import 'package:sahashop_user/app_customer/components/product_item/product_item_widget.dart';
import 'package:sahashop_user/app_user/data/example/product.dart';
import 'banner_type/banner_type1.dart';
import 'banner_type/banner_type2.dart';
import 'banner_type/banner_type3.dart';
import 'banner_type/banner_type4.dart';
import 'cart_screen/cart_screen_1.dart';
import 'category_product_screen/category_product_screen_1.dart';
import 'category_product_screen/category_product_screen_2.dart';
import 'list_category/list_category_type1.dart';
import 'list_category/list_category_type2.dart';
import 'product_screen/product_screen_1.dart';
import 'screen_home/home_screen_1.dart';
import 'screen_home/home_screen_2.dart';

class RepositoryWidgetCustomer {
  List<Widget> LIST_WIDGET_HOME_SCREEN = [
    HomeScreenStyle1(),
    HomeScreenStyle2(),
  ];

  List<Widget> LIST_WIDGET_CATEGORY_PRODUCT = [
    CategoryProductStyle1(),
    CategoryProductStyle2(),
  ];

  List<Widget> LIST_WIDGET_PRODUCT_SCREEN = [
    ProductScreen1(),
    ProductScreen1(),
  ];

  List<Widget> LIST_WIDGET_CART_SCREEN = [
    CartScreen1(),
    //CartScreen1(),
  ];

  List<Widget> LIST_ITEM_PRODUCT_WIDGET = [
    ProductItemWidget(product: EXAMPLE_LIST_PRODUCT[0]),
  ];

  List<Widget> LIST_WIDGET_BANNER = [
    BannerType1(height: 120),
    BannerType2(height: 120),
    BannerType3(height: 130),
    BannerType4(height: 140),
  ];

  List<Widget> LIST_WIDGET_LIST_CATEGORY = [
    ListCategoryType1(),
    ListCategoryType2(),
  ];
}
