import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/model/category_post.dart';
import 'package:sahashop_user/app_user/model/product.dart';
import 'package:sahashop_user/app_user/utils/image_utils.dart';

class AddPostController extends GetxController {
  Product productRequest = new Product();
  var isLoadingAdd = false.obs;
  var isLoadingCategory = false.obs;
  RxList<CategoryPost> listCategory = new RxList<CategoryPost>();
  var postSelected = CategoryPost().obs;

  String? title;
  File? image;
  var content = "".obs;
  String? summary;
  bool? published;
  int? categoryId;


  AddPostController() {
    getAllCategory();
  }

  Future<bool?> createPost() async {
    isLoadingAdd.value = true;
    try {
      var imageUp;
      if (image != null) {
        imageUp = await ImageUtils.getImageCompress(image!);
      }
      var data = await RepositoryManager.postRepository.createPost(
          title: title,
          image: imageUp,
          summary: summary,
          published: published,
          categoryId: categoryId,
          content: content.value);

      SahaAlert.showSuccess(message: "Thêm thành công");
      Navigator.pop(Get.context!, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }

  Future<void> getAllCategory() async {
    listCategory([]);
    isLoadingCategory.value = true;
    try {
      var list = await RepositoryManager.postRepository.getAllCategoryPost();
      listCategory(list!);

      isLoadingCategory.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCategory.value = false;
  }
}
