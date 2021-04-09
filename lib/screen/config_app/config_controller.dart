import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/utils/user_info.dart';

import '../../model/config_app.dart';

class ConfigController extends GetxController {
  ConfigApp configApp = ConfigApp();

  var isLoadingAdd = false.obs;
  var isLoadingCategory = false.obs;

  ConfigController() {
    configApp.userId = UserInfo().getCurrentIdUser();

    configApp.colorMain1 = "b74093";

    configApp.searchType = 1;

    configApp.homeIdCarouselAppImage = 1;

    configApp.typeOfMenu = 1;

    configApp.categoryPageType = 1;

    configApp.productPageType = 1;

    configApp.cartPageType = 1;
  }

  Future<void> createAppTheme() async {
    isLoadingAdd.value = true;
    try {
      var data =
          await RepositoryManager.configUiRepository.createAppTheme(configApp);

      SahaAlert.showSuccess(message: "Thêm thành công");
      // Navigator.pop(Get.context, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }
}
