import 'package:flutter/cupertino.dart';
import 'package:sahashop_user/components/config_app/data_widget_config.dart';
import 'package:sahashop_user/components/saha_user/carousel/carousel_select.dart';

class SearchBarConfig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          height: 100,
          listWidget: LIST_WIDGET_SEARCH_BAR,
          indexSelected: 1,
          initPage: 1,
        )
      ],
    );
  }
}
