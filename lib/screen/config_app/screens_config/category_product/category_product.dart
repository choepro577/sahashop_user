import 'package:flutter/cupertino.dart';
import 'package:sahashop_user/components/config_app/data_widget_config.dart';
import 'package:sahashop_user/components/saha_user/carousel/carousel_select.dart';

class CategoryProductConfig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          height: 400,
          listWidget: LIST_WIDGET_CATEGORY_PRODUCT,
          indexSelected: 1,
          initPage: 1,
        )
      ],
    );
  }
}
