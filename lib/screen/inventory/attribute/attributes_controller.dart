import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/attributes.dart';

class AttributeController extends GetxController {
  var loading = false.obs;
  var listAttribute = RxList<Attribute>();

  AttributeController() {
    getAllAttribute();
  }

  Future<void> getAllAttribute() async {
    loading.value = true;
    try {
      var list = await RepositoryManager.attributesRepository.getAllAttributes();
      listAttribute(list);

      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }
}
