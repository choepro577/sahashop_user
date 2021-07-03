import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen/repository_widget_config.dart';
import 'package:sahashop_user/app_user/components/saha_user/carousel/carousel_select.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';

class HomeScreenConfig extends StatelessWidget {
  final ConfigController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          listWidget:  RepositoryWidgetCustomer().LIST_WIDGET_HOME_SCREEN,
          height: Get.height * 0.6,
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