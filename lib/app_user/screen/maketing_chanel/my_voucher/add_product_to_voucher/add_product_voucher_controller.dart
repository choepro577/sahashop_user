import 'package:get/get.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/model/product.dart';

class AddProductToVoucherController extends GetxController {
  var listProduct = RxList<Product>();
  var isLoadingProduct = false.obs;
  var listIsSave = RxList<bool>();
  var listCheckSelectedProduct = RxList<Map<Product, bool>>();
  var listSelectedProduct = RxList<Product>();
  var quantityProductSelected = 0.obs;
  var isLoadingCreate = false.obs;
  var listProductParam = "";
  var isLoadMore = false.obs;
  var isEndProduct = false.obs;
  var currentPage = 1;
  var isLoadInit = false.obs;
  var isSearch = false.obs;
  List<Product>? listProductInput = [];
  String? textSearch;

  Future<List<Product>?> getAllProduct(
      {String? textSearch, bool? isRefresh}) async {
    if (isRefresh == true) {
      isLoadingProduct.value = true;
    } else {
      isLoadMore.value = true;
    }

    try {
      if (isEndProduct.value == false) {
        var data = await RepositoryManager.productRepository.getAllProduct(
            page: currentPage, search: textSearch == null ? "" : textSearch);
        var list = data!.data;

        if (isRefresh == true) {
          listProduct(list!);
          List<Map<Product, bool>> listCheckSelected = [];
          List<bool> listIsSaveNew = [];
          listProduct.forEach((product) {
            listCheckSelected.add({product: false});
            listIsSaveNew.add(false);
          });
          listCheckSelectedProduct(listCheckSelected);
          listIsSave(listIsSaveNew);
          checkProductIsSelected();
        } else {
          listProduct.addAll(list!);
          list.forEach((product) {
            listCheckSelectedProduct.add({product: false});
            listIsSave.add(false);
          });
          checkProductIsSelected();
        }

        if (data.nextPageUrl == null) {
          isEndProduct.value = true;
        } else {
          currentPage++;
        }

        isLoadingProduct.value = false;
        isLoadMore.value = false;
        return list;
      } else {
        isLoadMore.value = false;
      }
    } catch (err) {
      handleError(err);
    }
    isLoadingProduct.value = false;
  }

  void checkTest() {
    listCheckSelectedProduct.forEach((e) {
      if (e.values.first == true) {
        listSelectedProduct.add(e.keys.first);
      }
    });
  }

  void checkSelectedProduct() {
    if (listSelectedProduct.length == 0) {
      listCheckSelectedProduct.forEach((e) {
        if (e.values.first == true) {
          listSelectedProduct.add(e.keys.first);
        }
      });
    } else {
      for (int i = 0; i < listCheckSelectedProduct.length; i++) {
        if (listCheckSelectedProduct[i].values.first == true) {
          print(listCheckSelectedProduct.length);
          bool isSame = false;
          for (int j = 0; j < listSelectedProduct.length; j++) {
            if (listCheckSelectedProduct[i].keys.first.id ==
                listSelectedProduct[j].id) {
              isSame = true;
            }
          }
          if (isSame == true) {
          } else {
            listSelectedProduct.add(listCheckSelectedProduct[i].keys.first);
          }
        } else {
          listSelectedProduct.removeWhere((element) =>
              element.id == listCheckSelectedProduct[i].keys.first.id);
        }
      }
    }
  }

  void resetListProduct() {
    currentPage = 1;
    isEndProduct.value = false;
    listProductParam = "";
  }

  void checkProductIsSelected() {
    for (int i = 0; i < listProductInput!.length; i++) {
      var check = listProduct
          .indexWhere((product) => product.id == listProductInput![i].id);
      if (check != -1) {
        listIsSave[check] = true;
      }
    }
  }

  void countProductSelected() {
    quantityProductSelected.value = 0;
    for (int i = 0; i < listCheckSelectedProduct.length; i++) {
      if (listCheckSelectedProduct[i].values.first == true) {
        quantityProductSelected.value = quantityProductSelected.value + 1;
      }
    }
  }
}
