import 'package:get/get.dart';

import 'model/config_app.dart';

class ConfigController extends GetxController {
  ConfigApp configApp = ConfigApp();

  ConfigController() {
    configApp.colorMain1 = "b74093";

    configApp.searchType = 0;

    configApp.homeIdCarouselAppImage = 0;

    configApp.categoryPageType = 0;
  }
}
