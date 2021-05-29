import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/screen/chat/all_message_user_controller.dart';
import 'package:sahashop_user/utils/string_utils.dart';
import 'package:shimmer/shimmer.dart';

import 'chat_screen/chat_screen.dart';

class AllMessageScreen extends StatelessWidget {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  AllMessageUserController allMessageUserController =
      AllMessageUserController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => allMessageUserController.isSearch.value
              ? Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey[100],
                  ),
                  child: TextField(
                    style: TextStyle(fontSize: 14),
                    autofocus: true,
                    decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Search"),
                    minLines: 1,
                    maxLines: 1,
                  ),
                )
              : Text('Chat'),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                if (allMessageUserController.isSearch.value == false) {
                  allMessageUserController.isSearch.value = true;
                } else {
                  allMessageUserController.isSearch.value = false;
                }
              }),
        ],
      ),
      body: SmartRefresher(
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
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("Đã hết Voucher kết thúc");
            } else {
              body = Text("Đã xem hết Voucher");
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
          _refreshController.refreshCompleted();
        },
        onLoading: () async {
          await Future.delayed(Duration(milliseconds: 300));
          _refreshController.loadComplete();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => allMessageUserController.isLoadingMessage.value == true
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.white,
                    enabled: true,
                    child: Column(
                      children: [
                        ...List.generate(
                            15,
                            (index) => Column(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      height: 80,
                                      width: Get.width,
                                    ),
                                    Divider(
                                      height: 1,
                                    )
                                  ],
                                ))
                      ],
                    ),
                  )
                : allMessageUserController.listBoxChatCustomer.isEmpty
                    ? Text("khong co user")
                    : Column(
                        children: [
                          ...List.generate(
                              allMessageUserController
                                  .listBoxChatCustomer.length,
                              (index) => itemChatUser(index))
                        ],
                      ),
          ),
        ),
      ),
    );
  }

  Widget itemChatUser(int index) {
    return InkWell(
      onTap: () {
        Get.to(() => ChatScreen(
              boxChatCustomer:
                  allMessageUserController.listBoxChatCustomer[index],
            ));
      },
      child: Column(
        children: [
          Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'More',
                color: Colors.black45,
                icon: Icons.more_horiz,
                onTap: () => {},
              ),
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => {},
              ),
            ],
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl: allMessageUserController
                                      .listBoxChatCustomer.length ==
                                  0
                              ? ""
                              : allMessageUserController
                                      .listBoxChatCustomer[index]
                                      .customer
                                      .avatarImage ??
                                  "",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/saha_loading.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(3000),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            allMessageUserController
                                        .listBoxChatCustomer.length ==
                                    0
                                ? allMessageUserController
                                    .listBoxChatCustomer[index]
                                    .customer
                                    .phoneNumber
                                : allMessageUserController
                                    .listBoxChatCustomer[index].customer.name,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: Get.width * 0.7,
                            child: Text(
                              allMessageUserController
                                      .listBoxChatCustomer[index]
                                      .lastMessage
                                      .content ??
                                  "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    right: 10,
                    top: 0,
                    child: Text(
                      SahaStringUtils().displayTimeAgoFromTime(
                          allMessageUserController.listBoxChatCustomer[index]
                              .lastMessage.createdAt),
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
