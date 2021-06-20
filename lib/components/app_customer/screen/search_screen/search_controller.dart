import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/product.dart';

class SearchController extends GetxController {
  var listCategory = RxList<Category>();
  var listCategorySelected = RxList<Map<String, bool>>();
  var isLoadingAdd = false.obs;
  var isLoadingCategory = false.obs;
  var sizeSearch = "";
  var selectedCategoryParam = "";

  Future<void> getAllCategory() async {
    isLoadingCategory.value = true;
    try {
      var list =
          await CustomerRepositoryManager.categoryRepository.getAllCategory();
      listCategory(list!);
      listCategory.forEach((cate) {
        listCategorySelected.add({cate.id.toString(): false});
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCategory.value = false;
  }

  void checkIsSelectedCategory() {
    selectedCategoryParam = "";

    listCategorySelected.forEach((cate) {
      if (cate.values.first == true) {
        selectedCategoryParam = selectedCategoryParam + cate.keys.first + ",";
      }
    });
    print("---------$selectedCategoryParam");
  }

  var listProduct = RxList<Product>();
  var isLoadingProduct = false.obs;
  Future<bool?> searchProduct(
      String search, bool descending, String sortBy) async {
    isLoadingProduct.value = true;
    checkIsSelectedCategory();
    try {
      var list = (await CustomerRepositoryManager.productCustomerRepository
          .searchProduct(
              search: search,
              idCategory: selectedCategoryParam,
              descending: descending,
              details: sizeSearch,
              sortBy: sortBy))!;
      listProduct.value = list;
      print(listProduct.length);
      isLoadingProduct.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingProduct.value = false;
  }
}
