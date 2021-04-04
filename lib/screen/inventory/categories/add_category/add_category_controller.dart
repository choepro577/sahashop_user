import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/product/product_request.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/utils/user_info.dart';

class AddCategoryController extends GetxController {
  ProductRequest productRequest = new ProductRequest();
  var isLoadingAdd = false.obs;

  String name;
  File image;

  Future<void> createCategory() async {
    isLoadingAdd.value = true;
    try {
      var data = await RepositoryManager.categoryRepository
          .createCategory(name, image);

      SahaAlert.showSuccess(message: "Thêm thành công");
      Navigator.pop(Get.context, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }
}
