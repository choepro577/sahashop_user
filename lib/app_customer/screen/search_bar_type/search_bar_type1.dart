import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen/cart_screen/cart_screen_1.dart';
import '../../screen/chat_customer/chat_customer_screen.dart';
import '../../screen/data_app_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/search/seach_field.dart';

// ignore: must_be_immutable
class SearchBarType1 extends StatelessWidget {
  Function? onSearch;
  DataAppCustomerController dataAppCustomerController = Get.find();
  SearchBarType1({Key? key, this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: SearchField(
                onClick: () {
                  dataAppCustomerController.toSearchScreen();
                },
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Row(
          children: [
            Obx(
              () => InkWell(
                onTap: () {
                  Get.to(() => CartScreen1())!
                      .then((value) => {dataAppCustomerController.getBadge()});
                },
                child: Badge(
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
                  position: BadgePosition(end: 0, top: -5),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/cart_icon.svg",
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Get.to(() => ChatCustomerScreen())!.then((value) => {
                      {dataAppCustomerController.getBadge()}
                    });
              },
              child: Badge(
                padding: EdgeInsets.all(3),
                toAnimate: true,
                animationType: BadgeAnimationType.slide,
                badgeContent: Text(
                  '${dataAppCustomerController.badge.value.chatsUnread}',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
                showBadge:
                    dataAppCustomerController.badge.value.chatsUnread == 0
                        ? false
                        : true,
                position: BadgePosition(end: 0, top: -5),
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/chat.svg",
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
