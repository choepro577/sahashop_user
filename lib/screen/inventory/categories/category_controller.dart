import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/category.dart';

class CategoryController extends GetxController {
  var loading = false.obs;
  var listCategory = RxList<Category>();
  var listCategorySelected = RxList<Category>();

  CategoryController() {
    getAllCategory();
  }

  void selectCategory(Category category) {
    listCategorySelected.refresh();
    if (listCategorySelected
        .map((element) => element.id)
        .toList()
        .contains(category.id)) {
      listCategorySelected.removeWhere((element) => element.id == category.id);
    } else {
      listCategorySelected.add(category);
    }
    listCategorySelected.forEach((element) {
      if (!listCategory.map((e) => e.id).toList().contains(element.id)) {
        listCategorySelected
            .removeWhere((element) => element.id == category.id);
      }
    });
  }

  bool selected(Category category) {
    return listCategorySelected
        .map((element) => element.id)
        .toList()
        .contains(category.id);
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

  Future<bool?> deleteCategory(int categoryId) async {
    try {
      var data =
          await RepositoryManager.categoryRepository.deleteCategory(categoryId);
      listCategory.removeWhere((element) => element.id == categoryId);
      SahaAlert.showSuccess(message: "Đã xóa");
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
