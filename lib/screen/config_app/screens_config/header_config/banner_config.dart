import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/data_app_customer/data_widget_config.dart';
import 'package:sahashop_user/components/saha_user/carousel/carousel_select.dart';
import 'package:sahashop_user/screen/config_app/config_controller.dart';

class BoxPionConfig extends StatelessWidget {
  final ConfigController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        CarouselSelect(
          height: 150,
          listWidget: LIST_WIDGET_BANNER,
          indexSelected: controller.configApp.carouselType,
          initPage: controller.configApp.carouselType,
          onSelected: (index) {
            controller.configApp.carouselType = index;
          },
        )
      ],
    );
  }
}
