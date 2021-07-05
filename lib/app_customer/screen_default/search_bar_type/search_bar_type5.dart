import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_default/cart_screen/cart_screen_1.dart';
import 'package:sahashop_user/app_customer/utils/color_utils.dart';
import '../../screen_default/chat_customer/chat_customer_screen.dart';
import '../../screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/search/seach_field.dart';

// ignore: must_be_immutable
class SearchBarType5 extends StatelessWidget {
  Function? onSearch;
  DataAppCustomerController dataAppCustomerController = Get.find();
  SearchBarType5({Key? key, this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              onSearch!();
            },
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey[600],
                  ),
                  Expanded(
                    child: Text(
                      "Tìm kiếm trong cửa hàng",
                      style: TextStyle(color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
