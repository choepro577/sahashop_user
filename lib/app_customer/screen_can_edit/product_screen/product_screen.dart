import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/product.dart';

import '../repository_widget_config.dart';

class ProductScreen extends StatelessWidget {
  final Product? product;

  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  ProductScreen({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dataAppCustomerController.productCurrent = product;
    if (configController.configApp.productPageType! <
        RepositoryWidgetCustomer().LIST_PRODUCT_SCREEN.length) {
      return RepositoryWidgetCustomer().LIST_PRODUCT_SCREEN[
          configController.configApp.productPageType!];
    } else {
      return RepositoryWidgetCustomer().LIST_PRODUCT_SCREEN[0];
    }
  }
}
