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

import 'chat_customer_controller.dart';

class ChatCustomerScreen extends StatelessWidget {
  ChatCustomerScreen() {
    chatCustomerController = Get.put(ChatCustomerController());
    refreshController = RefreshController();
    scrollController = ScrollController();
    chatCustomerController.loadInitMessage();
  }

  ChatCustomerController chatCustomerController;
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
                  chatCustomerController.loadMoreMessage();
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
                                (c, i) => Column(
                                      children: [
                                        itemMessage(i),
                                        SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ),
                                childCount:
                                    chatCustomerController.listMessage.length),
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
                          controller: chatCustomerController
                              .messageEditingController.value,
                          onChanged: (v) {
                            chatCustomerController.messageEditingController
                                .refresh();
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
                            chatCustomerController.loadAssets();
                          }),
                      SizedBox(
                        width: 5,
                      ),
                      Obx(() => chatCustomerController
                                  .messageEditingController.value.text !=
                              ""
                          ? IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                scrollController.jumpTo(0.0);
                                chatCustomerController.sendMessageToUser();
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
    return chatCustomerController.listMessage[index].isUser == false
        ? chatCustomerController.listMessage[index].linkImages != null
            ? chatCustomerController.listMessage[index].linkImages == ""
                ? Bubble(
                    /// add image from device
                    borderUp: true,
                    margin: BubbleEdges.only(top: 10, left: 80, right: 5),
                    alignment: Alignment.topRight,
                    padding: BubbleEdges.only(bottom: 15),
                    nip: BubbleNip.rightTop,
                    elevation: 0,
                    color: Colors.transparent,
                    child: Obx(
                      () => Container(
                        height:
                            chatCustomerController.listSaveDataImages.length ==
                                        1 ||
                                    chatCustomerController
                                            .listSaveDataImages.length ==
                                        2
                                ? 110
                                : chatCustomerController
                                                .listSaveDataImages.length ==
                                            3 ||
                                        chatCustomerController
                                                .listSaveDataImages.length ==
                                            4
                                    ? 210
                                    : chatCustomerController.listSaveDataImages
                                                    .length ==
                                                5 ||
                                            chatCustomerController
                                                    .listSaveDataImages
                                                    .length ==
                                                6
                                        ? 310
                                        : chatCustomerController
                                                        .listSaveDataImages
                                                        .length ==
                                                    7 ||
                                                chatCustomerController
                                                        .listSaveDataImages
                                                        .length ==
                                                    8
                                            ? 420
                                            : chatCustomerController
                                                            .listSaveDataImages
                                                            .length ==
                                                        9 ||
                                                    chatCustomerController
                                                            .listSaveDataImages
                                                            .length ==
                                                        10
                                                ? 510
                                                : 500,
                        child: Obx(() {
                          var dataImages = chatCustomerController
                              .listSaveDataImages
                              .toList();

                          if (dataImages == null || dataImages.length == 0)
                            return Container();

                          return buildItemImageData(dataImages[index]);
                        }),
                      ),
                    ),
                  )
                : Column(
                    /// get Image from Sever
                    children: [
                      Bubble(
                        borderUp: true,
                        margin: BubbleEdges.only(top: 10, left: 90, right: 0),
                        alignment: Alignment.topRight,
                        padding: BubbleEdges.only(bottom: 15),
                        nip: BubbleNip.rightTop,
                        elevation: 0,
                        color: Colors.transparent,
                        child: Obx(
                          () => Container(
                            height: chatCustomerController.allImageInMessage[index].length == 1 ||
                                    chatCustomerController
                                            .allImageInMessage[index].length ==
                                        2
                                ? 85
                                : chatCustomerController.allImageInMessage[index].length == 3 ||
                                        chatCustomerController
                                                .allImageInMessage[index]
                                                .length ==
                                            4
                                    ? 190
                                    : chatCustomerController
                                                    .allImageInMessage[index]
                                                    .length ==
                                                5 ||
                                            chatCustomerController
                                                    .allImageInMessage[index]
                                                    .length ==
                                                6
                                        ? 290
                                        : chatCustomerController.allImageInMessage[index].length == 7 ||
                                                chatCustomerController.allImageInMessage[index].length ==
                                                    8
                                            ? 390
                                            : chatCustomerController.allImageInMessage[index].length ==
                                                        9 ||
                                                    chatCustomerController
                                                            .allImageInMessage[index]
                                                            .length ==
                                                        10
                                                ? 490
                                                : 0,
                            child: Obx(
                              () {
                                var listLinkImages = chatCustomerController
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
                      chatCustomerController.listMessage[index].content == null
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
                                  chatCustomerController
                                          .listMessage[index].content ??
                                      "",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left),
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
                child: Text(chatCustomerController.listMessage[index].content,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left),
              )
        : chatCustomerController.listMessage[index].linkImages != null
            ? Column(
                children: [
                  Bubble(
                    borderUp: true,
                    margin: BubbleEdges.only(
                        top: 10, right: Get.width * 0.33, left: 0),
                    alignment: Alignment.topLeft,
                    padding: BubbleEdges.only(bottom: 15),
                    nip: BubbleNip.leftTop,
                    elevation: 0,
                    color: Colors.transparent,
                    child: Obx(
                      () => Container(
                        height: chatCustomerController.allImageInMessage[index].length == 1 ||
                                chatCustomerController.allImageInMessage[index].length ==
                                    2
                            ? 85
                            : chatCustomerController.allImageInMessage[index].length == 3 ||
                                    chatCustomerController
                                            .allImageInMessage[index].length ==
                                        4
                                ? 190
                                : chatCustomerController
                                                .allImageInMessage[index]
                                                .length ==
                                            5 ||
                                        chatCustomerController
                                                .allImageInMessage[index]
                                                .length ==
                                            6
                                    ? 290
                                    : chatCustomerController
                                                    .allImageInMessage[index]
                                                    .length ==
                                                7 ||
                                            chatCustomerController
                                                    .allImageInMessage[index]
                                                    .length ==
                                                8
                                        ? 390
                                        : chatCustomerController.allImageInMessage[index].length == 9 ||
                                                chatCustomerController
                                                        .allImageInMessage[index]
                                                        .length ==
                                                    10
                                            ? 490
                                            : 0,
                        child: Obx(
                          () {
                            var listLinkImages = chatCustomerController
                                .allImageInMessage[index]
                                .toList();

                            if (listLinkImages == null ||
                                listLinkImages.length == 0) return Container();

                            return Wrap(
                              children: [
                                ...List.generate(
                                  listLinkImages.length,
                                  (index) => ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
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
                                            border:
                                                Border.all(color: Colors.grey),
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
                  chatCustomerController.listMessage[index].content == null
                      ? Container()
                      : Bubble(
                          borderUp: true,
                          margin: BubbleEdges.only(top: 10, right: 80, left: 5),
                          alignment: Alignment.topLeft,
                          padding: BubbleEdges.all(15),
                          nip: BubbleNip.leftTop,
                          color: Color(0xff279f63),
                          child: Text(
                              chatCustomerController
                                      .listMessage[index].content ??
                                  "",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left),
                        )
                ],
              )
            : Bubble(
                borderUp: true,
                margin: BubbleEdges.only(top: 10, right: 80, left: 5),
                alignment: Alignment.topLeft,
                padding: BubbleEdges.all(15),
                nip: BubbleNip.leftTop,
                color: Color(0xff279f63),
                child: Text(chatCustomerController.listMessage[index].content,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left),
              );
  }

  Widget buildItemImageData(List<ImageData> listImageData) {
    return Wrap(
      children: [
        ...List.generate(
          listImageData.length,
          (index) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              height: 100,
              width: 100,
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: listImageData[index].linkImage != null
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: listImageData[index].linkImage,
                            placeholder: (context, url) => Stack(
                              children: [
                                listImageData[index].file == null
                                    ? Container()
                                    : AssetThumb(
                                        asset: listImageData[index].file,
                                        width: 300,
                                        height: 300,
                                        spinner: SahaLoadingWidget(
                                          size: 50,
                                        ),
                                      ),
                                SahaLoadingWidget(),
                              ],
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                        : AssetThumb(
                            asset: listImageData[index].file,
                            width: 300,
                            height: 300,
                            spinner: SahaLoadingWidget(
                              size: 50,
                            ),
                          )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
