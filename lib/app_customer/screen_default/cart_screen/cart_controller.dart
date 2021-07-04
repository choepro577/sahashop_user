import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/app_customer/screen_default/login/login_screen.dart';
import 'package:sahashop_user/app_customer/utils/customer_info.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/cart.dart';
import 'package:sahashop_user/app_user/model/combo.dart';
import 'package:sahashop_user/app_user/model/order.dart';

import '../data_app_controller.dart';

class CartController extends GetxController {
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
      //Get.back();
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
      //dataAppCustomerController.getBadge();
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
      // dataAppCustomerController.getBadge();
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
      // dataAppCustomerController.getBadge();
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
      // dataAppCustomerController.getBadge();
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
      //  dataAppCustomerController.getBadge();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
