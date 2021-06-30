import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:sahashop_user/app_user/model/box_chat_customer.dart';
import 'package:sahashop_user/app_user/model/order.dart';
import 'package:sahashop_user/app_user/screen/chat/chat_screen/chat_controller.dart';
import 'package:sahashop_user/app_user/screen/chat/chat_screen/chat_screen.dart';
import 'package:sahashop_user/app_user/screen/order_manage/order_detail_manage/order_detail_manage_controller.dart';
import 'package:sahashop_user/app_user/screen/order_manage/order_detail_manage/widget/dialog_choose_payment_status.dart';
import 'package:sahashop_user/app_user/screen/order_manage/order_manage_controller.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';
import 'package:sahashop_user/app_user/utils/string_utils.dart';
import 'widget/dialog_choose_order_status.dart';

// ignore: must_be_immutable
class OrderDetailScreen extends StatelessWidget {
  final Order? order;
  final int? indexListOrder;
  final int? indexStateOrder;

  var listStatusCode = [
    WAITING_FOR_PROGRESSING,
    PACKING,
    OUT_OF_STOCK,
    USER_CANCELLED,
    CUSTOMER_CANCELLED,
    SHIPPING,
    DELIVERY_ERROR,
    COMPLETED,
    CUSTOMER_RETURNING,
    CUSTOMER_HAS_RETURNS,
  ];

  OrderDetailScreen({this.order, this.indexListOrder, this.indexStateOrder}) {
    orderDetailController = OrderDetailController(inputOrder: order);
    orderManageController = Get.find();
    chatController = Get.put(ChatController());
  }

  OrderDetailController? orderDetailController;
  OrderManageController? orderManageController;
  ChatController? chatController;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin đơn hàng"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => orderDetailController!.isLoadingOrder.value
              ? SahaSimmer(
                  isLoading: true,
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    color: Colors.black,
                  ))
              : Column(
                  children: [
                    Container(
                      color: Color(0xff16a5a1),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              DialogChooseOrderStatus.showChoose((value) async {
                                await orderDetailController!
                                    .changeOrderStatus(value);
                                var check = orderManageController!
                                    .listStatusCode
                                    .indexWhere((element) => element == value);
                                if (check != -1) {
                                  orderManageController!.listAllOrder[check]
                                      .insert(
                                          0,
                                          orderDetailController!
                                              .orderResponse.value);
                                  orderManageController!
                                      .listAllOrder[indexStateOrder!]
                                      .removeAt(indexListOrder!);
                                  if (orderManageController!
                                      .listAllOrder[indexStateOrder!].isEmpty) {
                                    orderManageController!.listCheckIsEmpty[
                                        indexStateOrder!] = true;
                                  }
                                  orderManageController!
                                      .listCheckIsEmpty[check] = false;
                                  orderManageController!.listCheckIsEmpty
                                      .refresh();
                                  orderManageController!.listAllOrder.refresh();
                                }
                                Get.back();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Trạng thái đơn hàng: ${orderDetailController!.orderResponse.value.orderStatusName}",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .headline6!
                                            .color),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .headline6!
                                        .color,
                                    size: 18,
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
                          ),
                          Divider(
                            height: 1,
                          ),
                          InkWell(
                            onTap: () {
                              DialogChoosePaymentStatus.showChoosePayment(
                                  (value) {
                                orderDetailController!.changeOrderStatus(value);
                                // orderManageController!.listOrder[indexListOrder]
                                //     .paymentStatusCode = value;
                                // orderManageController!.listOrder.refresh();
                                Get.back();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Trạng thái thanh toán: ${orderDetailController!.orderResponse.value.paymentStatusName}",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .headline6!
                                            .color),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .headline6!
                                        .color,
                                    size: 18,
                                  ),
                                  Spacer(),
                                  Container(
                                    child: SvgPicture.asset(
                                        "assets/icons/wallet.svg",
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
                          )
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
                              Text(
                                  "Đơn vị vận chuyển: ${orderDetailController!.orderResponse.value.shipperName}"),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Kiểu : ${orderDetailController!.orderResponse.value.shipperType == 0 ? "Giao nhanh" : "Siêu tốc"}"),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Phí giao hàng: 35.000"),
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
                                  "${orderDetailController!.orderResponse.value.customerAddress!.name ?? "Chưa có tên"}  | ${orderDetailController!.orderResponse.value.customerAddress!.phone ?? "Chưa có số điện thoại"}",
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.7,
                                child: Text(
                                  "${orderDetailController!.orderResponse.value.customerAddress!.addressDetail ?? "Chưa có địa chỉ chi tiết"}",
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.7,
                                child: Text(
                                  "${orderDetailController!.orderResponse.value.customerAddress!.districtName ?? "Chưa có Quận/Huyện"}, ${orderDetailController!.orderResponse.value.customerAddress!.wardsName ?? "Chưa có Phường/Xã"}, ${orderDetailController!.orderResponse.value.customerAddress!.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 13),
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
                          orderDetailController!
                              .orderResponse.value.lineItemsAtTime!.length,
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
                                            border: Border.all(
                                                color: Colors.grey[200]!)),
                                        child: CachedNetworkImage(
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          imageUrl: orderDetailController!
                                                      .inputOrder!
                                                      .lineItemsAtTime!
                                                      .length ==
                                                  0
                                              ? ""
                                              : "${orderDetailController!.orderResponse.value.lineItemsAtTime![index].imageUrl}",
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${orderDetailController!.orderResponse.value.lineItemsAtTime![index].name}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Spacer(),
                                                    Text(
                                                      " x ${orderDetailController!.orderResponse.value.lineItemsAtTime![index].quantity}",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Colors.grey[600]),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Spacer(),
                                                    Text(
                                                      "đ${SahaStringUtils().convertToMoney(orderDetailController!.orderResponse.value.lineItemsAtTime![index].beforePrice)}",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color:
                                                              Colors.grey[600]),
                                                    ),
                                                    SizedBox(width: 15),
                                                    Text(
                                                      "đ${SahaStringUtils().convertToMoney(orderDetailController!.orderResponse.value.lineItemsAtTime![index].afterDiscount)}",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
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
                                "đ${SahaStringUtils().convertToMoney(orderDetailController!.orderResponse.value.totalBeforeDiscount)}",
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
                                "+ đ${SahaStringUtils().convertToMoney(orderDetailController!.orderResponse.value.totalShippingFee)}",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          orderDetailController!.orderResponse.value
                                      .productDiscountAmount ==
                                  0
                              ? Container()
                              : Row(
                                  children: [
                                    Text(
                                      "Giảm giá sản phẩm: ",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Spacer(),
                                    Text(
                                      "- đ${SahaStringUtils().convertToMoney(orderDetailController!.orderResponse.value.productDiscountAmount)}",
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 5,
                          ),
                          orderDetailController!.orderResponse.value
                                      .comboDiscountAmount ==
                                  0
                              ? Container()
                              : Row(
                                  children: [
                                    Text(
                                      "Giảm giá Combo: ",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Spacer(),
                                    Text(
                                      "- đ${SahaStringUtils().convertToMoney(orderDetailController!.orderResponse.value.comboDiscountAmount)}",
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 5,
                          ),
                          orderDetailController!.orderResponse.value
                                      .voucherDiscountAmount ==
                                  0
                              ? Container()
                              : Row(
                                  children: [
                                    Text(
                                      "Giảm giá Voucher:",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Spacer(),
                                    Text(
                                      "- đ${SahaStringUtils().convertToMoney(orderDetailController!.orderResponse.value.voucherDiscountAmount)}",
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
                                  "đ${SahaStringUtils().convertToMoney(orderDetailController!.orderResponse.value.totalFinal)}")
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
                              Text(
                                  "${orderDetailController!.orderResponse.value.paymentMethodName}")
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
                                Text(
                                    "${orderDetailController!.orderResponse.value.orderCode}"),
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
                                  "${SahaDateUtils().getDDMMYY(orderDetailController!.orderResponse.value.createdAt!)} ${SahaDateUtils().getHHMM(orderDetailController!.orderResponse.value.createdAt!)}",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ...List.generate(
                              orderDetailController!.listStateOrder.length,
                              (index) => Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.6,
                                        child: Text(
                                          "${orderDetailController!.listStateOrder[index].note}",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${SahaDateUtils().getDDMMYY(orderDetailController!.listStateOrder[index].createdAt!)} ${SahaDateUtils().getHHMM(orderDetailController!.listStateOrder[index].createdAt!)}",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        chatController!.boxChatCustomer.value = BoxChatCustomer(
                          customerId: orderDetailController!
                              .orderResponse.value.customerId,
                          customer: orderDetailController!
                              .orderResponse.value.infoCustomer,
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
                                  "assets/icons/chat_empty.svg",
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
                  Obx(
                    () => orderDetailController!.isLoadingOrder.value
                        ? Container()
                        : Text(
                            "đ${SahaStringUtils().convertToMoney(orderDetailController!.orderResponse.value.totalFinal)}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor),
                          ),
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
                  Obx(
                    () => orderDetailController!.isLoadingOrder.value
                        ? Container()
                        : Text(
                            "${orderDetailController!.orderResponse.value.orderCode}"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
