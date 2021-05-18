import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/utils/user_info.dart';

class UpdateProductVoucherController extends GetxController {
  var listProduct = RxList<Product>();
  var isLoadingProduct = false.obs;
  var listIsSave = RxList<bool>().obs;
  var listCheckHasInDiscount = RxList<bool>().obs;
  var listCheckSelectedProduct = RxList<Map<Product, bool>>().obs;
  var listSelectedProduct = RxList<Product>().obs;
  var listProductHasInDiscount = RxList<Product>().obs;
  var quantityProductSelected = 0.obs;
  var isLoadingCreate = false.obs;
  var listProductParam = "";

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
        }
      }
    }
  }

  void resetListProduct() {
    listProduct = new RxList<Product>();
    listProductParam = "";
  }

  void deleteProductSelected(int id) {
    listSelectedProduct.value.removeWhere((element) => element.id == id);
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
    listProductParam = "";
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

  void listSelectedProductToString() {
    if (listProductParam.isEmpty) {
      listSelectedProduct.value.forEach((element) {
        if (element != listSelectedProduct.value.last) {
          listProductParam = listProductParam + "${element.id.toString()},";
        } else {
          listProductParam = listProductParam + "${element.id.toString()}";
        }
      });
    }
    print(listProductParam);
  }

  Future<void> createDiscount(
    String name,
    String description,
    String imageUrl,
    String startTime,
    String endTime,
    int value,
    bool setLimitedAmount,
    int amount,
    String listIdProduct,
  ) async {
    isLoadingCreate.value = true;
    try {
      var data = await RepositoryManager.marketingChanel.createDiscount(
          name,
          description,
          imageUrl,
          startTime,
          endTime,
          value,
          setLimitedAmount,
          amount,
          listIdProduct);
      SahaAlert.showSuccess(message: "Lưu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
    listProductParam = "";
  }
}
