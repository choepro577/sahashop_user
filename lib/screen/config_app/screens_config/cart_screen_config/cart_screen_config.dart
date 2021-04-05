import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/config_app/data_widget_config.dart';
import 'package:sahashop_user/components/saha_user/carousel/carousel_select.dart';

import '../../config_controller.dart';

class CartSceenConfig extends StatelessWidget {
  final ConfigController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        CarouselSelect(
          height: 400,
          listWidget: LIST_WIDGET_CART_SCREEN,
          indexSelected: controller.configApp.cartPageType,
          initPage: controller.configApp.cartPageType,
          onChange: (index) {
            controller.configApp.cartPageType = index;
          },
        )
      ],
    );
  }
}
