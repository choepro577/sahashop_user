import 'package:get/get.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/utils/user_info.dart';

class AddProductToSaleController extends GetxController {
  var listProduct = RxList<Product>();
  var isLoadingProduct = false.obs;
  var listCheckSelectedProduct = RxList<Map<Product, bool>>().obs;
  var listSelectedProduct = RxList<Product>().obs;

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
        });
      }

      print(listProduct);
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
    //listSelectedProduct.value = new RxList<Product>();
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
  }
}
