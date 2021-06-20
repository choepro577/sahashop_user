import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/model/order.dart';

class DialogChoosePaymentStatus {
  static void showChoosePayment(Function onReturn) {
    showModalBottomSheet<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        Widget buttonStatus(
            {required String text, String? code, Function? onTap, Color? color}) {
          return InkWell(
            onTap: () {
              onTap!(code);
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                height: 65,
                width: Get.width / 3 - 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border:
                        Border.all(width: 1, color: color ?? Colors.grey[600]!)),
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
          );
          ;
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
                  code: WAITING_FOR_PROGRESSING,
                  text: ORDER_PAYMENT_DEFINE[WAITING_FOR_PROGRESSING]!,
                  onTap: (code) {
                    onReturn(code);
                  },
                  color: Colors.orange,
                ),
                buttonStatus(
                  code: UNPAID,
                  text: ORDER_PAYMENT_DEFINE[UNPAID]!,
                  onTap: (code) {
                    onReturn(code);
                  },
                  color: Colors.red,
                ),
                buttonStatus(
                  code: PAID,
                  text: ORDER_PAYMENT_DEFINE[PAID]!,
                  onTap: (code) {
                    onReturn(code);
                  },
                  color: Colors.green,
                ),
              ],
            ),
            Row(
              children: [
                buttonStatus(
                    code: PARTIALLY_PAID,
                    text: ORDER_PAYMENT_DEFINE[PARTIALLY_PAID]!,
                    onTap: (code) {
                      onReturn(code);
                    }),
                buttonStatus(
                    code: CANCELLED,
                    text: ORDER_PAYMENT_DEFINE[CANCELLED]!,
                    onTap: (code) {
                      onReturn(code);
                    }),
                buttonStatus(
                    code: REFUNDS,
                    text: ORDER_PAYMENT_DEFINE[REFUNDS]!,
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
