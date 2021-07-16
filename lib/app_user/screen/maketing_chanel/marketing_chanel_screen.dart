import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/screen/maketing_chanel/my_combo/my_combo_screen.dart';
import 'package:sahashop_user/app_user/screen/maketing_chanel/my_program/my_program_screen.dart';
import 'package:sahashop_user/app_user/screen/maketing_chanel/my_voucher/my_voucher_screen.dart';

class MarketingChanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Chương trình marketing'),
      ),
      body: Column(
        children: [
          Container(
            height: 8,
            color: Colors.grey[200],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Get.to(() => MyProgram());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/sale_tag.svg",
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Giảm giá sản phẩm")
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          InkWell(
            onTap: () {
              Get.to(() => MyVoucherScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/coupon.svg",
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Mã voucher giảm giá")
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Get.to(() => MyComboScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/gift_box.svg",
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Combo sản phẩm khuyến mãi")
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
