import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/components/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/config_ui/app_theme_response.dart';
import 'package:sahashop_user/components/saha_user/empty_widget/saha_empty_customer_widget.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:sahashop_user/const/const_image_logo.dart';
import 'package:sahashop_user/model/box_chat_customer.dart';
import 'package:sahashop_user/screen/chat/chat_screen/chat_controller.dart';
import 'package:sahashop_user/screen/chat/chat_screen/chat_screen.dart';
import 'package:sahashop_user/screen/customer_manage/order_of_customer/order_of_customer_screen.dart';
import 'package:sahashop_user/utils/date_utils.dart';

import 'customer_manage_controller.dart';

// ignore: must_be_immutable
class CustomerManageScreen extends StatelessWidget {
  CustomerManageController customerManageController =
      CustomerManageController();
  ChatController? chatController;

  @override
  Widget build(BuildContext context) {
    customerManageController = CustomerManageController();
    chatController = Get.put(ChatController());

    RefreshController _refreshController = RefreshController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Khách hàng"),
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
              body = Obx(() => !customerManageController.isDoneLoadMore.value
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
          if (customerManageController.isDoneLoadMore.value) {
            customerManageController.loadMoreCustomer();
          }
          _refreshController.loadComplete();
        },
        child: Obx(
          () => customerManageController.isLoadInit.value
              ? SahaSimmer(
                  isLoading: true,
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    color: Colors.black,
                  ))
              : customerManageController.listInfoCustomer.isEmpty
                  ? SahaEmptyCustomerWidget(
                      width: 50,
                      height: 50,
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ...List.generate(
                            customerManageController.listInfoCustomer.length,
                            (index) => Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          imageUrl: customerManageController
                                                      .listInfoCustomer
                                                      .length ==
                                                  0
                                              ? ""
                                              : customerManageController
                                                      .listInfoCustomer[index]
                                                      .avatarImage ??
                                                  "",
                                          errorWidget: (context, url, error) =>
                                              SahaEmptyImage(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "Tên: ${customerManageController.listInfoCustomer[index].name ?? "'Chưa đặt tên'"} - ${customerManageController.listInfoCustomer[index].sex == 0 ? "Không xác định" : customerManageController.listInfoCustomer[index].sex == 1 ? "Nam" : "Nữ"}"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                "Phone: ${customerManageController.listInfoCustomer[index].phoneNumber ?? "'Chưa đặt tên'"}"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                "Email: ${customerManageController.listInfoCustomer[index].email ?? "'Chưa xác thực'"}"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                "Ngày sinh: ${customerManageController.listInfoCustomer[index].dateOfBirth ?? "'Chưa nhập'"} "),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                "Ngày tạo tài khoản: ${SahaDateUtils().getDDMMYY(DateTime.parse(customerManageController.listInfoCustomer[index].createdAt!.toIso8601String()))}")
                                          ],
                                        ),
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
                                          chatController!.boxChatCustomer
                                              .value = BoxChatCustomer(
                                            customerId: customerManageController
                                                .listInfoCustomer[index].id,
                                            customer: customerManageController
                                                .listInfoCustomer[index],
                                          );
                                          Get.to(() => ChatScreen())!.then(
                                              (value) => {
                                                    chatController!
                                                        .refreshDataMessage(),
                                                    chatController!
                                                        .refreshDataAllChat()
                                                  });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Center(
                                            child: Text(
                                              "Chat",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryTextTheme
                                                      .headline6!
                                                      .color),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                          "Điểm: ${customerManageController.listInfoCustomer[index].score}"),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => OrderOfCustomer(
                                                idCustomer:
                                                    customerManageController
                                                        .listInfoCustomer[index]
                                                        .id!,
                                              ));
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Center(
                                            child: Text(
                                              "Đơn hàng",
                                              style: TextStyle(
                                                  color: Theme.of(context)
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
                                Container(
                                  height: 8,
                                  color: Colors.grey[200],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
