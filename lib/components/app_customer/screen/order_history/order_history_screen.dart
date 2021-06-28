import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/components/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/components/app_customer/screen/cart_screen/cart_screen_1.dart';
import 'package:sahashop_user/components/app_customer/screen/order_history/order_history_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/order_history/order_history_detail/order_detail_history_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/pay_screen/pay_screen.dart';
import 'package:sahashop_user/components/app_customer/utils/color_utils.dart';
import 'package:sahashop_user/components/app_customer/screen/review/review_screen.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:sahashop_user/const/const_image_logo.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/utils/string_utils.dart';

import 'order_status_page/order_status_page.dart';

class OrderHistoryScreen extends StatefulWidget {
  final int? initPage;

  OrderHistoryScreen({Key? key, this.initPage}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Đơn mua'),
          bottom: TabBar(
            isScrollable: true,
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
        body: PageStorage(
          bucket: bucket,
          child: TabBarView(children: [
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: WAITING_FOR_PROGRESSING,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: PACKING,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: SHIPPING,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: COMPLETED,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: OUT_OF_STOCK,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: USER_CANCELLED,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: CUSTOMER_CANCELLED,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: DELIVERY_ERROR,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: CUSTOMER_RETURNING,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: CUSTOMER_HAS_RETURNS,
            ),
          ]),
        ),
      ),
    );
  }
}
