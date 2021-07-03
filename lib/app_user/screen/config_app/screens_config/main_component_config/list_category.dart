import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen/repository_widget_config.dart';
import 'package:sahashop_user/app_user/components/saha_user/carousel/carousel_select.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';

class ListCategoryConfig extends StatelessWidget {
  final ConfigController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          height: 150,
          listWidget:  RepositoryWidgetCustomer().LIST_WIDGET_LIST_CATEGORY,
          indexSelected: controller.configApp.categoryPageType,
          initPage: controller.configApp.categoryPageType,
          onSelected: (index) {
            controller.configApp.categoryPageType = index;
            print(
                "-----------------------------${controller.configApp.categoryPageType}");
          },
        )
      ],
    );
  }
}