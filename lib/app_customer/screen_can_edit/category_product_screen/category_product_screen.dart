import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/category.dart';

import '../repository_widget_config.dart';

class CategoryProductScreen extends StatelessWidget {
  final Category? category;

  CategoryProductScreen({Key? key, this.category}) : super(key: key);
  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    dataAppCustomerController.categoryCurrent = category;
    if (configController.configApp.categoryPageType! <
        RepositoryWidgetCustomer().LIST_CATEGORY_PRODUCT_SCREEN.length) {
      return RepositoryWidgetCustomer().LIST_CATEGORY_PRODUCT_SCREEN[
          configController.configApp.categoryPageType!];
    } else {
      return RepositoryWidgetCustomer().LIST_CATEGORY_PRODUCT_SCREEN[0];
    }
  }
}
