import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/const/const_image_logo.dart';
import 'package:sahashop_user/screen/order_manage/order_detail_manage/order_detail_manage_screen.dart';
import 'package:sahashop_user/screen/order_manage/order_manage_controller.dart';
import 'package:sahashop_user/utils/string_utils.dart';

class OrderManageScreen extends StatefulWidget {
  @override
  _OrderManageScreenState createState() => _OrderManageScreenState();
}

class _OrderManageScreenState extends State<OrderManageScreen>
    with TickerProviderStateMixin {
  TabController tabController;
  OrderManageController orderManageController =
      Get.put(OrderManageController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = new TabController(length: 10, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Đơn hàng'),
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
        body: Obx(
          () => TabBarView(
            controller: tabController,
            children: List<Widget>.generate(
                orderManageController.listAllOrder.length, (int index) {
              return buildStateOrder(index);
            }),
          ),
        ),
      ),
    );
  }

  Widget buildStateOrder(int indexState) {
    RefreshController _refreshController = RefreshController(
        initialRefresh: orderManageController.listCheckRefresh[indexState] == 1
            ? true
            : false);

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
            body = Obx(() => !orderManageController.isDoneLoadMore.value
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
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 300));
        orderManageController.refreshData(
          "order_status_code",
          orderManageController.listStatusCode[indexState],
          indexState,
        );

        // orderManageController.refreshData();
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        await Future.delayed(Duration(milliseconds: 300));
        if (orderManageController.isDoneLoadMore.value) {
          orderManageController.loadMoreOrder(
            "order_status_code",
            orderManageController.listStatusCode[indexState],
            indexState,
          );
        }
        _refreshController.loadComplete();
      },
      child: Obx(
        () => orderManageController.isLoadInit.value
            ? SahaSimmer(
                isLoading: true,
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.black,
                ))
            : SingleChildScrollView(
                child: orderManageController.listCheckIsEmpty[indexState]
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
                          Text("Không có đơn hàng nào !")
                        ],
                      )
                    : Column(
                        children: [
                          ...List.generate(
                            orderManageController
                                .listAllOrder[indexState].length,
                            (index) => InkWell(
                              onTap: () {
                                Get.to(() => OrderDetailScreen(
                                      order: orderManageController
                                          .listAllOrder[indexState][index],
                                      indexListOrder: index,
                                      indexStateOrder: indexState,
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
                                            imageUrl: orderManageController
                                                        .listAllOrder[
                                                            indexState][index]
                                                        .lineItemsAtTime
                                                        .length ==
                                                    0
                                                ? ""
                                                : "${orderManageController.listAllOrder[indexState][index].infoCustomer.avatarImage}",
                                            errorWidget:
                                                (context, url, error) =>
                                                    ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: logoSahaImage),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                            "${orderManageController.listAllOrder[indexState][index].infoCustomer.name}"),
                                        Spacer(),
                                        Text(
                                          "${orderManageController.listAllOrder[indexState][index].orderStatusName}",
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
                                            imageUrl: orderManageController
                                                        .listAllOrder[
                                                            indexState][index]
                                                        .lineItemsAtTime
                                                        .length ==
                                                    0
                                                ? ""
                                                : "${orderManageController.listAllOrder[indexState][index].lineItemsAtTime[0].imageUrl}",
                                            errorWidget:
                                                (context, url, error) =>
                                                    ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${orderManageController.listAllOrder[indexState][index].lineItemsAtTime[0].name}",
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
                                                          " x ${orderManageController.listAllOrder[indexState][index].lineItemsAtTime[0].quantity}",
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
                                                          "đ${SahaStringUtils().convertToMoney(orderManageController.listAllOrder[indexState][index].lineItemsAtTime[0].beforePrice)}",
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color: Colors
                                                                  .grey[600]),
                                                        ),
                                                        SizedBox(width: 15),
                                                        Text(
                                                          "đ${SahaStringUtils().convertToMoney(orderManageController.listAllOrder[indexState][index].lineItemsAtTime[0].afterDiscount)}",
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
                                  orderManageController
                                              .listAllOrder[indexState][index]
                                              .lineItemsAtTime
                                              .length >
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
                                          "${orderManageController.listAllOrder[indexState][index].lineItemsAtTime.length} sản phẩm",
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
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text("Thành tiền: "),
                                            Text(
                                              "đ${SahaStringUtils().convertToMoney(orderManageController.listAllOrder[indexState][index].totalFinal)}",
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
                                          "${orderManageController.listAllOrder[indexState][index].orderCode}",
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
                                                    "${orderManageController.listAllOrder[indexState][index].orderCode}"));
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
