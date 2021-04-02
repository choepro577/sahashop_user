import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/config_app/data_widget_config.dart';
import 'package:sahashop_user/components/saha_user/carousel/carousel_select.dart';
import 'package:sahashop_user/screen/config_app/config_controller.dart';

class SearchBarConfig extends StatelessWidget {
  final ConfigController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          height: 100,
          listWidget: LIST_WIDGET_SEARCH_BAR,
          indexSelected: controller.configApp.searchType,
          initPage: controller.configApp.searchType,
          onChange: (index) {
            controller.configApp.searchType = index;
          },
        )
      ],
    );
  }
}
