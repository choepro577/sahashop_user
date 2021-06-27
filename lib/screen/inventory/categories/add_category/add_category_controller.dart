import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';

import 'package:sahashop_user/utils/image_utils.dart';

class AddCategoryController extends GetxController {
  var isLoadingAdd = false.obs;

  Category? category;

  String? name;
  File? image;

  final TextEditingController textEditingControllerName =
      new TextEditingController();

  AddCategoryController({this.category});

  Future<bool?> createCategory({int? categoryId, String? imageUrl}) async {
    isLoadingAdd.value = true;
    try {
      var imageUp;

      if (image != null) {
        imageUp = await ImageUtils.getImageCompress(image!);
      }

      if (categoryId == null) {
        var data = await RepositoryManager.categoryRepository
            .createCategory(textEditingControllerName.text, imageUp);
      } else {
        var data = await RepositoryManager.categoryRepository.updateCategory(
            textEditingControllerName.text, categoryId, imageUrl, imageUp);
      }

      SahaAlert.showSuccess(message: "Thêm thành công");
      Navigator.pop(Get.context!, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }
}
