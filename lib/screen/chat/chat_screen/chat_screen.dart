import 'dart:ui';

import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/components/saha_user/expanded_viewport/expanded_viewport.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/model/box_chat_customer.dart';
import 'package:sahashop_user/model/info_customer.dart';

import 'chat_controller.dart';

class ChatScreen extends StatelessWidget {
  Function onUpload;
  Function doneUpload;
  BoxChatCustomer boxChatCustomer;

  ChatScreen({this.boxChatCustomer}) {
    chatController = Get.put(ChatController(boxChatCustomer: boxChatCustomer));
    refreshController = RefreshController();
    scrollController = ScrollController();
  }

  ChatController chatController;
  ScrollController scrollController;
  RefreshController refreshController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Row(
            children: [
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: "",
                  width: 45,
                  height: 45,
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
                    "hieudeptrai",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Online 1 phút trước",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SmartRefresher(
                enablePullUp: true,
                footer: CustomFooter(
                  loadStyle: LoadStyle.ShowAlways,
                  builder: (context, mode) {
                    if (mode == LoadStatus.loading) {
                      return Container(
                        height: 60.0,
                        child: Container(
                          height: 20.0,
                          width: 20.0,
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    } else
                      return Container();
                  },
                ),
                onLoading: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  chatController.loadMoreMessage();
                  refreshController.loadComplete();
                },
                enablePullDown: false,
                child: Scrollable(
                  controller: scrollController,
                  axisDirection: AxisDirection.up,
                  viewportBuilder: (context, offset) {
                    return ExpandedViewport(
                      offset: offset,
                      axisDirection: AxisDirection.up,
                      slivers: <Widget>[
                        SliverExpanded(),
                        Obx(
                          () => SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (c, i) => itemMessage(i),
                                childCount: chatController.listMessage.length),
                          ),
                        )
                      ],
                    );
                  },
                ),
                controller: refreshController,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller:
                              chatController.messageEditingController.value,
                          onChanged: (v) {
                            chatController.messageEditingController.refresh();
                          },
                          cursorColor: Colors.grey,
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Gửi tin nhắn',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            chatController.loadAssets();
                          }),
                      SizedBox(
                        width: 5,
                      ),
                      Obx(() =>
                          chatController.messageEditingController.value.text !=
                                  ""
                              ? IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    scrollController.jumpTo(0.0);
                                    chatController.sendMessageToCustomer();
                                  })
                              : IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {}))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemMessage(int index) {
    return chatController.listMessage[index].isUser
        ? chatController.listMessage[index].linkImages != null
            ? chatController.listMessage[index].linkImages == ""
                ? Bubble(
                    borderUp: true,
                    margin: BubbleEdges.only(top: 10, left: 80, right: 5),
                    alignment: Alignment.topRight,
                    padding: BubbleEdges.only(bottom: 15),
                    nip: BubbleNip.rightTop,
                    elevation: 0,
                    color: Colors.transparent,
                    child: Obx(
                      () => Container(
                        height: chatController.dataImages.length == 1 ||
                                chatController.dataImages.length == 2
                            ? 110
                            : chatController.dataImages.length == 3 ||
                                    chatController.dataImages.length == 4
                                ? 210
                                : chatController.dataImages.length == 5 ||
                                        chatController.dataImages.length == 6
                                    ? 310
                                    : chatController.dataImages.length == 7 ||
                                            chatController.dataImages.length ==
                                                8
                                        ? 420
                                        : chatController.dataImages.length ==
                                                    9 ||
                                                chatController
                                                        .dataImages.length ==
                                                    10
                                            ? 510
                                            : 500,
                        child: Obx(() {
                          var dataImages = chatController.dataImages.toList();

                          if (dataImages == null || dataImages.length == 0)
                            return Container();

                          return Wrap(
                            children: [
                              ...List.generate(
                                  dataImages.length,
                                  (index) =>
                                      buildItemImageData(dataImages[index])),
                            ],
                          );
                        }),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Bubble(
                        borderUp: true,
                        margin: BubbleEdges.only(top: 10, left: 80, right: 5),
                        alignment: Alignment.topRight,
                        padding: BubbleEdges.only(bottom: 15),
                        nip: BubbleNip.rightTop,
                        elevation: 0,
                        color: Colors.transparent,
                        child: Obx(
                          () => Container(
                            height: chatController.allImageInMessage[index].length ==
                                        1 ||
                                    chatController
                                            .allImageInMessage[index].length ==
                                        2
                                ? 110
                                : chatController.allImageInMessage[index].length ==
                                            3 ||
                                        chatController.allImageInMessage[index]
                                                .length ==
                                            4
                                    ? 210
                                    : chatController.allImageInMessage[index]
                                                    .length ==
                                                5 ||
                                            chatController
                                                    .allImageInMessage[index]
                                                    .length ==
                                                6
                                        ? 310
                                        : chatController.allImageInMessage[index].length ==
                                                    7 ||
                                                chatController.allImageInMessage[index].length ==
                                                    8
                                            ? 420
                                            : chatController.allImageInMessage[index].length ==
                                                        9 ||
                                                    chatController
                                                            .allImageInMessage[index]
                                                            .length ==
                                                        10
                                                ? 510
                                                : 0,
                            child: Obx(
                              () {
                                var listLinkImages = chatController
                                    .allImageInMessage[index]
                                    .toList();

                                if (listLinkImages == null ||
                                    listLinkImages.length == 0)
                                  return Container();

                                return Wrap(
                                  children: [
                                    ...List.generate(
                                      listLinkImages.length,
                                      (index) => ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: CachedNetworkImage(
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                          imageUrl: listLinkImages[index] ?? "",
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            child: Icon(
                                              Icons.error,
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      chatController.listMessage[index].content == null
                          ? Container()
                          : Bubble(
                              borderUp: true,
                              margin:
                                  BubbleEdges.only(top: 10, left: 80, right: 5),
                              alignment: Alignment.topRight,
                              padding: BubbleEdges.all(15),
                              nip: BubbleNip.rightTop,
                              color: Color(0xff279f63),
                              child: Text(
                                  chatController.listMessage[index].content ??
                                      "",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.right),
                            )
                    ],
                  )
            : Bubble(
                borderUp: true,
                margin: BubbleEdges.only(top: 10, left: 80, right: 5),
                alignment: Alignment.topRight,
                padding: BubbleEdges.all(15),
                nip: BubbleNip.rightTop,
                color: Color(0xff279f63),
                child: Text(chatController.listMessage[index].content,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.right),
              )
        : Bubble(
            margin: BubbleEdges.only(top: 10, right: Get.width * 0.33, left: 5),
            padding: BubbleEdges.all(15),
            alignment: Alignment.topLeft,
            nip: BubbleNip.leftTop,
            child: Text(
              chatController.listMessage[index].content,
              style: TextStyle(fontSize: 16),
            ),
          );
  }

  Widget buildItemImageData(ImageData imageData) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Container(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: imageData.linkImage != null
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: imageData.linkImage,
                      placeholder: (context, url) => Stack(
                        children: [
                          imageData.file == null
                              ? Container()
                              : AssetThumb(
                                  asset: imageData.file,
                                  width: 300,
                                  height: 300,
                                  spinner: SahaLoadingWidget(
                                    size: 50,
                                  ),
                                ),
                          SahaLoadingWidget(),
                        ],
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : AssetThumb(
                      asset: imageData.file,
                      width: 300,
                      height: 300,
                      spinner: SahaLoadingWidget(
                        size: 50,
                      ),
                    )),
        ),
      ),
    );
  }
}
