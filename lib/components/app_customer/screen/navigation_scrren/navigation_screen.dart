import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/cart_screen/cart_screen_1.dart';
import 'package:sahashop_user/components/app_customer/screen/category_post_screen/category_post_screen_1.dart';
import 'package:sahashop_user/components/app_customer/screen/navigation_scrren/navigation_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/profile_screen/profile_screen.dart';
import 'package:sahashop_user/screen/order_manage/order_manage_screen.dart';

import '../../../../saha_data_controller.dart';
import '../data_widget_config.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  NavigationController navigationController = NavigationController();



  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = navigationController.navigationHome;

    return WillPopScope(
      onWillPop: () async {
        SahaDataController sahaDataController = Get.find();
        sahaDataController.changeStatusPreview(false);
        return true;
      },
      child: Obx(
        () => Scaffold(
          body: PageStorage(
            child:pages[navigationController.selectedIndexBottomBar.value],
            bucket: _bucket,
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedLabelStyle: TextStyle(color: Colors.grey),
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedItemColor:  Theme.of(context)
                .primaryColor
                .computeLuminance() >
                0.5
                ? Colors.black
                : Theme.of(context).primaryColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Giỏ hàng',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.description),
                label: 'Tin tức',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.reorder_outlined),
                label: 'Đơn hàng',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                label: 'Tài khoản',
              ),
            ],
            currentIndex: navigationController.selectedIndexBottomBar.value,
            onTap: (currentIndex) {
              navigationController.selectedIndexBottomBar.value = currentIndex;
            },
          ),
        ),
      ),
    );
  }
}
