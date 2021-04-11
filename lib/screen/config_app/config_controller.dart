import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/screen/config_app/screens_config/font_type/font_data.dart';
import 'package:sahashop_user/utils/color.dart';
import 'package:sahashop_user/utils/user_info.dart';

import '../../model/config_app.dart';

class ConfigController extends GetxController {
  ConfigApp configApp = ConfigApp();
  var currentTheme = ThemeData().obs;

  var isLoadingGet = false.obs;
  var isLoadingCreate = false.obs;

  ConfigController() {
    currentTheme.value = ThemeData(
      primarySwatch: Colors.cyan,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  void updateTheme() {
    currentTheme.value = ThemeData(
      fontFamily: configApp.fontFamily,
        primarySwatch:
            MaterialColor(HexColor.getColorFromHex(configApp.colorMain1), {
      50: HexColor(configApp.colorMain1).withOpacity(0.1),
      100: HexColor(configApp.colorMain1).withOpacity(0.2),
      200: HexColor(configApp.colorMain1).withOpacity(0.3),
      300: HexColor(configApp.colorMain1).withOpacity(0.4),
      400: HexColor(configApp.colorMain1).withOpacity(0.5),
      500: HexColor(configApp.colorMain1).withOpacity(0.6),
      600: HexColor(configApp.colorMain1).withOpacity(0.7),
      700: HexColor(configApp.colorMain1).withOpacity(0.8),
      800: HexColor(configApp.colorMain1).withOpacity(0.9),
      900: HexColor(configApp.colorMain1).withOpacity(1),
    }));
  }

  Future<void> getAppTheme() async {
    isLoadingGet.value = true;
    try {
      var data = await RepositoryManager.configUiRepository.getAppTheme();

      configApp.colorMain1 = data.colorMain1 ?? "#ff93b9b4";



      configApp.fontFamily =
          data.fontFamily != null && FONT_DATA.containsKey(data.fontFamily)
              ? data.fontFamily
              : FONT_DATA.keys.toList()[0];
      configApp.searchType = data.searchType ?? 0;
      configApp.carouselType = data.carouselType ?? 0;
      configApp.homePageType = data.homePageType ?? 0;
      configApp.categoryPageType = data.categoryPageType ?? 0;
      configApp.productPageType = data.productPageType ?? 0;
      configApp.cartPageType = data.cartPageType ?? 0;
      configApp.logoUrl = data.logoUrl ?? "";


      updateTheme();
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
