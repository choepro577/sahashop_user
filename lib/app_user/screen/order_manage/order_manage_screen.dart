import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_order.dart';
import 'package:sahashop_user/app_customer/screen/order_history/order_status_page/widget/order_loading_item_widget.dart';
import 'package:sahashop_user/app_customer/utils/color_utils.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/const/constant.dart';
import 'package:sahashop_user/app_user/screen/order_manage/order_detail_manage/order_detail_manage_screen.dart';
import 'package:sahashop_user/app_user/screen/order_manage/order_manage_controller.dart';
import 'package:sahashop_user/app_user/utils/string_utils.dart';

import 'widget/order_item_widget.dart';

class OrderManageScreen extends StatefulWidget {
  OrderManageScreen({Key? key}) : super(key: key);

  @override
  _OrderManageScreenState createState() => _OrderManageScreenState();
}

class _OrderManageScreenState extends State<OrderManageScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  OrderManageController? orderManageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderManageController = Get.put(OrderManageController());
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
                orderManageController!.listAllOrder.length, (int index) {
              return buildStateOrder(index);
            }),
          ),
        ),
      ),
    );
  }

  Widget buildStateOrder(int indexState) {
    RefreshController _refreshController = RefreshController(
        initialRefresh: orderManageController!.listCheckRefresh[indexState] == 1
            ? true
            : false);

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
            body = Obx(() => !orderManageController!.isDoneLoadMore.value
                ? CupertinoActivityIndicator()
                : Container());
          } else if (mode == LoadStatus.loading) {
            body = Obx(() => !orderManageController!.isDoneLoadMore.value
                ? CupertinoActivityIndicator()
                : Container());
          }
          return Container(
            height: 0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: () async {
        await orderManageController!.refreshData(
          "order_status_code",
          orderManageController!.listStatusCode[indexState],
          indexState,
        );
        // orderManageController!.refreshData();
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        if (orderManageController!.isDoneLoadMore.value) {
          await orderManageController!.loadMoreOrder(
            "order_status_code",
            orderManageController!.listStatusCode[indexState],
            indexState,
          );
        }
        _refreshController.loadComplete();
      },
      child: Obx(
        () => orderManageController!.isLoadInit.value
            ? ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) => OrderLoadingItemWidget())
            : SingleChildScrollView(
                child: orderManageController!.listCheckIsEmpty[indexState]
                    ? SahaEmptyOrder()
                    : Column(
                        children: [
                          ...List.generate(
                            orderManageController!
                                .listAllOrder[indexState].length,
                            (index) => OrderItemWidget(
                              order: orderManageController!
                                  .listAllOrder[indexState][index],
                              onTap: () {
                                Get.to(() => OrderDetailScreen(
                                      order: orderManageController!
                                          .listAllOrder[indexState][index],
                                      indexListOrder: index,
                                      indexStateOrder: indexState,
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
              ),
      ),
    );
  }
}
