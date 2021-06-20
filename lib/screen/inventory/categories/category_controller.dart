import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/category.dart';

class CategoryController extends GetxController {
  var loading = false.obs;
  var listCategory = RxList<Category>();

  CategoryController() {
    getAllCategory();
  }

  Future<bool?> getAllCategory() async {
    loading.value = true;
    try {
      var list = await RepositoryManager.categoryRepository.getAllCategory();
      listCategory(list!);

      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }
}
