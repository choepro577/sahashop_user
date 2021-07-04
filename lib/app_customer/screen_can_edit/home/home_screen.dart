import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';

import '../repository_widget_config.dart';

class HomeScreen extends StatelessWidget {
  ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (configController.configApp.homePageType != null &&
        configController.configApp.homePageType! <
            RepositoryWidgetCustomer().LIST_HOME_SCREEN.length) {
      return RepositoryWidgetCustomer()
          .LIST_HOME_SCREEN[configController.configApp.homePageType!];
    } else {
      return RepositoryWidgetCustomer().LIST_HOME_SCREEN[0];
    }
  }
}
