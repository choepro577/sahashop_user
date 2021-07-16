import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../screen_can_edit/home/home_screen.dart';
import '../../screen_default/cart_screen/cart_screen_1.dart';
import '../../screen_default/category_post_screen/category_post_screen_1.dart';
import '../../screen_default/order_history/order_history_screen.dart';
import '../../screen_default/profile_screen/profile_screen.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';

class NavigationController extends GetxController {
  var selectedIndexBottomBar = 2.obs;
  late ConfigController configController;
  List<Widget> navigationHome = [];

  NavigationController() {
    configController = Get.find();

    navigationHome = [
      CartScreen1(
        key: PageStorageKey<String>('str0'),
      ),
      Container(
        key: PageStorageKey<String>('str1'),
        child: CategoryPostScreen(),
      ),
      Container(key: PageStorageKey<String>('str2'), child: HomeScreen()),
      OrderHistoryScreen(
        key: PageStorageKey<String>('str3'),
      ),
      ProfileScreen(
        key: PageStorageKey<String>('str4'),
      ),
    ];
  }
}
