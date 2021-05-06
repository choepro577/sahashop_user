import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/controller/config_controller.dart';
import 'package:sahashop_user/model/home_data.dart';
import 'package:sahashop_user/model/product.dart';
import 'data_widget_config.dart';

class DataAppCustomerController extends GetxController {
  Product productCurrent = Product();
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

  void toHomeScreen() {
    ConfigController configController = Get.find();
    if (configController.configApp?.homePageType != null &&
        configController.configApp.homePageType <
            LIST_WIDGET_HOME_SCREEN.length) {
      Get.to(() =>
          LIST_WIDGET_HOME_SCREEN[configController.configApp.homePageType]);
    } else {
      Get.to(() => LIST_WIDGET_HOME_SCREEN[0]);
    }
  }

  Widget getBanner() {

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
