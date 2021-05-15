import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/data_widget_config.dart';
import 'package:sahashop_user/components/saha_user/carousel/carousel_select.dart';
import 'package:sahashop_user/controller/config_controller.dart';

class SearchBarConfig extends StatelessWidget {
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          height: 100,
          listWidget: LIST_WIDGET_SEARCH_BAR,
          indexSelected: configController.configApp.searchType,
          initPage: configController.configApp.searchType,
          onSelected: (index) {
            configController.configApp.searchType = index;
          },
        )
      ],
    );
  }
}
