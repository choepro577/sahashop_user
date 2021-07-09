import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';

import '../repository_widget_config.dart';

// ignore: must_be_immutable
class BannerWidget extends StatelessWidget {
  ConfigController configController = Get.find();
  @override
  Widget build(BuildContext context) {
    if (configController.configApp.carouselType != null &&
        configController.configApp.carouselType! <
            RepositoryWidgetCustomer().LIST_WIDGET_BANNER.length) {
      return RepositoryWidgetCustomer()
          .LIST_WIDGET_BANNER[configController.configApp.carouselType!];
    } else {
      return RepositoryWidgetCustomer().LIST_WIDGET_BANNER[0];
    }
  }
}
