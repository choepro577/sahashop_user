import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/iconButton/iconbtn_counter.dart';
import 'package:sahashop_user/app_user/components/saha_user/search/seach_field.dart';

import '../data_app_controller.dart';


class SearchBarType2 extends StatelessWidget {

  final DataAppCustomerController dataAppCustomerController = Get.find();

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
            IconBtnWithCounter(
              svgSrc: "assets/icons/cart_icon.svg",
              press: () {},
            ),
            SizedBox(
              width: 10,
            ),
            IconBtnWithCounter(
              svgSrc: "assets/icons/wallet.svg",
              numOfitem: 3,
              press: () {},
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
