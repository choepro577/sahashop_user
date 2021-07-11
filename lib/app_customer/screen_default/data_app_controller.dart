import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/category_product_screen/input_model_products.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/product_screen/input_model.dart';
import 'package:sahashop_user/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_user/app_customer/utils/customer_info.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/badge.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/model/category_post.dart';
import 'package:sahashop_user/app_user/model/home_data.dart';
import 'package:sahashop_user/app_user/model/info_customer.dart';
import 'package:sahashop_user/app_user/model/post.dart';
import 'package:sahashop_user/app_user/model/roll_call.dart';
import 'category_post_screen/input_model_posts.dart';


class DataAppCustomerController extends GetxController {
  InputModelProduct? inputModelProduct;
  InputModelProducts? inputModelProducts;
  InputModelPosts? inputModelPosts;

  Post? postCurrent;
  var badge = Badge().obs;
  HomeData? homeData = HomeData();
  List<RollCall>? listRollCall;
  int? scoreToday;
  var isCheckIn = false;

  var isLogin = false.obs;
  Rx<InfoCustomer?> infoCustomer = InfoCustomer().obs;

  CartController cartController = Get.put(CartController());

  DataAppCustomerController() {
    //  productCurrent = EXAMPLE_LIST_PRODUCT[0];
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHomeData();
    checkLogin();
  }

  Future<void> checkLogin() async {
    if (await CustomerInfo().hasLogged()) {
      getInfoCustomer();
      getBadge();
      getRollCall();
    } else {
      // noLogin(context);
    }
  }

  Future<void> getRollCall() async {
    try {
      var data = await CustomerRepositoryManager.scoreRepository.getRollCall();
      listRollCall = data!.data!.listRollCall!;
      var indexCheck = listRollCall!
          .map((e) => e.date)
          .toList()
          .indexWhere((element) => element!.day == DateTime.now().day);
      scoreToday = data.data!.scoreInDay;
      if (indexCheck != -1) {
        if (listRollCall![indexCheck].checked == false) {
          isCheckIn = true;
        } else {
          isCheckIn = false;
        }
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> checkIn() async {
    try {
      var data = await CustomerRepositoryManager.scoreRepository.checkIn();
      SahaAlert.showToastMiddle(message: "Điểm danh thành công");
      isCheckIn = false;
      getBadge();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getInfoCustomer() async {
    if (await CustomerInfo().hasLogged()) {
      try {
        var res = await CustomerRepositoryManager.infoCustomerRepository
            .getInfoCustomer();
        infoCustomer.value = res!.data;
        isLogin.value = true;
      } catch (err) {
        // SahaAlert.showError(message: err.toString());
        isLogin.value = false;
      }
    } else {
      isLogin.value = false;
    }
  }



  Future<bool?> getHomeData() async {
    try {
      var data = await CustomerRepositoryManager.homeDataCustomerRepository
          .getHomeData();
      homeData = data;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  /// Badge

  Future<void> getBadge() async {
    try {
      var data = await CustomerRepositoryManager.badgeRepository.getBadge();
      badge.value = data!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
