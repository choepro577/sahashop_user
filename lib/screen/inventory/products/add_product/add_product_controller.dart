import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/response-request/product/product_request.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/attributes.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/product.dart';

import 'widget/select_images_controller.dart';

class AddProductController extends GetxController {
  ProductRequest productRequest = new ProductRequest();
  var listCategory = RxList<Category>();
  var listCategorySelected = RxList<Category>();
  var listAttribute = RxList<String>();
  var isLoadingAdd = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingAttribute = false.obs;

  var listDistribute = RxList<DistributesRequest>();

  List<ImageData>? listImages;
  var uploadingImages = false.obs;

  var attributeData = {}.obs;

  AddProductController() {
    getAllCategory();
    getAllAttribute();
  }

  Future<bool?> getAllAttribute() async {
    isLoadingAttribute.value = true;
    try {
      var list =
          await RepositoryManager.attributesRepository.getAllAttributes();
      listAttribute(list!);

      isLoadingAttribute.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAttribute.value = false;
  }

  void setNewListDistribute(List<DistributesRequest> list) {
    List<DistributesRequest> listOK = [];
    listOK = list.where((element) =>
        element.name != null &&
        element.elementDistributes != null &&
        element.elementDistributes!.length > 0).toList();

    listDistribute(listOK);
    refresh();
  }

  void setNewListAttribute(List<String> list) {
    listAttribute(list);
    list.forEach((element) {
      if (!attributeData.keys.contains(element)) {
        attributeData.remove(element);
      }
    });
  }

  void addValueToMapAttribute(String key, String value) {
    attributeData["key"] = value;
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

  Future<bool?> getAllCategory() async {
    isLoadingCategory.value = true;
    try {
      var list = await RepositoryManager.categoryRepository.getAllCategory();
      listCategory(list!);

      isLoadingCategory.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCategory.value = false;
  }

  Future<bool?> createProduct() async {
    isLoadingAdd.value = true;
    productRequest.categories =
        listCategorySelected.map((element) => element.id).toList();
    productRequest.images = listImages == null
        ? []
        : listImages!.map((e) => ImageProduct(imageUrl: e.linkImage)).toList() as List<String>?;

    try {
      var data =
          await RepositoryManager.productRepository.create(productRequest);

      SahaAlert.showSuccess(message: "Thêm thành công");
      Navigator.pop(Get.context!, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }
}
