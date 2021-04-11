import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/data_app_customer/data_widget_config.dart';
import 'package:sahashop_user/components/saha_user/carousel/carousel_select.dart';

import '../../config_controller.dart';

class CategoryProductConfig extends StatelessWidget {
  final ConfigController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          height: 400,
          listWidget: LIST_WIDGET_CATEGORY_PRODUCT,
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
