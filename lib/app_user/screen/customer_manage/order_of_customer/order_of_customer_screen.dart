import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/utils/color_utils.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/screen/customer_manage/order_of_customer/order_of_customer_controller.dart';
import 'package:sahashop_user/app_user/screen/customer_manage/order_of_customer/order_of_customer_detail/order_of_customer_detail_screen.dart';
import 'package:sahashop_user/app_user/utils/string_utils.dart';

// ignore: must_be_immutable
class OrderOfCustomer extends StatelessWidget {
  final int? idCustomer;

  OrderOfCustomer({this.idCustomer}) {
    orderOfCustomerController = OrderOfCustomerController();
    orderOfCustomerController.loadInitOrder(idCustomer!);
  }
  OrderOfCustomerController orderOfCustomerController = OrderOfCustomerController();

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController = RefreshController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Đơn hàng"),
      ),
      body: SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        header: WaterDropHeader(
          complete: Text(""),
        ),
        footer: CustomFooter(
          builder: (
            BuildContext context,
            LoadStatus? mode,
          ) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Obx(() => !orderOfCustomerController.isDoneLoadMore.value
                  ? CupertinoActivityIndicator()
                  : Container());
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Container();
            } else if (mode == LoadStatus.canLoading) {
              body = Container();
            } else {
              body = Container();
            }
            return Container(
              height: 0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onLoading: () async {
          await Future.delayed(Duration(milliseconds: 300));
          if (orderOfCustomerController.isDoneLoadMore.value) {
            orderOfCustomerController.loadMoreCustomer(idCustomer!);
          }
          _refreshController.loadComplete();
        },
        child: Obx(
          () => orderOfCustomerController.isLoadInit.value
              ? SahaSimmer(
                  isLoading: true,
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    color: Colors.black,
                  ))
              : SingleChildScrollView(
                  child: orderOfCustomerController.listOrder.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/check_list_new.svg",
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Khách hàng chưa có đơn hàng nào !")
                          ],
                        )
                      : Column(
                          children: [
                            ...List.generate(
                              orderOfCustomerController.listOrder.length,
                              (index) => InkWell(
                                onTap: () {
                                  Get.to(() => OrderOfCustomerDetailScreen(
                                        order: orderOfCustomerController
                                            .listOrder[index],
                                      ));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 8,
                                      color: Colors.grey[200],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                        top: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              width: 25,
                                              height: 25,
                                              fit: BoxFit.cover,
                                              imageUrl: orderOfCustomerController
                                                          .listOrder[index]
                                                          .lineItemsAtTime!
                                                          .length ==
                                                      0
                                                  ? ""
                                                  : "${orderOfCustomerController.listOrder[index].infoCustomer!.avatarImage}",
                                              errorWidget:
                                                  (context, url, error) =>
                                                      SahaEmptyImage(),
                                              ),
                                            ),

                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                              "${orderOfCustomerController.listOrder[index].infoCustomer!.name}"),
                                          Spacer(),
                                          Text(
                                            "${orderOfCustomerController.listOrder[index].orderStatusName}",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(height: 1),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            child: CachedNetworkImage(
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                              imageUrl: orderOfCustomerController
                                                          .listOrder[index]
                                                          .lineItemsAtTime!
                                                          .length ==
                                                      0
                                                  ? ""
                                                  : "${orderOfCustomerController.listOrder[index].lineItemsAtTime![0].imageUrl}",
                                              errorWidget:
                                                  (context, url, error) =>
                                                      SahaEmptyImage(),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${orderOfCustomerController.listOrder[index].lineItemsAtTime![0].name}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Spacer(),
                                                          Text(
                                                            " x ${orderOfCustomerController.listOrder[index].lineItemsAtTime![0].quantity}",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .grey[600]),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Spacer(),
                                                          Text(
                                                            "đ${SahaStringUtils().convertToMoney(orderOfCustomerController.listOrder[index].lineItemsAtTime![0].beforePrice)}",
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                color: Colors
                                                                    .grey[600]),
                                                          ),
                                                          SizedBox(width: 15),
                                                          Text(
                                                            "đ${SahaStringUtils().convertToMoney(orderOfCustomerController.listOrder[index].lineItemsAtTime![0].afterDiscount)}",
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
                                    ),
                                    orderOfCustomerController.listOrder[index]
                                                .lineItemsAtTime!.length >
                                            1
                                        ? Container(
                                            width: Get.width,
                                            padding: EdgeInsets.all(8),
                                            child: Center(
                                              child: Text(
                                                "Xem thêm sản phẩm",
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 13),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    Divider(
                                      height: 1,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${orderOfCustomerController.listOrder[index].lineItemsAtTime!.length} sản phẩm",
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                          Spacer(),
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
                                              color:SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text("Thành tiền: "),
                                              Text(
                                                "đ${SahaStringUtils().convertToMoney(orderOfCustomerController.listOrder[index].totalFinal)}",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
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
                                        children: [
                                          Spacer(),
                                          Container(
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Center(
                                              child: Text(
                                                "Xem",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headline6!
                                                        .color),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                        top: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Mã đơn hàng ",
                                          ),
                                          Spacer(),
                                          Text(
                                            "${orderOfCustomerController.listOrder[index].orderCode}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                  text:
                                                      "${orderOfCustomerController.listOrder[index].orderCode}"));
                                              SahaAlert.showToastMiddle(
                                                message: "Đã sao chép",
                                                color: Colors.grey[600],
                                              );
                                            },
                                            child: Text(
                                              "Sao chép",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
        ),
      ),
    );
  }
}
