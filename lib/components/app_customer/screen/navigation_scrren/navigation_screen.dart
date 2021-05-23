import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/navigation_scrren/navigation_controller.dart';

class NavigationScreen extends StatelessWidget {
  NavigationController navigationController = NavigationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => navigationController
          .navigationHome[navigationController.selectedIndexBottomBar.value]),
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        backgroundColor: Colors.transparent,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (currentIndex) {
          navigationController.selectedIndexBottomBar.value = currentIndex;
        },
      ),
    );
  }
}
