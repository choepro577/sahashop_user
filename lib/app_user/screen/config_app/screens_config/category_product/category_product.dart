import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/repository_widget_config.dart';
import 'package:sahashop_user/app_user/components/saha_user/carousel/carousel_select.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';


class CategoryProductConfig extends StatelessWidget {
  final ConfigController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          height: Get.height*0.5,
          listWidget:  RepositoryWidgetCustomer().LIST_CATEGORY_PRODUCT_SCREEN,
          indexSelected: controller.configApp.categoryPageType,
          initPage: controller.configApp.categoryPageType,
          onChange: (index) {
            controller.configApp.categoryPageType = index;
          },
        )
      ],
    );
  }
}
