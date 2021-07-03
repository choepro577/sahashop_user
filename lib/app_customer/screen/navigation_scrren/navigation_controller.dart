import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../screen/cart_screen/cart_screen_1.dart';
import '../../screen/category_post_screen/category_post_screen_1.dart';
import '../../screen/repository_widget_config.dart';
import '../../screen/order_history/order_history_screen.dart';
import '../../screen/profile_screen/profile_screen.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';

class NavigationController extends GetxController {
  var selectedIndexBottomBar = 2.obs;
  late ConfigController configController;
  List<Widget> navigationHome = [];

  NavigationController() {
    configController = Get.find();
    if (configController.configApp.homePageType != null &&
        configController.configApp.homePageType! <
            RepositoryWidgetCustomer().LIST_WIDGET_HOME_SCREEN.length) {
      navigationHome = [
        CartScreen1(
          key: PageStorageKey<String>('str0'),
        ),
        CategoryPostStyle1(
          key: PageStorageKey<String>('str1'),
        ),
        Container(
            key: PageStorageKey<String>('str2'),
            child: RepositoryWidgetCustomer().LIST_WIDGET_HOME_SCREEN[
                configController.configApp.homePageType!]),
        OrderHistoryScreen(
          key: PageStorageKey<String>('str3'),
        ),
        ProfileScreen(
          key: PageStorageKey<String>('str4'),
        ),
      ];
    } else {
      navigationHome = [RepositoryWidgetCustomer().LIST_WIDGET_HOME_SCREEN[0]];
    }
  }
}
