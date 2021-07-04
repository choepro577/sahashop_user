import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/product.dart';

import '../repository_widget_config.dart';

class ProductItemWidget extends StatelessWidget {
  ConfigController configController = Get.find();

  final Product? product;
  final double? width;

  ProductItemWidget({Key? key, this.product, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productWidget;

    if (configController.configApp.productItemType != null &&
        configController.configApp.productItemType! <
            RepositoryWidgetCustomer().LIST_ITEM_PRODUCT_WIDGET.length) {
      productWidget = RepositoryWidgetCustomer()
          .LIST_ITEM_PRODUCT_WIDGET[configController.configApp.carouselType!];
    } else {
      productWidget = RepositoryWidgetCustomer().LIST_ITEM_PRODUCT_WIDGET[0];
    }

    productWidget.product = product!;
    productWidget.width = width ?? null;
    return productWidget;
  }
}
