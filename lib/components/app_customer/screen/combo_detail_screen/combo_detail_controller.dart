import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/model/combo.dart';

class ComboDetailController extends GetxController {
  var listProductCombo = RxList<ProductsCombo>();
  var listQuantityProductNeedBuy = RxList<int?>();
  var discountComboType = 0.obs;
  var valueComboType = 0.0.obs;
  var hadEnough = false.obs;
  int? idProduct;

  DataAppCustomerController dataAppCustomerController = Get.find();

  ComboDetailController({this.idProduct}) {
    getComboCustomer();
    dataAppCustomerController.listOrder.forEach((e) {
      var checkHasInCombo = listProductCombo
          .indexWhere((element) => element.product!.id == e.product!.id);
      if (checkHasInCombo != -1) {
        listQuantityProductNeedBuy[checkHasInCombo] =
            listQuantityProductNeedBuy[checkHasInCombo]! - e.quantity!;
      }
    });
    checkProductInCombo();
  }

  void checkProductInCombo() {
    dataAppCustomerController.listOrder.listen(
      (v) {
        if (dataAppCustomerController.listOrder.length == 0) {
          for (int i = 0; i < listProductCombo.length; i++) {
            listQuantityProductNeedBuy[i] = listProductCombo[i].quantity;
          }
        } else {
          if (dataAppCustomerController.listOrder.length >=
              listProductCombo.length) {
            dataAppCustomerController.listOrder.forEach((e) {
              var checkHasInCombo = listProductCombo
                  .indexWhere((element) => element.product!.id == e.product!.id);
              if (checkHasInCombo != -1) {
                if (listProductCombo[checkHasInCombo].quantity! >= e.quantity!) {
                  listQuantityProductNeedBuy[checkHasInCombo] =
                      listProductCombo[checkHasInCombo].quantity! - e.quantity!;
                }
              }
            });
          } else {
            for (int i = 0; i < listProductCombo.length; i++) {
              var checkHasInCombo = dataAppCustomerController.listOrder
                  .indexWhere((element) =>
                      element.product!.id == listProductCombo[i].product!.id);
              if (checkHasInCombo != -1) {
                if (listProductCombo[i].quantity! >=
                    dataAppCustomerController
                        .listOrder[checkHasInCombo].quantity!) {
                  listQuantityProductNeedBuy[i] = listProductCombo[i].quantity! -
                      dataAppCustomerController
                          .listOrder[checkHasInCombo].quantity!;
                }
              } else {
                listQuantityProductNeedBuy[i] = listProductCombo[i].quantity;
              }
            }
          }
        }

        for (int i = 0; i < listQuantityProductNeedBuy.length; i++) {
          if (listQuantityProductNeedBuy[i] != 0) {
            hadEnough.value = false;
            break;
          } else {
            hadEnough.value = true;
          }
        }
      },
    );
  }

  Future<void> getComboCustomer() async {
    try {
      var res = await CustomerRepositoryManager.marketingRepository
          .getComboCustomer();
      res!.data!.forEach((e) {
        int checkHasInCombo = e.productsCombo!
            .indexWhere((element) => element.product!.id == idProduct);
        if (checkHasInCombo != -1) {
          listProductCombo(e.productsCombo!);
          discountComboType.value = e.discountType!;
          valueComboType.value = e.valueDiscount!.toDouble();
          listProductCombo.forEach((element) {
            listQuantityProductNeedBuy.add(element.quantity);
          });

          dataAppCustomerController.listOrder.forEach((e) {
            var checkHasInCombos = listProductCombo
                .indexWhere((element) => element.product!.id == e.product!.id);
            if (checkHasInCombos != -1) {
              if (listProductCombo[checkHasInCombos].quantity! >= e.quantity!) {
                listQuantityProductNeedBuy[checkHasInCombos] =
                    listProductCombo[checkHasInCombos].quantity! - e.quantity!;
              } else {
                listQuantityProductNeedBuy[checkHasInCombos] = 0;
              }
            }
          });
        }
      });

      for (int i = 0; i < listQuantityProductNeedBuy.length; i++) {
        if (listQuantityProductNeedBuy[i] != 0) {
          hadEnough.value = false;
          break;
        } else {
          hadEnough.value = true;
        }
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
