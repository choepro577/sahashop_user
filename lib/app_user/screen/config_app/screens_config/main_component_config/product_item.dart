import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen/repository_widget_config.dart';
import 'package:sahashop_user/app_user/components/saha_user/carousel/carousel_select.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';

class ProductItemConfig extends StatelessWidget {
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          height: 200,
          width: 150,
          listWidget:  RepositoryWidgetCustomer().LIST_ITEM_PRODUCT_WIDGET,
          indexSelected: configController.configApp.productItemType,
          initPage: configController.configApp.productItemType,
          onSelected: (index) {
            configController.configApp.productItemType = index;
          },
        )
      ],
    );
  }
}
