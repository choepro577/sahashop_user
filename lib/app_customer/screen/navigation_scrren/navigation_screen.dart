import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/attendance/dialog_attendance.dart';
import 'package:sahashop_user/app_customer/screen/data_app_controller.dart';
import '../../../saha_data_controller.dart';
import 'navigation_controller.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  NavigationController navigationController = NavigationController();
  DataAppCustomerController dataAppCustomerController = Get.find();
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (dataAppCustomerController.isCheckIn == true) {
        DialogAttendance.showAttendanceDialog(
            context,
            dataAppCustomerController.scoreToday,
            dataAppCustomerController.listRollCall);
      }
    });
    super.initState();
  }

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
                  padding: EdgeInsets.all(3),
                  toAnimate: true,
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(
                    '${dataAppCustomerController.badge.value.cartQuantity}',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                  showBadge:
                      dataAppCustomerController.badge.value.cartQuantity == 0
                          ? false
                          : true,
                  child: Icon(Icons.shopping_cart),
                ),
                label: 'Giỏ hàng',
              ),
              BottomNavigationBarItem(
                icon: Badge(
                  padding: EdgeInsets.all(3),
                  toAnimate: true,
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(
                    '${dataAppCustomerController.badge.value.cartQuantity}',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                  showBadge:
                      dataAppCustomerController.badge.value.cartQuantity == 0
                          ? false
                          : true,
                  child: Icon(Icons.description),
                ),
                label: 'Tin tức',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Badge(
                  padding: EdgeInsets.all(3),
                  toAnimate: true,
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(
                    '${dataAppCustomerController.badge.value.ordersWaitingForProgressing}',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                  showBadge: dataAppCustomerController
                              .badge.value.ordersWaitingForProgressing ==
                          0
                      ? false
                      : true,
                  child: Icon(Icons.reorder_outlined),
                ),
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
