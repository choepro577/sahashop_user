import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/product.dart';

import 'widget/select_images_controller.dart';

class AddProductController extends GetxController {
  Product productRequest = new Product();
  var listCategory = RxList<Category>();
  var listCategorySelected = RxList<Category>();
  var isLoadingAdd = false.obs;
  var isLoadingCategory = false.obs;

  List<ImageData> listImages;
  var uploadingImages = false.obs;

  AddProductController() {
    getAllCategory();
  }

  void setUploadingImages(bool value) {
    uploadingImages.value = value;
  }

  void onChoose(List<Category> list) {
    listCategorySelected(list);
  }

  void onRemoveItem(Category category) {
    listCategorySelected.remove(category);
  }

  Future<void> getAllCategory() async {
    isLoadingCategory.value = true;
    try {
      var list = await RepositoryManager.categoryRepository.getAllCategory();
      listCategory(list);

      isLoadingCategory.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCategory.value = false;
  }

  Future<void> createProduct() async {
    isLoadingAdd.value = true;
    productRequest.categories =
        listCategorySelected.toList();
    productRequest.images =
        listImages == null ? [] : listImages.map((e) => e.linkImage).toList();

    try {
      var data =
          await RepositoryManager.productRepository.create(productRequest);

      SahaAlert.showSuccess(message: "Thêm thành công");
      Navigator.pop(Get.context, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }
}
