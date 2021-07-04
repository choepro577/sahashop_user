import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_order.dart';
import 'package:sahashop_user/app_customer/screen/cart_screen/cart_screen_1.dart';
import 'package:sahashop_user/app_customer/screen/order_history/order_history_detail/order_detail_history_screen.dart';
import 'package:sahashop_user/app_customer/screen/order_history/order_status_page/widget/order_item_widget.dart';
import 'package:sahashop_user/app_customer/screen/pay_screen/pay_screen.dart';
import 'package:sahashop_user/app_customer/screen/review/review_screen.dart';
import 'package:sahashop_user/app_customer/utils/color_utils.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:sahashop_user/app_user/model/order.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';
import 'package:sahashop_user/app_user/utils/string_utils.dart';

import 'order_status_controller.dart';
import 'widget/order_loading_item_widget.dart';

// ignore: must_be_immutable
class OrderStatusPage extends StatefulWidget {
  final String? fieldByValue;
  final String? fieldBy;

  OrderStatusPage({Key? key, this.fieldBy, this.fieldByValue})
      : super(key: key);

  OrderStatusController orderStatusController = new OrderStatusController();

  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  late OrderStatusController orderStatusController;

  RefreshController _refreshController = RefreshController();
  late TabController tabController;
  @override
  void initState() {
    orderStatusController = widget.orderStatusController;
    orderStatusController.fieldBy = widget.fieldBy;
    orderStatusController.fieldByValue = widget.fieldByValue;
    orderStatusController.getAllOrder(isRefresh: true);
    tabController = new TabController(length: 10, vsync: this, initialIndex: 0);
    print("ssssss");
    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    // TODO: implement build
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: MaterialClassicHeader(),
      footer: CustomFooter(
        builder: (
          BuildContext context,
          LoadStatus? mode,
        ) {
          Widget body = Container();
          if (mode == LoadStatus.idle) {
            body = Obx(() => orderStatusController.isLoadMore.value
                ? CupertinoActivityIndicator()
                : Container());
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: () async {
        await orderStatusController.getAllOrder(isRefresh: true);
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        await orderStatusController.getAllOrder(isRefresh: false);
        _refreshController.loadComplete();
      },
      child: Obx(
        () => orderStatusController.isLoadRefresh.value
            ? ListView.builder(
                itemBuilder: (context, index) => OrderLoadingItemWidget(),
                itemCount: 2,
              )
            : SingleChildScrollView(
                child: orderStatusController.checkIsEmpty.value
                    ? SahaEmptyOrder()
                    : Column(
                        children: [
                          ...List.generate(
                            orderStatusController.listOrder.length,
                            (index) => OrderItemWidget(
                              order: orderStatusController.listOrder[index],
                              onTap: () {
                                Get.to(
                                  () => OrderHistoryDetailScreen(
                                    order:
                                        orderStatusController.listOrder[index],
                                  ),
                                )!
                                    .then((value) => {
                                          if (value == "CANCELLED")
                                            {
                                              tabController.animateTo(6),
                                              orderStatusController.getAllOrder(
                                                  isRefresh: true),
                                            },
                                        });
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
                                        Spacer(),
                                        Text(
                                          "${orderStatusController.listOrder[index].orderStatusName}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                            imageUrl: orderStatusController
                                                        .listOrder[index]
                                                        .lineItemsAtTime!
                                                        .length ==
                                                    0
                                                ? ""
                                                : "${orderStatusController.listOrder[index].lineItemsAtTime![0].imageUrl}",
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
                                                  "${orderStatusController.listOrder[index].lineItemsAtTime![0].name}",
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
                                                          " x ${orderStatusController.listOrder[index].lineItemsAtTime![0].quantity}",
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
                                                          "đ${SahaStringUtils().convertToMoney(orderStatusController.listOrder[index].lineItemsAtTime![0].beforePrice)}",
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color: Colors
                                                                  .grey[600]),
                                                        ),
                                                        SizedBox(width: 15),
                                                        Text(
                                                          "đ${SahaStringUtils().convertToMoney(orderStatusController.listOrder[index].lineItemsAtTime![0].afterDiscount)}",
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
                                  orderStatusController.listOrder[index]
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
                                          "${orderStatusController.listOrder[index].lineItemsAtTime!.length} sản phẩm",
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
                                            color: SahaColorUtils()
                                                .colorTextWithPrimaryColor(),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text("Thành tiền: "),
                                            Text(
                                              "đ${SahaStringUtils().convertToMoney(orderStatusController.listOrder[index].totalFinal)}",
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
                                        orderStatusController.listOrder[index]
                                                        .orderStatusCode ==
                                                    WAITING_FOR_PROGRESSING ||
                                                orderStatusController
                                                        .listOrder[index]
                                                        .orderStatusCode ==
                                                    PACKING ||
                                                orderStatusController
                                                        .listOrder[index]
                                                        .orderStatusCode ==
                                                    SHIPPING
                                            ? InkWell(
                                                onTap: () {
                                                  Get.to(() => PayScreen(
                                                        orderCode:
                                                            orderStatusController
                                                                .listOrder[
                                                                    index]
                                                                .orderCode,
                                                      ));
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Center(
                                                    child: Text(
                                                      "Thanh toán",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .headline6!
                                                              .color),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        Spacer(),
                                        orderStatusController.listOrder[index]
                                                    .orderStatusCode !=
                                                COMPLETED
                                            ? Container(
                                                height: 35,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
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
                                            : orderStatusController
                                                            .listCheckReviewed[
                                                        index] ==
                                                    false
                                                ? InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                        () => ReviewScreen(
                                                          lineItemsAtTime:
                                                              orderStatusController
                                                                  .listOrder[
                                                                      index]
                                                                  .lineItemsAtTime!,
                                                          orderCode:
                                                              orderStatusController
                                                                  .listOrder[
                                                                      index]
                                                                  .orderCode,
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      child: Center(
                                                        child: Text(
                                                          "Đánh giá",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryTextTheme
                                                                  .headline6!
                                                                  .color),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                          () => CartScreen1());
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      child: Center(
                                                        child: Text(
                                                          "Mua lại",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryTextTheme
                                                                  .headline6!
                                                                  .color),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
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
                                          "${orderStatusController.listOrder[index].orderCode}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
      ),
    );
  }
}
