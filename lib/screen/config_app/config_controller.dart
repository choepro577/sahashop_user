import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/register/register_repository.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/utils/user_info.dart';

import '../../model/config_app.dart';

class ConfigController extends GetxController {
  ConfigApp configApp = ConfigApp();

  var isLoadingGet = false.obs;
  var isLoadingCreate = false.obs;

  ConfigController() {
    getAppTheme();
  }

  Future<void> getAppTheme() async {
    isLoadingGet.value = true;
    try {
      var data = await RepositoryManager.configUiRepository.getAppTheme();
      configApp.userId = UserInfo().getCurrentIdUser();

      configApp.colorMain1 = "b74093" ?? "";

      configApp.searchType = data.searchType ?? 0;

      configApp.homeIdCarouselAppImage = data.homeIdCarouselAppImage ?? 0;

      configApp.typeOfMenu = data.typeOfMenu ?? 0;

      configApp.categoryPageType = data.categoryPageType ?? 0;

      configApp.productPageType = data.productPageType ?? 0;

      configApp.cartPageType = data.cartPageType ?? 0;

      isLoadingGet.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingGet.value = false;
  }

  Future<void> createAppTheme() async {
    isLoadingCreate.value = true;
    try {
      var data =
          await RepositoryManager.configUiRepository.createAppTheme(configApp);

      SahaAlert.showSuccess(message: "Thêm thành công");
      // Navigator.pop(Get.context, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
  }
}
