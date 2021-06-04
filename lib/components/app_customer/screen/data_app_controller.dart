import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/components/utils/customer_info.dart';
import 'package:sahashop_user/controller/config_controller.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/category_post.dart';
import 'package:sahashop_user/model/home_data.dart';
import 'package:sahashop_user/model/info_customer.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/model/post.dart';
import 'package:sahashop_user/model/product.dart';
import 'category_post_screen/category_post_screen_1.dart';
import 'category_product_screen/category_product_screen_1.dart';
import 'data_widget_config.dart';
import 'search_screen/search_screen.dart';

class DataAppCustomerController extends GetxController {
  Product productCurrent = Product();
  Category categoryCurrent;
  CategoryPost categoryPostCurrent;
  Post postCurrent;
  HomeData homeData = HomeData();

  var isLogin = false.obs;
  var infoCustomer = InfoCustomer().obs;

  DataAppCustomerController() {
    productCurrent = LIST_PRODUCT_EXAMPLE[0];
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHomeData();
    checkLogin();
    getItemCart();
  }

  Future<void> checkLogin() async {
    if (await CustomerInfo().hasLogged()) {
      getInfoCustomer();
    } else {
      // noLogin(context);
    }
  }

  Future<void> getInfoCustomer() async {
    try {
      var res = await CustomerRepositoryManager.infoCustomerRepository
          .getInfoCustomer();
      infoCustomer.value = res.data;
      isLogin.value = true;
    } catch (err) {
      // SahaAlert.showError(message: err.toString());
    }
  }

  void toSearchScreen() {
    Get.to(SearchScreen(
      searchText: "",
    )).then((value) {
      FocusScope.of(Get.context).requestFocus(FocusNode());
    });
  }

  void toPostAllScreen({CategoryPost categoryPost}) {
    categoryPostCurrent = categoryPost;
    Get.to(CategoryPostStyle1());
  }

  void toPostScreen({Post post}) {
    postCurrent = post;
    Get.to(CategoryProductStyle1());
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
      Get.to(() => LIST_WIDGET_PRODUCT_SCREEN[
          configController.configApp.productPageType]);
    } else {
      Get.to(() => LIST_WIDGET_PRODUCT_SCREEN[0]);
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
      SahaAlert.showError(message: err.toString());
    }
  }

  /// Cart

  var totalMoney = 0.0.obs;
  var listOrder = RxList<Order>();

  Future<void> getItemCart() async {
    try {
      var res = await CustomerRepositoryManager.cartRepository.getItemCart();
      listOrder(res.data.lineItems);
      totalMoney.value = res.data.totalAfterDiscount.toDouble();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateItemCart(int idProduct, int quantity) async {
    try {
      var res = await CustomerRepositoryManager.cartRepository
          .updateItemCart(idProduct, quantity);

      listOrder(res.data.lineItems);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addItemCart(int idProduct) async {
    try {
      var res =
          await CustomerRepositoryManager.cartRepository.addItemCart(idProduct);
      listOrder(res.data.lineItems);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
