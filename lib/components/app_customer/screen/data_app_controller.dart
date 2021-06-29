import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/app_customer/screen/login/login_screen.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/components/app_customer/utils/customer_info.dart';
import 'package:sahashop_user/controller/config_controller.dart';
import 'package:sahashop_user/model/cart.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/category_post.dart';
import 'package:sahashop_user/model/combo.dart';
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
  Product? productCurrent;
  Category? categoryCurrent;
  CategoryPost? categoryPostCurrent;
  Post? postCurrent;
  HomeData? homeData = HomeData();

  var isLogin = false.obs;
  Rx<InfoCustomer?> infoCustomer = InfoCustomer().obs;

  DataAppCustomerController() {
    //  productCurrent = LIST_PRODUCT_EXAMPLE[0];
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
      getItemCart();
    } else {
      // noLogin(context);
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

  void toSearchScreen() {
    Get.to(SearchScreen(
      searchText: "",
    ))!
        .then((value) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    });
  }

  void toPostAllScreen({CategoryPost? categoryPost}) {
    categoryPostCurrent = categoryPost;
    Get.to(CategoryPostStyle1());
  }

  void toPostScreen({Post? post}) {
    postCurrent = post;
    Get.to(CategoryProductStyle1());
  }

  void toCategoryProductScreen({Category? category}) {
    ConfigController configController = Get.find();
    categoryCurrent = category;
    if (configController.configApp.categoryPageType! <
        LIST_WIDGET_CATEGORY_PRODUCT.length) {
      Get.to(LIST_WIDGET_CATEGORY_PRODUCT[
          configController.configApp.categoryPageType!]);
    } else {
      Get.to(LIST_WIDGET_CATEGORY_PRODUCT[0]);
    }
  }

  void toProductScreen(Product product) {
    ConfigController configController = Get.find();
    productCurrent = product;

    if (configController.configApp.productPageType! <
        LIST_WIDGET_PRODUCT_SCREEN.length) {
      Get.to(() => LIST_WIDGET_PRODUCT_SCREEN[
          configController.configApp.productPageType!]);
    } else {
      Get.to(() => LIST_WIDGET_PRODUCT_SCREEN[0]);
    }
  }

  Future? toHomeScreen() {
    ConfigController configController = Get.find();
    if (configController.configApp.homePageType != null &&
        configController.configApp.homePageType! <
            LIST_WIDGET_HOME_SCREEN.length) {
      return Get.to(() =>
          LIST_WIDGET_HOME_SCREEN[configController.configApp.homePageType!]);
    } else {
      return Get.to(() => LIST_WIDGET_HOME_SCREEN[0]);
    }
  }

  Widget getSearchWidget() {
    ConfigController configController = Get.find();
    if (configController.configApp.searchType != null &&
        configController.configApp.searchType! <
            LIST_WIDGET_SEARCH_BAR.length) {
      return LIST_WIDGET_SEARCH_BAR[configController.configApp.searchType!];
    } else {
      return LIST_WIDGET_SEARCH_BAR[0];
    }
  }

  Widget getBannerWidget() {
    ConfigController configController = Get.find();

    if (configController.configApp.carouselType != null &&
        configController.configApp.carouselType! < LIST_WIDGET_BANNER.length) {
      return LIST_WIDGET_BANNER[configController.configApp.carouselType!];
    } else {
      return LIST_WIDGET_BANNER[0];
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

  /// Cart

  var totalMoneyAfterDiscount = 0.0.obs;
  var totalBeforeDiscount = 0.0.obs;
  var productDiscountAmount = 0.0.obs;
  var listOrder = RxList<LineItem>();
  var voucherDiscountAmount = 0.0.obs;
  var comboDiscountAmount = 0.0.obs;
  var voucherCodeChoose = "".obs;
  var listQuantityProduct = RxList<int>();
  var hasInCombo = false.obs;
  var listCombo = RxList<Combo>();
  var listUsedCombo = RxList<UsedCombo>();
  var enoughCondition = RxList<bool>();

  void increaseItem(index) {
    listQuantityProduct[index] = listQuantityProduct[index] + 1;
    updateItemCart(
        listOrder[index].product!.id, listQuantityProduct[index], []);
  }

  void decreaseItem(index) {
    if (listQuantityProduct[index] > 1) {
      listQuantityProduct[index] = listQuantityProduct[index] - 1;
      updateItemCart(
          listOrder[index].product!.id, listQuantityProduct[index], []);
    } else {
      return;
    }
  }

  Future<void> checkLoginToCartScreen() async {
    if (await CustomerInfo().hasLogged()) {
      getItemCart();
    } else {
      Get.back();
      Get.to(() => LoginScreenCustomer());
    }
  }

  Future<void> getComboCustomer() async {
    List<Combo> listComboNew = [];
    try {
      var res = await CustomerRepositoryManager.marketingRepository
          .getComboCustomer();
      res!.data!.forEach((e) {
        bool checkInCombo = false;
        for (int i = 0; i < listOrder.length; i++) {
          int checkHasInCombo = e.productsCombo!.indexWhere(
              (element) => element.product!.id == listOrder[i].product!.id);
          if (checkHasInCombo != -1) {
            checkInCombo = true;
            break;
          } else {}
        }
        if (checkInCombo == true) {
          listComboNew.add(e);
          enoughCondition.add(false);
        }
      });

      listCombo(listComboNew);

      for (int i = 0; i < listCombo.length; i++) {
        var checkEnough = listUsedCombo
            .indexWhere((element) => element.combo!.id == listCombo[i].id);
        if (checkEnough != -1) {
          enoughCondition[i] = true;
        } else {
          enoughCondition[i] = false;
        }
      }

      print("--------------------------${listCombo.length}");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getItemCart() async {
    List<int> listQuantityProductNew = [];
    try {
      var res = await CustomerRepositoryManager.cartRepository.getItemCart();
      listOrder(res!.data!.lineItems!);
      listUsedCombo(res.data!.usedCombos!);
      res.data!.lineItems!.forEach((element) {
        listQuantityProductNew.add(element.quantity!);
      });
      comboDiscountAmount.value = res.data!.comboDiscountAmount!;
      listQuantityProduct(listQuantityProductNew as List<int>);
      totalMoneyAfterDiscount.value = res.data!.totalAfterDiscount!;
      totalBeforeDiscount.value = res.data!.totalBeforeDiscount!;
      productDiscountAmount.value = res.data!.productDiscountAmount!;
      getComboCustomer();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addVoucherCart(String codeVoucher) async {
    List<int> listQuantityProductNew = [];
    voucherDiscountAmount.value = 0.0;
    try {
      var res = await CustomerRepositoryManager.cartRepository
          .addVoucherCart(codeVoucher);
      listOrder(res!.data!.lineItems!);
      listUsedCombo(res.data!.usedCombos!);
      res.data!.lineItems!.forEach((element) {
        listQuantityProductNew.add(element.quantity!);
      });
      listQuantityProduct(listQuantityProductNew as List<int>);
      comboDiscountAmount.value = res.data!.comboDiscountAmount!;
      totalMoneyAfterDiscount.value = res.data!.totalAfterDiscount!;
      totalBeforeDiscount.value = res.data!.totalBeforeDiscount!;
      productDiscountAmount.value = res.data!.productDiscountAmount!;
      voucherDiscountAmount.value = res.data!.voucherDiscountAmount!;
      getComboCustomer();
    } catch (err) {
      // SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateItemCart(int? idProduct, int quantity,
      List<DistributesSelected> listDistributes) async {
    List<int> listQuantityProductNew = [];
    try {
      var res = await CustomerRepositoryManager.cartRepository
          .updateItemCart(idProduct, quantity, listDistributes);
      listOrder(res!.data!.lineItems!);
      listUsedCombo(res.data!.usedCombos!);
      res.data!.lineItems!.forEach((element) {
        listQuantityProductNew.add(element.quantity!);
      });
      listQuantityProduct(listQuantityProductNew as List<int>);
      comboDiscountAmount.value = res.data!.comboDiscountAmount!;
      totalMoneyAfterDiscount.value = res.data!.totalAfterDiscount!;
      totalBeforeDiscount.value = res.data!.totalBeforeDiscount!;
      productDiscountAmount.value = res.data!.productDiscountAmount!;
      getComboCustomer();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addItemCart(int? idProduct) async {
    List<int> listQuantityProductNew = [];
    try {
      var res = await CustomerRepositoryManager.cartRepository
          .addItemCart(idProduct, []);
      listOrder(res!.data!.lineItems!);
      listUsedCombo(res.data!.usedCombos!);
      res.data!.lineItems!.forEach((element) {
        listQuantityProductNew.add(element.quantity!);
      });
      listQuantityProduct(listQuantityProductNew as List<int>);
      comboDiscountAmount.value = res.data!.comboDiscountAmount!;
      totalMoneyAfterDiscount.value = res.data!.totalAfterDiscount!;
      totalBeforeDiscount.value = res.data!.totalBeforeDiscount!;
      productDiscountAmount.value = res.data!.productDiscountAmount!;
      getComboCustomer();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
