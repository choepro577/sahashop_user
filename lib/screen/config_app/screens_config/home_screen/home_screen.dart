import 'package:flutter/cupertino.dart';
import 'package:sahashop_user/components/config_app/data_widget_config.dart';
import 'package:sahashop_user/components/saha_user/carousel/carousel_select.dart';

class HomeScreenConfig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          listWidget: LIST_WIDGET_HOME_SCREEN,
          indexSelected: 1,
          initPage: 1,
        )
      ],
    );
  }
}
