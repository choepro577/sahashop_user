import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/components/saha_user/empty_widget/saha_empty_chat_widget.dart';
import 'package:sahashop_user/screen/chat/chat_screen/chat_controller.dart';
import 'package:sahashop_user/utils/string_utils.dart';
import 'package:shimmer/shimmer.dart';

import 'chat_screen.dart';

// ignore: must_be_immutable
class AllMessageScreen extends StatelessWidget {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ChatController? chatController;

  @override
  Widget build(BuildContext context) {
    chatController = Get.put(ChatController());
    chatController!.loadInitChatUser();

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => chatController!.isSearch.value
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
                if (chatController!.isSearch.value == false) {
                  chatController!.isSearch.value = true;
                } else {
                  chatController!.isSearch.value = false;
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
            LoadStatus? mode,
          ) {
            Widget? body;
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
            () => chatController!.isLoadingBoxChatCustomer.value == true
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
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
                : chatController!.listBoxChatCustomer.isEmpty
                    ? SahaEmptyChatWidget(
                        width: 50,
                        height: 50,
                      )
                    : Column(
                        children: [
                          ...List.generate(
                              chatController!.listBoxChatCustomer.length,
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
        chatController!.boxChatCustomer.value =
            chatController!.listBoxChatCustomer[index];
        Get.to(() => ChatScreen())!.then((value) => {
              chatController!.refreshDataMessage(),
              chatController!.refreshDataAllChat()
            });
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
                          imageUrl:
                              chatController!.listBoxChatCustomer.length == 0
                                  ? ""
                                  : chatController!.listBoxChatCustomer[index]
                                          .customer!.avatarImage ??
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
                            chatController!.listBoxChatCustomer.length == 0
                                ? chatController!.listBoxChatCustomer[index]
                                        .customer!.phoneNumber ??
                                    "Chưa đặt tên"
                                : chatController!.listBoxChatCustomer[index]
                                        .customer!.name ??
                                    "Chưa đặt tên",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: Get.width * 0.7,
                            child: Text(
                              chatController!.listBoxChatCustomer[index]
                                      .lastMessage!.content ??
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
                      SahaStringUtils().displayTimeAgoFromTime(chatController!
                          .listBoxChatCustomer[index].lastMessage!.createdAt!),
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
                  ),
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
