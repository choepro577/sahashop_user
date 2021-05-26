import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/data_widget_config.dart';
import 'package:sahashop_user/components/app_customer/screen/profile_screen/profile_screen.dart';
import 'package:sahashop_user/controller/config_controller.dart';

class NavigationController extends GetxController {
  var selectedIndexBottomBar = 1.obs;
  ConfigController configController;
  List<Widget> navigationHome = [];

  NavigationController() {
    configController = Get.find();
    if (configController.configApp?.homePageType != null &&
        configController.configApp.homePageType <
            LIST_WIDGET_HOME_SCREEN.length) {
      navigationHome = [
        LIST_WIDGET_HOME_SCREEN[configController.configApp.homePageType],
        ProfileScreen(),
      ];
    } else {
      navigationHome = [LIST_WIDGET_HOME_SCREEN[0]];
    }
  }
}
