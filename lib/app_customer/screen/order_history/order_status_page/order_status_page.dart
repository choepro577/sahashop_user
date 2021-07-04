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
                            ),
                          ),
                        ],
                      ),
              ),
      ),
    );
  }
}
