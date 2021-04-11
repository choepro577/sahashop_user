import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/data_app_customer/data_widget_config.dart';
import 'package:sahashop_user/components/saha_user/carousel/carousel_select.dart';

import '../../config_controller.dart';

class HomeScreenConfig extends StatelessWidget {
  final ConfigController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          listWidget: LIST_WIDGET_HOME_SCREEN,
          height: Get.height * 0.6,
          indexSelected: controller.configApp.typeOfMenu,
          initPage: controller.configApp.typeOfMenu,
          onChange: (index) {
            controller.configApp.typeOfMenu = index;
          },
        )
      ],
    );
  }
}
