import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/category.dart';

import '../repository_widget_config.dart';

class CategoryProductScreen extends StatelessWidget {
  final Category? category;
  final bool autoSearch;

  CategoryProductScreen({Key? key, this.category, this.autoSearch = false})
      : super(key: key);
  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    dataAppCustomerController.categoryCurrent = category;

    var productsScreen;
    if (configController.configApp.categoryPageType! <
        RepositoryWidgetCustomer().LIST_CATEGORY_PRODUCT_SCREEN.length) {
      productsScreen = RepositoryWidgetCustomer().LIST_CATEGORY_PRODUCT_SCREEN[
          configController.configApp.categoryPageType!];
    } else {
      productsScreen =
          RepositoryWidgetCustomer().LIST_CATEGORY_PRODUCT_SCREEN[0];
    }
    productsScreen.autoSearch = autoSearch;
    return productsScreen;
  }
}
