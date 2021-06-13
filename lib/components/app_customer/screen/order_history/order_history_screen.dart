import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/components/app_customer/screen/order_history/order_history_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/order_history/order_history_detail/order_detail_history_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/pay_screen/pay_screen.dart';
import 'package:sahashop_user/const/const_image_logo.dart';
import 'package:sahashop_user/utils/string_utils.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with TickerProviderStateMixin {
  TabController tabController;
  OrderHistoryController orderHistoryController =
      Get.put(OrderHistoryController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = new TabController(length: 10, vsync: this, initialIndex: 0);
    orderHistoryController.loadInitOrder();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mã giảm giá của tôi'),
          bottom: TabBar(
            isScrollable: true,
            controller: tabController,
            tabs: [
              Tab(text: "Chờ xác nhận"),
              Tab(text: "Đang chuẩn bị hàng"),
              Tab(text: "Đang giao hàng"),
              Tab(text: "Đã hoàn thành"),
              Tab(text: "Hết hàng"),
              Tab(text: "Shop huỷ"),
              Tab(text: "Khách đã huỷ"),
              Tab(text: "Lỗi giao hàng"),
              Tab(text: "Chờ trả hàng"),
              Tab(text: "Đã trả hàng"),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: List<Widget>.generate(10, (int index) {
            return buildStateOrder(index);
          }),
        ),
      ),
    );
  }

  Widget buildStateOrder(int indexState) {
    RefreshController _refreshController = RefreshController();
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(
        complete: Text(""),
      ),
      footer: CustomFooter(
        builder: (
          BuildContext context,
          LoadStatus mode,
        ) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Container();
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
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 300));
        orderHistoryController.refreshData();
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        await Future.delayed(Duration(milliseconds: 300));
        if (orderHistoryController.isDoneLoadMore) {
          orderHistoryController.loadMoreOrder();
        }
        _refreshController.loadComplete();
      },
      child: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                orderHistoryController.listOrder.length,
                (index) => orderHistoryController
                            .listOrder[index].orderStatusCode ==
                        orderHistoryController.listStatusCode[indexState]
                    ? InkWell(
                        onTap: () {
                          Get.to(
                            () => OrderHistoryDetailScreen(
                              order: orderHistoryController.listOrder[index],
                            ),
                          ).then((value) => {
                                if (value == "CANCELLED")
                                  {
                                    tabController.animateTo(6),
                                    orderHistoryController.refreshData(),
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
                                    "${orderHistoryController.listOrder[index].orderStatusName}",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: CachedNetworkImage(
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      imageUrl: orderHistoryController
                                                  .listOrder[index]
                                                  .lineItemsAtTime
                                                  .length ==
                                              0
                                          ? ""
                                          : "${orderHistoryController.listOrder[index].lineItemsAtTime[0].imageUrl}",
                                      errorWidget: (context, url, error) =>
                                          ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: logoSahaImage),
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
                                            "${orderHistoryController.listOrder[index].lineItemsAtTime[0].name}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Spacer(),
                                                  Text(
                                                    " x ${orderHistoryController.listOrder[index].lineItemsAtTime[0].quantity}",
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
                                                    "đ${SahaStringUtils().convertToMoney(orderHistoryController.listOrder[index].lineItemsAtTime[0].beforePrice)}",
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Text(
                                                    "đ${SahaStringUtils().convertToMoney(orderHistoryController.listOrder[index].lineItemsAtTime[0].afterDiscount)}",
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
                            ),
                            orderHistoryController.listOrder[index]
                                        .lineItemsAtTime.length >
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
                                    "${orderHistoryController.listOrder[index].lineItemsAtTime.length} sản phẩm",
                                    style: TextStyle(color: Colors.grey[600]),
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
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("Thành tiền: "),
                                      Text(
                                        "đ${SahaStringUtils().convertToMoney(orderHistoryController.listOrder[index].totalAfterDiscount)}",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
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
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => PayScreen(
                                            orderCode: orderHistoryController
                                                .listOrder[index].orderCode,
                                          ));
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Center(
                                        child: Text(
                                          "Thanh toán",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline6
                                                  .color),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 35,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Center(
                                      child: Text(
                                        "Xem",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .headline6
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
                                    "${orderHistoryController.listOrder[index].orderCode}",
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
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
