import 'package:flutter/material.dart';
import 'package:sahashop_user/components/config_app/banner_type/banner_type1.dart';
import 'package:sahashop_user/components/config_app/search_bar_type/search_bar_type1.dart';
import 'package:sahashop_user/components/config_app/search_bar_type/search_bar_type2.dart';
import 'package:sahashop_user/components/config_app/search_bar_type/search_bar_type3.dart';
import 'package:sahashop_user/components/config_app/search_bar_type/search_bar_type4.dart';
import 'package:sahashop_user/components/config_app/search_bar_type/search_bar_type5.dart';
import 'package:sahashop_user/components/config_app/search_bar_type/search_bar_type6.dart';
import 'package:sahashop_user/screen/config_app/constantConfig/contansConfig.dart';

import 'banner_type/banner_type1.dart';
import 'banner_type/banner_type2.dart';
import 'banner_type/banner_type3.dart';
import 'category_product_screen/category_product_screen_1.dart';
import 'category_product_screen/category_product_screen_2.dart';
import 'list_category/list_category_type1.dart';
import 'list_category/list_category_type2.dart';
import 'screen_home/home_screen_1.dart';
import 'screen_home/home_screen_2.dart';

final List<Widget> LIST_WIDGET_HOME_SCREEN = [
  HomeScreenStyle1(),
  HomeScreenStyle2(),
];

List<Widget> LIST_WIDGET_CATEGORY_PRODUCT = [
  CategoryProductStyle1(),
  CategoryProductStyle2(),
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
