import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/cart_screen/cart_screen_1.dart';
import 'package:sahashop_user/components/app_customer/screen/chat_customer/chat_customer_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/login/login_screen.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter.dart';
import 'package:sahashop_user/components/saha_user/search/seach_field.dart';
import 'package:sahashop_user/components/utils/customer_info.dart';

class SearchBarType1 extends StatelessWidget {
  final Function? onSearch;
  final DataAppCustomerController dataAppCustomerController = Get.find();

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
              () => IconBtnWithCounter(
                svgSrc: "assets/icons/cart_icon.svg",
                press: () {
                  Get.to(() => CartScreen1());
                },
                numOfitem: dataAppCustomerController.listOrder.length,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconBtnWithCounter(
              svgSrc: "assets/icons/chat.svg",
              numOfitem: 3,
              press: () {
                Get.to(() => ChatCustomerScreen());
              },
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
