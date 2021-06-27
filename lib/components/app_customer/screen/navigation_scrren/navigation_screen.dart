import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/navigation_scrren/navigation_controller.dart';

import '../../../../saha_data_controller.dart';

class NavigationScreen extends StatelessWidget {
  NavigationController navigationController = NavigationController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SahaDataController sahaDataController = Get.find();
        sahaDataController.changeStatusPreview(false);
        return true;
      },
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            children: <Widget>[...navigationController.navigationHome],
            index: navigationController.selectedIndexBottomBar.value,
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
