import 'package:get/get.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/model/product.dart';

class ProductPickerController extends GetxController {
  var listProduct = RxList<Product>();
  var isLoadingProduct = false.obs;
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

          listProduct.forEach((product) {
            listCheckSelected.add({product: false});
          });
          listCheckSelectedProduct(listCheckSelected);

        } else {
          listProduct.addAll(list!);
          list.forEach((product) {
            listCheckSelectedProduct.add({product: false});
          });
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


  void resetListProduct() {
    currentPage = 1;
    isEndProduct.value = false;
    listProductParam = "";
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
