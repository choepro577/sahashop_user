import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/config_app/screen_home/base/home_sreen_base.dart';
import 'package:sahashop_user/model/button.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/screen/config_app/config_controller.dart';

import '../data_widget_config.dart';

class HomeScreenStyle2 extends StatelessWidget {
  final List<Category> categories;
  final List<ButtonConfig> buttonConfigs;
  final Function(Product) onPressedProduct;
  final Function(Product) onPressedCategories;
  final Function(Product) onPressedButtonConfig;

  HomeScreenStyle2(
      {Key key,
      this.categories,
      this.buttonConfigs,
      this.onPressedProduct,
      this.onPressedCategories,
      this.onPressedButtonConfig})
      : super(key: key);

  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LIST_WIDGET_SEARCH_BAR[configController.configApp.searchType],
          LIST_WIDGET_BANNER[configController.configApp.homeIdCarouselAppImage],
        ],
      ),
    );
  }
}
