import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/repository_widget_config.dart';
import 'package:sahashop_user/app_user/components/saha_user/carousel/carousel_select.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';

class HomeScreenConfig extends StatelessWidget {
  final ConfigController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          listWidget:  RepositoryWidgetCustomer().LIST_HOME_SCREEN,
          height: Get.height * 0.5,
          indexSelected: controller.configApp.homePageType,
          initPage: controller.configApp.homePageType,
          onChange: (index) {
            controller.configApp.homePageType = index;
          },
        )
      ],
    );
  }
}
