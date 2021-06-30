import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/controller/config_controller.dart';

import '../../saha_data_controller.dart';
import 'screen/data_app_controller.dart';
import 'screen/data_app_screen.dart';

void runMainAppCustomer(BuildContext context) {
  SahaDataController sahaDataController = Get.find();

  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();
  // configController.getAppTheme();
  dataAppCustomerController.getHomeData();
//  sahaDataController.changeStatusPreview(false);

  sahaDataController.changeStatusPreview(true);

  Get.to(
    () => LoadAppScreen(
      logo: configController.configApp.logoUrl,
    ),
  )!
      .then((value) {});
}
