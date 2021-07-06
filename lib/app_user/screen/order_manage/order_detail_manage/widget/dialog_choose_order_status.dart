import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/model/order.dart';

class DialogChooseOrderStatus {
  static void showChoose(Function onReturn, String codeInput) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        print(codeInput);
        Widget buttonStatus(
            {required String text,
            String? code,
            Function? onTap,
            Color? color,
            String? codeInput}) {
          return InkWell(
            onTap: () {
              onTap!(code);
            },
            child: Stack(
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 65,
                    width: Get.width / 3 - 8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                            width: 1, color: color ?? Colors.grey[600]!)),
                    child: Center(
                        child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: color ?? Colors.grey[600],
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
                if (codeInput == code)
                  Positioned(
                    height: 30,
                    width: 30,
                    top: 5,
                    right: 5.5,
                    child: SvgPicture.asset(
                      "assets/icons/levels.svg",
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                if (codeInput == code)
                  Positioned(
                    height: 15,
                    width: 15,
                    top: 5,
                    right: 7,
                    child: Icon(
                      Icons.check,
                      size: 15,
                      color:
                          Theme.of(context).primaryTextTheme.headline6!.color,
                    ),
                  ),
              ],
            ),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Chuyển trạng thái",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
            Row(
              children: [
                buttonStatus(
                  code: PACKING,
                  text: ORDER_STATUS_DEFINE[PACKING]!,
                  onTap: (code) {
                    onReturn(code);
                  },
                  codeInput: codeInput,
                  color: Colors.orange,
                ),
                buttonStatus(
                  code: SHIPPING,
                  text: ORDER_STATUS_DEFINE[SHIPPING]!,
                  onTap: (code) {
                    onReturn(code);
                  },
                  codeInput: codeInput,
                  color: Colors.blue,
                ),
                buttonStatus(
                  code: COMPLETED,
                  text: ORDER_STATUS_DEFINE[COMPLETED]!,
                  onTap: (code) {
                    onReturn(code);
                  },
                  codeInput: codeInput,
                  color: Colors.green,
                ),
              ],
            ),
            Row(
              children: [
                buttonStatus(
                    code: OUT_OF_STOCK,
                    text: ORDER_STATUS_DEFINE[OUT_OF_STOCK]!,
                    codeInput: codeInput,
                    onTap: (code) {
                      onReturn(code);
                    }),
                buttonStatus(
                    code: USER_CANCELLED,
                    text: ORDER_STATUS_DEFINE[USER_CANCELLED]!,
                    codeInput: codeInput,
                    onTap: (code) {
                      onReturn(code);
                    }),
                buttonStatus(
                    code: CUSTOMER_CANCELLED,
                    text: ORDER_STATUS_DEFINE[CUSTOMER_CANCELLED]!,
                    codeInput: codeInput,
                    onTap: (code) {
                      onReturn(code);
                    }),
              ],
            ),
            Row(
              children: [
                buttonStatus(
                    code: DELIVERY_ERROR,
                    text: ORDER_STATUS_DEFINE[DELIVERY_ERROR]!,
                    codeInput: codeInput,
                    onTap: (code) {
                      onReturn(code);
                    }),
                buttonStatus(
                    code: CUSTOMER_RETURNING,
                    text: ORDER_STATUS_DEFINE[CUSTOMER_RETURNING]!,
                    codeInput: codeInput,
                    onTap: (code) {
                      onReturn(code);
                    }),
                buttonStatus(
                    code: CUSTOMER_HAS_RETURNS,
                    text: ORDER_STATUS_DEFINE[CUSTOMER_HAS_RETURNS]!,
                    codeInput: codeInput,
                    onTap: (code) {
                      onReturn(code);
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SahaButtonFullParent(
                text: "Thoát",
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }
}
