import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/data/remote/response-request/combo_request.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/utils/user_info.dart';

class UpdateProductComboController extends GetxController {
  var listProduct = RxList<Product>();
  var isLoadingProduct = false.obs;
  var listIsSave = RxList<bool>().obs;
  var listCheckSelectedProduct = RxList<Map<Product, bool>>().obs;
  var listSelectedProductParam = RxList<ComboProduct>().obs;
  var listSelectedProduct = RxList<Product>().obs;
  var quantityProductSelected = 0.obs;
  var isLoadingCreate = false.obs;
  var listCheckHasInDiscount = RxList<bool>().obs;
  var listProductHasInDiscount = RxList<Product>().obs;

  Future<List<Product>> getAllProduct(
      {String search,
      String idCategory,
      bool descending,
      String details,
      String sortBy}) async {
    isLoadingProduct.value = true;
    try {
      var res = await SahaServiceManager().service.getAllProduct(
          UserInfo().getCurrentStoreCode(),
          search ?? "",
          idCategory ?? "",
          descending ?? false,
          details ?? "",
          sortBy ?? "");

      listProduct.addAll(res.data.data);

      if (listCheckSelectedProduct.value.length == 0) {
        listProduct.forEach((product) {
          listCheckSelectedProduct.value.add({product: false});
          listCheckHasInDiscount.value.add(false);
          listIsSave.value.add(false);
        });
      }

      for (int i = 0; i < listProduct.length; i++) {
        if (res.data.data[i].hasInCombo == true) {
          listIsSave.value[i] = true;
        }

        for (int j = 0; j < listProductHasInDiscount.value.length; j++) {
          if (listProduct[i].id == listProductHasInDiscount.value[j].id) {
            listCheckSelectedProduct.value[i].update(
                listCheckSelectedProduct.value[i].keys.first, (value) => true);
            listCheckHasInDiscount.value[i] = true;
            listIsSave.value[i] = false;
            break;
          }
        }
      }

      isLoadingProduct.value = false;
      return res.data.data;
    } catch (err) {
      handleError(err);
    }
    isLoadingProduct.value = false;
  }

  void onChangeCheckbox(int index) {
    listCheckSelectedProduct.value[index].update(
        listCheckSelectedProduct.value[index].keys.first,
        (value) => !listCheckSelectedProduct.value[index].values.first);
    listCheckSelectedProduct.refresh();
  }

  void checkSelectedProduct() {
    if (listSelectedProduct.value.length == 0) {
      listCheckSelectedProduct.value.forEach((e) {
        if (e.values.first == true) {
          listSelectedProduct.value.add(e.keys.first);
        }
      });
    } else {
      for (int i = 0; i < listCheckSelectedProduct.value.length; i++) {
        if (listCheckSelectedProduct.value[i].values.first == true) {
          print(listCheckSelectedProduct.value.length);
          bool isSame = false;
          for (int j = 0; j < listSelectedProduct.value.length; j++) {
            if (listCheckSelectedProduct.value[i].keys.first.id ==
                listSelectedProduct.value[j].id) {
              isSame = true;
            }
          }
          if (isSame == true) {
          } else {
            listSelectedProduct.value
                .add(listCheckSelectedProduct.value[i].keys.first);
          }
        } else {
          listSelectedProduct.value.removeWhere((element) =>
              element.id == listCheckSelectedProduct.value[i].keys.first.id);
          listSelectedProductParam.value.removeWhere((element) =>
              element.productId ==
              listCheckSelectedProduct.value[i].keys.first.id);
        }
      }
    }
  }

  void resetListProduct() {
    listProduct = new RxList<Product>();
  }

  void deleteProductSelected(int id) {
    listSelectedProduct.value.removeWhere((element) => element.id == id);
    listSelectedProductParam.value
        .removeWhere((element) => element.productId == id);
    listCheckSelectedProduct.value[listCheckSelectedProduct.value
            .indexWhere((e) => e.keys.first.id == id)]
        .update(
            listCheckSelectedProduct
                .value[listCheckSelectedProduct.value
                    .indexWhere((e) => e.keys.first.id == id)]
                .keys
                .first,
            (value) => !listCheckSelectedProduct
                .value[listCheckSelectedProduct.value
                    .indexWhere((e) => e.keys.first.id == id)]
                .values
                .first);
    checkIsSaveProduct();
  }

  void checkIsSaveProduct() {
    for (int i = 0; i < listCheckSelectedProduct.value.length; i++) {
      if (listCheckSelectedProduct.value[i].values.first == true) {
        listIsSave.value[i] = true;
      } else {
        listIsSave.value[i] = false;
      }
    }
  }

  void countProductSelected() {
    quantityProductSelected.value = 0;
    for (int i = 0; i < listCheckSelectedProduct.value.length; i++) {
      if (listCheckSelectedProduct.value[i].values.first == true) {
        quantityProductSelected.value = quantityProductSelected.value + 1;
      }
    }
  }

  void listSelectedProductToComboProduct() {
    listSelectedProduct.value.forEach((element) {
      int indexSame = listSelectedProductParam.value
          .indexWhere((e) => e.productId == element.id);

      if (indexSame == -1) {
        listSelectedProductParam.value
            .add(ComboProduct(productId: element.id, quantity: 1));
      }
    });
    print(listSelectedProductParam);
  }

  void increaseAmountProductCombo(int index) {
    listSelectedProductParam.value[index].quantity++;
    listSelectedProductParam.refresh();
    print(listSelectedProductParam.value[0].quantity);
  }

  void decreaseAmountProductCombo(int index) {
    if (listSelectedProductParam.value[index].quantity > 1) {
      listSelectedProductParam.value[index].quantity--;
      listSelectedProductParam.refresh();
      print(listSelectedProductParam.value[0].quantity);
    }
  }
}
