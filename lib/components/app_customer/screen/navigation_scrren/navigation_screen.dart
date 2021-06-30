import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/navigation_scrren/navigation_controller.dart';

import '../../../../saha_data_controller.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  NavigationController navigationController = NavigationController();
  DataAppCustomerController dataAppCustomerController = Get.find();
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
            child: pages[navigationController.selectedIndexBottomBar.value],
            bucket: _bucket,
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedLabelStyle: TextStyle(color: Colors.grey),
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedItemColor:
                Theme.of(context).primaryColor.computeLuminance() > 0.5
                    ? Colors.black
                    : Theme.of(context).primaryColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Badge(
                  toAnimate: true,
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(
                    '${dataAppCustomerController.listOrder.length}',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                  showBadge: dataAppCustomerController.listOrder.isEmpty
                      ? false
                      : true,
                  child: Icon(Icons.shopping_cart),
                ),
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
