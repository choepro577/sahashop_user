import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import '../../screen_default/cart_screen/cart_screen_1.dart';
import '../../screen_default/order_history/order_history_detail/order_detail_history_screen.dart';
import '../../screen_default/pay_screen/pay_screen.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'order_completed_controller.dart';

// ignore: must_be_immutable
class OrderCompletedScreen extends StatelessWidget {
  final String? orderCode;

  OrderCompletedController? orderCompletedController;

  DataAppCustomerController dataAppCustomerController = Get.find();

  OrderCompletedScreen({Key? key, this.orderCode}) : super(key: key) {
    orderCompletedController = OrderCompletedController(orderCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            child: SingleChildScrollView(
              child: Container(
                height: Get.height,
                width: Get.width,
                child: Obx(
                  () {
                    var x = orderCompletedController!.refreshValue.value;
                    return orderCompletedController!.loading.value == true
                        ? SahaSimmer(
                            isLoading: true,
                            child: Container(
                              width: Get.width,
                              height: Get.height,
                              color: Colors.black,
                            ))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor),
                                        color: Theme.of(context).primaryColor),
                                    child: Icon(
                                      Icons.check,
                                      size: 15.0,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6!
                                          .color,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Đặt hàng thành công !",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "Bạn đã đặt hàng thành công xin đợi xác nhận từ cửa hàng",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              orderCompletedController!
                                              .order.value!.paymentMethodId ==
                                          0 ||
                                      orderCompletedController!
                                              .order.value!.paymentMethodId ==
                                          null
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        Get.to(() => PayScreen(
                                              orderCode:
                                                  orderCompletedController!
                                                      .order.value!.orderCode,
                                            ));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: Get.width * 0.8,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "THANH TOÁN",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline6!
                                                    .color,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.until((route) =>
                                          route.settings.name ==
                                          "customer_home");
                                    },
                                    child: Container(
                                      height: 35,
                                      width: Get.width * 0.35,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Trang chủ",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.off(() => OrderHistoryDetailScreen(
                                            order: orderCompletedController!
                                                .order.value,
                                          ));
                                    },
                                    child: Container(
                                      height: 35,
                                      width: Get.width * 0.35,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Đơn mua",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Thay đổi hình thức thanh toán",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                              Obx(
                                () => orderCompletedController!
                                            .isLoadingPayment.value ==
                                        true
                                    ? Container()
                                    : DropdownButton<Map<int, String>?>(
                                        focusColor: Colors.white,
                                        // value: null,
                                        // orderCompletedController!.paymentMethod,
                                        //elevation: 5,
                                        style: TextStyle(color: Colors.white),
                                        items: orderCompletedController!
                                            .listPaymentMethod!
                                            .map<
                                                    DropdownMenuItem<
                                                        Map<int, String>>>(
                                                (Map<int, String>? value) {
                                          return DropdownMenuItem<
                                              Map<int, String>>(
                                            value: value,
                                            child: Text(
                                              "${value!.values.first}",
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }).toList(),
                                        hint: Text(
                                          "${orderCompletedController!.order.value?.paymentMethodName ?? "Loading..."}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onChanged: (Map<int, String>? value) {
                                          orderCompletedController!
                                              .paymentMethod = value!;
                                          orderCompletedController!
                                              .changPaymentMethod(
                                                  value.keys.first);
                                        },
                                      ),
                              ),
                            ],
                          );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: SahaAppBar().preferredSize.height,
            left: 20,
            right: 20,
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {
                      Get.back();
                    }),
                Spacer(),
                Obx(
                  () => InkWell(
                    onTap: () {
                      Get.to(() => CartScreen1());
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
                          dataAppCustomerController.badge.value.cartQuantity ==
                                  0
                              ? false
                              : true,
                      position: BadgePosition(end: 0, top: -5),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/cart_icon.svg",
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6!
                              .color,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
