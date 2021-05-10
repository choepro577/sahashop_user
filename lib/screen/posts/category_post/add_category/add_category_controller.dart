import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/utils/image_utils.dart';

class AddCategoryPostController extends GetxController {
  Product productRequest = new Product();
  var isLoadingAdd = false.obs;

  String title;
  File image;
  String description;

  Future<void> createCategoryPost() async {
    isLoadingAdd.value = true;
    try {
      var imageUp = await ImageUtils.getImageCompress(image);
      var data = await RepositoryManager.postRepository.createCategoryPost(
          title: title, image: imageUp, description: description);

      SahaAlert.showSuccess(message: "Thêm thành công");
      Navigator.pop(Get.context, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }
}
