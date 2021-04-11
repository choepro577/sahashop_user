import 'package:flutter/cupertino.dart';
import 'package:sahashop_user/components/data_app_customer/data_widget_config.dart';
import 'package:sahashop_user/components/saha_user/carousel/carousel_select.dart';

class ListCategoryConfig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          height: 150,
          listWidget: LIST_WIDGET_LIST_CATEGORY,
          indexSelected: 1,
          initPage: 1,
        )
      ],
    );
  }
}
