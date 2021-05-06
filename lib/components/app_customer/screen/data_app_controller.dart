import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/controller/config_controller.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/home_data.dart';
import 'package:sahashop_user/model/product.dart';
import 'data_widget_config.dart';
import 'search_screen/search_screen.dart';

class DataAppCustomerController extends GetxController {
  Product productCurrent = Product();
  Category categoryCurrent;
  HomeData homeData = HomeData();
  DataAppCustomerController() {
    productCurrent = LIST_PRODUCT_EXAMPLE[0];
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHomeData();
  }

  void toSearchScreen() {
    Get.to(SearchScreen(
      searchText: "",
    )).then((value) {
      FocusScope.of(Get.context).requestFocus(FocusNode());
    });
  }

  void toCategoryProductScreen({Category category}) {
    ConfigController configController = Get.find();
    categoryCurrent = category;
    if (configController.configApp.categoryPageType <
        LIST_WIDGET_CATEGORY_PRODUCT.length) {
      Get.to(LIST_WIDGET_CATEGORY_PRODUCT[
          configController.configApp.categoryPageType]);
    } else {
      Get.to(LIST_WIDGET_CATEGORY_PRODUCT[0]);
    }
  }

  void toProductScreen(Product product) {
    ConfigController configController = Get.find();
    productCurrent = product;

    if (configController.configApp.productPageType <
        LIST_WIDGET_PRODUCT_SCREEN.length) {
      Get.to(LIST_WIDGET_PRODUCT_SCREEN[
          configController.configApp.productPageType]);
    } else {
      Get.to(LIST_WIDGET_PRODUCT_SCREEN[0]);
    }
  }

  Future toHomeScreen() {
    ConfigController configController = Get.find();
    if (configController.configApp?.homePageType != null &&
        configController.configApp.homePageType <
            LIST_WIDGET_HOME_SCREEN.length) {
      return Get.to(() =>
          LIST_WIDGET_HOME_SCREEN[configController.configApp.homePageType]);
    } else {
      return Get.to(() => LIST_WIDGET_HOME_SCREEN[0]);
    }
  }

  Widget getSearchWidget() {
    ConfigController configController = Get.find();
    if (configController.configApp?.searchType != null &&
        configController.configApp.searchType < LIST_WIDGET_SEARCH_BAR.length) {
      return LIST_WIDGET_SEARCH_BAR[configController.configApp.searchType];
    } else {
      return LIST_WIDGET_SEARCH_BAR[0];
    }
  }

  Widget getBannerWidget() {
    ConfigController configController = Get.find();

    if (configController.configApp?.carouselType != null &&
        configController.configApp.carouselType < LIST_WIDGET_BANNER.length) {
      return LIST_WIDGET_BANNER[configController.configApp.carouselType];
    } else {
      return LIST_WIDGET_BANNER[0];
    }
  }

  Future<void> getHomeData() async {
    try {
      var data = await CustomerRepositoryManager.homeDataCustomerRepository
          .getHomeData();
      homeData = data;
      return true;
    } catch (err) {
      return false;
    }
  }
}
