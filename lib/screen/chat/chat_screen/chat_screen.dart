import 'dart:ui';

import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/components/saha_user/expanded_viewport/expanded_viewport.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/utils/date_utils.dart';
import 'package:sahashop_user/utils/string_utils.dart';

import 'chat_controller.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  ChatScreen() {
    chatController = Get.find();
    refreshController = RefreshController();
    scrollController = ScrollController();
    chatController!.loadInitMessage();
  }

  ChatController? chatController;
  ScrollController? scrollController;
  late RefreshController refreshController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: chatController!
                          .boxChatCustomer.value.customer!.avatarImage ??
                      "",
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
                    "${chatController!.boxChatCustomer.value.customer!.name ?? "Chưa đặt tên"}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  chatController!.boxChatCustomer.value.lastMessage == null
                      ? Container()
                      : Text(
                          "${SahaStringUtils().displayTimeAgoFromTime(chatController!.boxChatCustomer.value.lastMessage!.createdAt!)}",
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
                  chatController!.loadMoreMessage();
                  refreshController.loadComplete();
                },
                enablePullDown: false,
                child: Scrollable(
                  controller: scrollController,
                  axisDirection: AxisDirection.up,
                  viewportBuilder: (context, offset) {
                    return ExpandedViewport(
                      offset: offset as ScrollPosition,
                      axisDirection: AxisDirection.up,
                      slivers: <Widget>[
                        SliverExpanded(),
                        Obx(
                          () => SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (c, i) => itemMessage(i, context),
                                childCount: chatController!.listMessage.length),
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
                              chatController!.messageEditingController.value,
                          onChanged: (v) {
                            chatController!.messageEditingController.refresh();
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
                            chatController!.loadAssets();
                          }),
                      SizedBox(
                        width: 5,
                      ),
                      Obx(() =>
                          chatController!.messageEditingController.value.text !=
                                  ""
                              ? IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    scrollController!.jumpTo(0.0);
                                    chatController!.sendMessageToCustomer();
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

  Widget itemMessage(int index, BuildContext context) {
    return chatController!.listMessage[index].isUser!
        ? chatController!.listMessage[index].linkImages != null
            ? chatController!.listMessage[index].linkImages == ""
                ? Bubble(
                    /// right is User
                    /// add image device
                    borderUp: true,
                    margin: BubbleEdges.only(top: 10, left: 80, right: 5),
                    alignment: Alignment.topRight,
                    padding: BubbleEdges.only(bottom: 15),
                    nip: BubbleNip.rightTop,
                    elevation: 0,
                    color: Colors.transparent,
                    child: Obx(
                      () => Container(
                          height: chatController!.listSaveDataImages[index]!.length ==
                                  1
                              ? Get.height * 0.3
                              : chatController!.listSaveDataImages[index]!.length ==
                                      2
                                  ? 100
                                  : chatController!.listSaveDataImages[index]!
                                                  .length ==
                                              3 ||
                                          chatController!
                                                  .listSaveDataImages[index]!
                                                  .length ==
                                              4
                                      ? 200
                                      : chatController!.listSaveDataImages[index]!.length == 5 ||
                                              chatController!.listSaveDataImages[index]!.length ==
                                                  6
                                          ? 300
                                          : chatController!.listSaveDataImages[index]!.length == 7 ||
                                                  chatController!.listSaveDataImages[index]!.length ==
                                                      8
                                              ? 400
                                              : chatController!.listSaveDataImages[index]!.length == 9 ||
                                                      chatController!
                                                              .listSaveDataImages[
                                                                  index]!
                                                              .length ==
                                                          10
                                                  ? 520
                                                  : 0,
                          child: buildItemImageData(
                              chatController!.listSaveDataImages[index]!, context)),
                    ),
                  )
                : Column(
                    /// get data image from sever
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
                            height: chatController!
                                        .allImageInMessage[index]!.length ==
                                    1
                                ? Get.height * 0.3
                                : chatController!.allImageInMessage[index]!.length ==
                                        2
                                    ? 100
                                    : chatController!.allImageInMessage[index]!
                                                    .length ==
                                                3 ||
                                            chatController!
                                                    .allImageInMessage[index]!
                                                    .length ==
                                                4
                                        ? 200
                                        : chatController!.allImageInMessage[index]!.length == 5 ||
                                                chatController!.allImageInMessage[index]!.length ==
                                                    6
                                            ? 300
                                            : chatController!.allImageInMessage[index]!.length ==
                                                        7 ||
                                                    chatController!
                                                            .allImageInMessage[
                                                                index]!
                                                            .length ==
                                                        8
                                                ? 400
                                                : chatController!.allImageInMessage[index]!.length ==
                                                            9 ||
                                                        chatController!
                                                                .allImageInMessage[index]!
                                                                .length ==
                                                            10
                                                    ? 520
                                                    : 0,
                            child: Obx(
                              () {
                                var listLinkImages = chatController!
                                    .allImageInMessage[index]!
                                    .toList();

                                if (listLinkImages == null ||
                                    listLinkImages.length == 0)
                                  return Container();

                                return Wrap(
                                  children: [
                                    ...List.generate(
                                      listLinkImages.length,
                                      (index) => InkWell(
                                        onTap: () {
                                          seeImage(
                                              listImageUrl: listLinkImages,
                                              index: index);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: CachedNetworkImage(
                                                height:
                                                    listLinkImages.length == 1
                                                        ? Get.height * 0.3
                                                        : 100,
                                                width:
                                                    listLinkImages.length == 1
                                                        ? Get.width * 0.4
                                                        : 100,
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    listLinkImages[index] ?? "",
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                  child: Icon(
                                                    Icons.error,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                              ),
                                            ),
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
                      chatController!.listMessage[index].content == null
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
                                  chatController!.listMessage[index].content ??
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
                child: Text(chatController!.listMessage[index].content!,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left),
              )
        : chatController!.listMessage[index].linkImages != null

            /// left is Customer
            ? Column(
                /// get image from customer
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  chatController!.listMessage[index].createdAt!.day -
                              chatController!
                                  .listMessage[(index + 1) >=
                                          chatController!.listMessage.length
                                      ? index
                                      : index + 1]
                                  .createdAt!
                                  .day >=
                          1
                      ? SizedBox(
                          height: 70,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              chatController!.timeNow.value.day -
                                          chatController!
                                              .listMessage[(index + 1) >=
                                                      chatController!
                                                          .listMessage.length
                                                  ? index
                                                  : index + 1]
                                              .createdAt!
                                              .day >
                                      1
                                  ? Bubble(
                                      margin: BubbleEdges.only(top: 10),
                                      alignment: Alignment.center,
                                      nip: BubbleNip.no,
                                      color: Color.fromRGBO(212, 234, 244, 1.0),
                                      child: Text(
                                          "${SahaDateUtils().getDDMM(chatController!.listMessage[index + 1].createdAt!)}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11.0,
                                          )),
                                    )
                                  : Bubble(
                                      margin: BubbleEdges.only(top: 10),
                                      alignment: Alignment.center,
                                      nip: BubbleNip.no,
                                      color: Color.fromRGBO(212, 234, 244, 1.0),
                                      child: Text('Hôm qua',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11.0,
                                          )),
                                    )
                            ],
                          ),
                        )
                      : chatController!.listMessage[index].createdAt!.minute -
                                  chatController!
                                      .listMessage[(index + 1) >=
                                              chatController!.listMessage.length
                                          ? index
                                          : index + 1]
                                      .createdAt!
                                      .minute >
                              2
                          ? SizedBox(
                              height: 50,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 22,
                                  ),
                                  Text(
                                      "${SahaDateUtils().getHHMM(chatController!.listMessage[index].createdAt!)}"),
                                ],
                              ),
                            )
                          : SizedBox(),
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
                        height: chatController!.allImageInMessage[index]!.length ==
                                1
                            ? Get.height * 0.3
                            : chatController!.allImageInMessage[index]!.length ==
                                    2
                                ? 100
                                : chatController!.allImageInMessage[index]!.length == 3 ||
                                        chatController!
                                                .allImageInMessage[index]!
                                                .length ==
                                            4
                                    ? 200
                                    : chatController!.allImageInMessage[index]!
                                                    .length ==
                                                5 ||
                                            chatController!
                                                    .allImageInMessage[index]!
                                                    .length ==
                                                6
                                        ? 300
                                        : chatController!.allImageInMessage[index]!.length == 7 ||
                                                chatController!
                                                        .allImageInMessage[
                                                            index]!
                                                        .length ==
                                                    8
                                            ? 400
                                            : chatController!.allImageInMessage[index]!.length ==
                                                        9 ||
                                                    chatController!
                                                            .allImageInMessage[index]!
                                                            .length ==
                                                        10
                                                ? 520
                                                : 0,
                        child: Obx(
                          () {
                            var listLinkImages = chatController!
                                .allImageInMessage[index]!
                                .toList();

                            if (listLinkImages == null ||
                                listLinkImages.length == 0) return Container();

                            return Wrap(
                              children: [
                                ...List.generate(
                                  listLinkImages.length,
                                  (index) => InkWell(
                                    onTap: () {
                                      seeImage(
                                          listImageUrl: listLinkImages,
                                          index: index);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: CachedNetworkImage(
                                            height: listLinkImages.length == 1
                                                ? Get.height * 0.3
                                                : 100,
                                            width: listLinkImages.length == 1
                                                ? Get.width * 0.4
                                                : 100,
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                listLinkImages[index] ?? "",
                                            errorWidget:
                                                (context, url, error) =>
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
                  chatController!.listMessage[index].content == null
                      ? Container()
                      : Bubble(
                          borderUp: true,
                          margin: BubbleEdges.only(top: 10, right: 80, left: 5),
                          alignment: Alignment.topLeft,
                          padding: BubbleEdges.all(15),
                          nip: BubbleNip.leftTop,
                          color: Color(0xff279f63),
                          child: Text(
                              chatController!.listMessage[index].content ?? "",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left),
                        ),
                ],
              )
            : Bubble(
                borderUp: true,
                margin: BubbleEdges.only(top: 10, right: 80, left: 5),
                alignment: Alignment.topLeft,
                padding: BubbleEdges.all(15),
                nip: BubbleNip.leftTop,
                color: Color(0xff279f63),
                child: Text(chatController!.listMessage[index].content!,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left),
              );
  }

  Widget buildItemImageData(
      List<ImageData> listImageData, BuildContext context) {
    var listImage = listImageData.map((e) => e.linkImage).toList();
    return Wrap(
      children: [
        ...List.generate(
          listImageData.length,
          (index) => InkWell(
            onTap: () {
              seeImage(listImageUrl: listImage, index: index);
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: listImageData[index].linkImage != null
                      ? Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)),
                          child: CachedNetworkImage(
                            height: listImageData.length == 1
                                ? Get.height * 0.3
                                : 100,
                            width: listImageData.length == 1
                                ? Get.width * 0.4
                                : 100,
                            fit: BoxFit.cover,
                            imageUrl: listImageData[index].linkImage ?? "",
                            placeholder: (context, url) => Stack(
                              children: [
                                listImageData[index].file == null
                                    ? Container()
                                    : AssetThumb(
                                        asset: listImageData[index].file!,
                                        height: listImageData.length == 1
                                            ? int.parse((Get.height * 0.3)
                                                .toStringAsFixed(0))
                                            : 100,
                                        width: listImageData.length == 1
                                            ? int.parse((Get.width * 0.4)
                                                .toStringAsFixed(0))
                                            : 100,
                                        spinner: SahaLoadingWidget(
                                          size: 50,
                                        ),
                                      ),
                                SahaLoadingWidget(),
                              ],
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        )
                      : AssetThumb(
                          asset: listImageData[index].file!,
                          height: listImageData.length == 1
                              ? int.parse((Get.height * 0.3).toStringAsFixed(0))
                              : 100,
                          width: listImageData.length == 1
                              ? int.parse((Get.width * 0.4).toStringAsFixed(0))
                              : 100,
                          spinner: SahaLoadingWidget(
                            size: 50,
                          ),
                        )),
            ),
          ),
        ),
      ],
    );
  }

  void seeImage({
    List<dynamic>? listImageUrl,
    int? index,
  }) {
    PageController _pageController = PageController(initialPage: index!);
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Container(
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                pageController: _pageController,
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    minScale: 0.0,
                    imageProvider: NetworkImage(listImageUrl![index] ?? ""),
                    initialScale: PhotoViewComputedScale.contained * 1,
                    heroAttributes: PhotoViewHeroAttributes(
                        tag: listImageUrl[index] ?? "error$index"),
                  );
                },
                itemCount: listImageUrl!.length,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CupertinoActivityIndicator(),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                ),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  },
                  color: Colors.white,
                ),
              ),
              top: 60,
              right: 20,
            )
          ],
        );
      },
    );
  }
}
