import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/product.dart';

class SearchController extends GetxController {
  Product productRequest = new Product();
  var listCategory = RxList<Category>();
  var listCategorySelected = RxList<Category>();
  var isLoadingAdd = false.obs;
  var isLoadingCategory = false.obs;
  var listSelected = RxList<Map<int, bool>>();

  Future<void> getAllCategory() async {
    isLoadingCategory.value = true;
    try {
      var list =
          await CustomerRepositoryManager.categoryRepository.getAllCategory();
      listCategory(list);
      listCategory.forEach((cate) {
        listSelected.value.add({cate.id: false});
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCategory.value = false;
  }
}
