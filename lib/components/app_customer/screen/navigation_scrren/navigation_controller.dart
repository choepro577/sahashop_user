import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/cart_screen/cart_screen_1.dart';
import 'package:sahashop_user/components/app_customer/screen/category_post_screen/category_post_screen_1.dart';
import 'package:sahashop_user/components/app_customer/screen/data_widget_config.dart';
import 'package:sahashop_user/components/app_customer/screen/profile_screen/profile_screen.dart';
import 'package:sahashop_user/controller/config_controller.dart';
import 'package:sahashop_user/screen/order_manage/order_manage_screen.dart';
import 'package:sahashop_user/screen/posts/post/posts_screen.dart';

class NavigationController extends GetxController {
  var selectedIndexBottomBar = 2.obs;
  late ConfigController configController;
  List<Widget> navigationHome = [];

  NavigationController() {
    configController = Get.find();
    if (configController.configApp.homePageType != null &&
        configController.configApp.homePageType! <
            LIST_WIDGET_HOME_SCREEN.length) {
      navigationHome = [
        CartScreen1(),
        CategoryPostStyle1(),
        LIST_WIDGET_HOME_SCREEN[configController.configApp.homePageType!],
        OrderManageScreen(),
        ProfileScreen(),
      ];
    } else {
      navigationHome = [LIST_WIDGET_HOME_SCREEN[0]];
    }
  }
}
