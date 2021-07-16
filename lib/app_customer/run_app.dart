import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/utils/store_info.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

import '../saha_data_controller.dart';
import 'screen_default/data_app_controller.dart';
import 'screen_default/data_app_screen.dart';

void runMainAppCustomer() async {
  await StoreInfo().setCustomerStoreCode(UserInfo().getCurrentStoreCode());

  SahaDataController sahaDataController = Get.find();
  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();
  dataAppCustomerController.getHomeData();
  sahaDataController.changeStatusPreview(true);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Get.to(
    () => LoadAppScreen(
      logo: configController.configApp.logoUrl,
    ),
  )!
      .then((value) {});
}
