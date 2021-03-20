import 'package:flutter/cupertino.dart';
import 'package:sahashop_user/components/config_app/data_widget_config.dart';
import 'package:sahashop_user/components/saha_user/carousel/carousel_select.dart';

class BoxPionConfig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        CarouselSelect(
          height: 115,
          listWidget: LIST_WIDGET_BOX_POIN,
          indexSelected: 1,
          initPage: 1,
        )
      ],
    );
  }
}
