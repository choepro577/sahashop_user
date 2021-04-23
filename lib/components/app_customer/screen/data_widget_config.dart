import 'package:flutter/material.dart';
import 'package:sahashop_user/data/example/data_example.dart';

import 'banner_type/banner_type1.dart';
import 'banner_type/banner_type2.dart';
import 'banner_type/banner_type3.dart';
import 'cart_screen_type/cart_screen_1.dart';
import 'category_product_screen/category_product_screen_1.dart';
import 'category_product_screen/category_product_screen_2.dart';
import 'list_category/list_category_type1.dart';
import 'list_category/list_category_type2.dart';
import 'product_screen/product_screen_1.dart';
import 'screen_home/home_screen_1.dart';
import 'screen_home/home_screen_2.dart';
import 'search_bar_type/search_bar_type1.dart';
import 'search_bar_type/search_bar_type2.dart';
import 'search_bar_type/search_bar_type3.dart';
import 'search_bar_type/search_bar_type4.dart';
import 'search_bar_type/search_bar_type5.dart';
import 'search_bar_type/search_bar_type6.dart';

final List<Widget> LIST_WIDGET_HOME_SCREEN = [
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

List<Widget> LIST_WIDGET_SEARCH_BAR = [
  SearchBarType1(),
  SearchBarType2(),
  SearchBarType3(),
  SearchBarType4(),
  SearchBarType5(),
  SearchBarType6(),
];

List<Widget> LIST_WIDGET_BANNER = [
  BannerType1(imgList: imgList, height: 120),
  BannerType2(imgList: imgList, height: 120),
  BannerType3(imgList: imgList, height: 130),
];

List<Widget> LIST_WIDGET_LIST_CATEGORY = [
  ListCategoryType1(),
  ListCategoryType2(),
];
