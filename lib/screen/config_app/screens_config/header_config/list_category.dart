import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/config_app/data_widget_config.dart';
import 'package:sahashop_user/components/saha_user/carousel/carousel_select.dart';

import '../../config_controller.dart';

class ListCategoryConfig extends StatelessWidget {
  final ConfigController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          height: 150,
          listWidget: LIST_WIDGET_LIST_CATEGORY,
          indexSelected: controller.configApp.categoryPageType,
          initPage: controller.configApp.categoryPageType,
          onSelected: (index) {
            controller.configApp.categoryPageType = index;
          },
        )
      ],
    );
  }
}
