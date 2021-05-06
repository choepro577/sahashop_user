import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/controller/config_controller.dart';
import 'package:sahashop_user/screen/config_app/widget/button_back_overlay.dart';

import 'screen/data_app_controller.dart';
import 'screen/data_app_screen.dart';

void runMain(BuildContext context) {
  ButtonBackOverLay().show(context);

  ConfigController configController=Get.find();

  Get.to(
    () => LoadAppScreen(
      logo: configController.configApp.logoUrl,
    ),
  ).then((value) {
    ButtonBackOverLay().hide();
  });
}
