import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/repository_widget_config.dart';
import 'package:sahashop_user/app_user/components/saha_user/carousel/carousel_select.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';

class ProductScreenConfig extends StatelessWidget {
  final ConfigController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          listWidget:  RepositoryWidgetCustomer().LIST_PRODUCT_SCREEN,
          height: Get.height * 0.6,
          indexSelected: controller.configApp.productPageType,
          initPage: controller.configApp.productPageType,
          onChange: (index) {
            controller.configApp.productPageType = index;
          },
        )
      ],
    );
  }
}
