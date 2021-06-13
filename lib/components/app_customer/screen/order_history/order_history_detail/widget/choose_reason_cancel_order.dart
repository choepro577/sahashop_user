import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/order_history/order_history_detail/order_detail_history_controller.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';

class ChooseReasonCancelOrder {
  static void showChooseReasonCancel(Function onReturn, Function accept) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context,
      builder: (BuildContext context) {
        OrderHistoryDetailController orderHistoryDetailController = Get.find();
        var listReasonCancelOrder = [
          "Muốn thay đổi địa chỉ giao hàng",
          "Muốn nhập/thay đổi mã Voucher",
          "Muốn thay đổi sản phẩm trong đơn hàng(size, màu sắc, số lượng,...",
          "Thủ tục thanh toán quá rắc rối",
          "Tìm thấy giá rẻ hơn chỗ khác",
          "Đổi ý không muốn mua nữa",
        ];
        Widget boxChooseReason({String text, Function onTap, bool isChoose}) {
          return InkWell(
              onTap: () {
                onTap(text);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        isChoose
                            ? Container(
                                height: 9,
                                width: 9,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Text(text))
                ],
              ));
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Chọn lý do huỷ"),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.amber.withOpacity(0.2),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.warning_amber_sharp,
                      size: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Vui lòng chọn lí do huỷ đơn hàng. Lưu ý thao tác này sẽ huỷ tất cả các sản phẩm có trong đơn hàng và không thể hoàn tác",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            ...List.generate(
                listReasonCancelOrder.length,
                (index) => Obx(
                      () => boxChooseReason(
                          text: listReasonCancelOrder[index],
                          onTap: (text) {
                            onReturn(text, index);
                          },
                          isChoose:
                              orderHistoryDetailController.listChoose[index]),
                    )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SahaButtonFullParent(
                text: "Đồng ý",
                onPressed: () {
                  Get.back();
                  accept();
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
