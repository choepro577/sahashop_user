import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/box_chat_customer.dart';
import 'package:sahashop_user/app_user/model/order.dart';
import 'package:sahashop_user/app_user/screen/chat/chat_screen/chat_controller.dart';
import 'package:sahashop_user/app_user/screen/chat/chat_screen/chat_screen.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';
import 'package:sahashop_user/app_user/utils/string_utils.dart';

import 'order_of_customer_detail_controller.dart';


// ignore: must_be_immutable
class OrderOfCustomerDetailScreen extends StatelessWidget {
  final Order? order;

  OrderOfCustomerDetailScreen({this.order}) {
    orderOfCustomerDetailController =
        OrderOfCustomerDetailController(order: order);
    chatController = Get.put(ChatController());
  }
  late OrderOfCustomerDetailController orderOfCustomerDetailController;
  ChatController? chatController;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin đơn hàng"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xff16a5a1),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Trạng thái đơn hàng: ${order!.orderStatusName}",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6!
                                  .color),
                        ),
                        Spacer(),
                        Container(
                          width: 30,
                          height: 30,
                          child: SvgPicture.asset(
                              "assets/icons/delivery_truck.svg",
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6!
                                  .color),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Trạng thái thanh toán: ${order!.paymentStatusName}",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6!
                                  .color),
                        ),
                        Spacer(),
                        Container(
                          child: SvgPicture.asset("assets/icons/wallet.svg",
                              width: 28,
                              height: 28,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6!
                                  .color),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    child: SvgPicture.asset(
                      "assets/icons/delivery_truck.svg",
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Đơn vị vận chuyển: ${order!.shipperName}"),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Kiểu : ${order!.shipperType == 0 ? "Giao nhanh" : "Siêu tốc"}"),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Phí giao hàng: đ${SahaStringUtils().convertToMoney(order!.totalShippingFee ?? 0.0)}"),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/location.svg",
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Địa chỉ nhận hàng của khách:",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Container(
                        width: Get.width * 0.7,
                        child: Text(
                          "${order!.customerAddress!.name ?? "Chưa có tên"}  | ${order!.customerAddress!.phone ?? "Chưa có số điện thoại"}",
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: Get.width * 0.7,
                        child: Text(
                          "${order!.customerAddress!.addressDetail ?? "Chưa có địa chỉ chi tiết"}",
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: Get.width * 0.7,
                        child: Text(
                          "${order!.customerAddress!.districtName ?? "Chưa có Quận/Huyện"}, ${order!.customerAddress!.wardsName ?? "Chưa có Phường/Xã"}, ${order!.customerAddress!.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
                          style:
                          TextStyle(color: Colors.grey[700], fontSize: 13),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 8,
              color: Colors.grey[200],
            ),
            Column(
              children: [
                ...List.generate(
                  order!.lineItemsAtTime!.length,
                      (index) => Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: Container(
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(color: Colors.grey[200]!)),
                                child: CachedNetworkImage(
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  imageUrl: order!.lineItemsAtTime!.length == 0
                                      ? ""
                                      : "${order!.lineItemsAtTime![index].imageUrl}",
                                  errorWidget: (context, url, error) =>
                                      SahaEmptyImage(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 80,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${order!.lineItemsAtTime![index].name}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                              " x ${order!.lineItemsAtTime![index].quantity}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey[600]),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                              "đ${SahaStringUtils().convertToMoney(order!.lineItemsAtTime![index].beforePrice)}",
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.grey[600]),
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              "đ${SahaStringUtils().convertToMoney(order!.lineItemsAtTime![index].afterDiscount)}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Tổng tiền hàng: ",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Spacer(),
                      Text(
                        "đ${SahaStringUtils().convertToMoney(order!.totalBeforeDiscount)}",
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Phí vận chuyển: ",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Spacer(),
                      Text(
                        "+ đ${SahaStringUtils().convertToMoney(order!.totalShippingFee)}",
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  order!.productDiscountAmount == 0
                      ? Container()
                      : Row(
                    children: [
                      Text(
                        "Giảm giá sản phẩm: ",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Spacer(),
                      Text(
                        "- đ${SahaStringUtils().convertToMoney(order!.productDiscountAmount)}",
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  order!.comboDiscountAmount == 0
                      ? Container()
                      : Row(
                    children: [
                      Text(
                        "Giảm giá Combo: ",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Spacer(),
                      Text(
                        "- đ${SahaStringUtils().convertToMoney(order!.comboDiscountAmount)}",
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  order!.voucherDiscountAmount == 0
                      ? Container()
                      : Row(
                    children: [
                      Text(
                        "Giảm giá Voucher:",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Spacer(),
                      Text(
                        "- đ${SahaStringUtils().convertToMoney(order!.voucherDiscountAmount)}",
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text("Thành tiền: "),
                      Spacer(),
                      Text(
                          "đ${SahaStringUtils().convertToMoney(order!.totalFinal)}")
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Container(
              height: 8,
              color: Colors.grey[200],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/money.svg",
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phương thức thanh toán: "),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${order!.paymentMethodName}")
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 8,
              color: Colors.grey[200],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Obx(
                    () => Column(
                  children: [
                    Row(
                      children: [
                        Text("Mã đơn hàng"),
                        Spacer(),
                        Text("${order!.orderCode}"),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: "${order!.orderCode}"));
                            SahaAlert.showToastMiddle(
                              message: "Đã sao chép",
                              color: Colors.grey[600],
                            );
                          },
                          child: Text(
                            "Sao chép",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Thời gian đặt hàng",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Spacer(),
                        Text(
                          "${SahaDateUtils().getDDMMYY(order!.createdAt!)} ${SahaDateUtils().getHHMM(order!.createdAt!)}",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ...List.generate(
                      orderOfCustomerDetailController.listStateOrder.length,
                          (index) => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width * 0.6,
                                child: Text(
                                  "${orderOfCustomerDetailController.listStateOrder[index].note}",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${SahaDateUtils().getDDMMYY(orderOfCustomerDetailController.listStateOrder[index].createdAt!)} ${SahaDateUtils().getHHMM(orderOfCustomerDetailController.listStateOrder[index].createdAt!)}",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        chatController!.boxChatCustomer.value = BoxChatCustomer(
                          customerId: order!.customerId,
                          customer: order!.infoCustomer,
                        );
                        Get.to(() => ChatScreen())!.then((value) => {
                          chatController!.refreshDataMessage(),
                          chatController!.refreshDataAllChat()
                        });
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[500]!)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F6F9),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/chat.svg",
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Liên hệ khách hàng")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 8,
              color: Colors.grey[200],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Tổng tiền: ",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(
                    "đ${SahaStringUtils().convertToMoney(order!.totalFinal)}",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Mã đơn hàng",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text("${order!.orderCode}"),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: "${order!.orderCode}"));
                      SahaAlert.showToastMiddle(
                        message: "Đã sao chép",
                        color: Colors.grey[600],
                      );
                    },
                    child: Text(
                      "Sao chép",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}