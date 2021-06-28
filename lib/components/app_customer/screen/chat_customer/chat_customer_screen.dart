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

import 'chat_customer_controller.dart';

// ignore: must_be_immutable
class ChatCustomerScreen extends StatelessWidget {
  ChatCustomerScreen() {
    chatCustomerController = Get.put(ChatCustomerController());
    refreshController = RefreshController();
    scrollController = ScrollController();
  }

  late ChatCustomerController chatCustomerController;
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
            children: [
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl:
                      "${chatCustomerController.configController.configApp.logoUrl ?? ""}",
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
                    "${chatCustomerController.homeController.storeCurrent!.value.name ?? ""}",
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
                      offset: offset as ScrollPosition,
                      axisDirection: AxisDirection.up,
                      slivers: <Widget>[
                        SliverExpanded(),
                        Obx(
                          () => SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (c, i) => itemMessage(i, context),
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
                                scrollController!.jumpTo(0.0);
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

  Widget itemMessage(int index, BuildContext context) {
    return chatCustomerController.listMessage[index].isUser == false
        ? chatCustomerController.listMessage[index].linkImages != null
            ? chatCustomerController.listMessage[index].linkImages == ""
                ? Bubble(
                    /// right is Customer
                    /// add image from device Customer
                    borderUp: true,
                    margin: BubbleEdges.only(top: 10, left: 80, right: 5),
                    alignment: Alignment.topRight,
                    padding: BubbleEdges.only(bottom: 15),
                    nip: BubbleNip.rightTop,
                    elevation: 0,
                    color: Colors.transparent,
                    child: Obx(
                      () => Container(
                          height: chatCustomerController
                                      .listSaveDataImages[index]!.length ==
                                  1
                              ? Get.height * 0.3
                              : chatCustomerController.listSaveDataImages[index]!.length ==
                                      2
                                  ? 100
                                  : chatCustomerController
                                                  .listSaveDataImages[index]!
                                                  .length ==
                                              3 ||
                                          chatCustomerController
                                                  .listSaveDataImages[index]!
                                                  .length ==
                                              4
                                      ? 200
                                      : chatCustomerController.listSaveDataImages[index]!.length == 5 ||
                                              chatCustomerController.listSaveDataImages[index]!.length ==
                                                  6
                                          ? 300
                                          : chatCustomerController.listSaveDataImages[index]!.length == 7 ||
                                                  chatCustomerController
                                                          .listSaveDataImages[
                                                              index]!
                                                          .length ==
                                                      8
                                              ? 400
                                              : chatCustomerController.listSaveDataImages[index]!.length == 9 ||
                                                      chatCustomerController
                                                              .listSaveDataImages[index]!
                                                              .length ==
                                                          10
                                                  ? 520
                                                  : 0,
                          child: buildItemImageData(chatCustomerController.listSaveDataImages[index]!, context)),
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
                            height: chatCustomerController
                                        .allImageInMessage[index]!.length ==
                                    1
                                ? Get.height * 0.3
                                : chatCustomerController.allImageInMessage[index]!.length ==
                                        2
                                    ? 100
                                    : chatCustomerController
                                                    .allImageInMessage[index]!
                                                    .length ==
                                                3 ||
                                            chatCustomerController
                                                    .allImageInMessage[index]!
                                                    .length ==
                                                4
                                        ? 200
                                        : chatCustomerController.allImageInMessage[index]!.length == 5 ||
                                                chatCustomerController.allImageInMessage[index]!.length ==
                                                    6
                                            ? 300
                                            : chatCustomerController.allImageInMessage[index]!.length == 7 ||
                                                    chatCustomerController
                                                            .allImageInMessage[
                                                                index]!
                                                            .length ==
                                                        8
                                                ? 400
                                                : chatCustomerController.allImageInMessage[index]!.length == 9 ||
                                                        chatCustomerController
                                                                .allImageInMessage[index]!
                                                                .length ==
                                                            10
                                                    ? 520
                                                    : 0,
                            child: Obx(
                              () {
                                var listLinkImages = chatCustomerController
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
                child: Text(chatCustomerController.listMessage[index].content!,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left),
              )
        : chatCustomerController.listMessage[index].linkImages != null
            ? Column(
                /// left is User
                /// get image from User
                children: [
                  chatCustomerController.listMessage[index].createdAt!.day -
                              chatCustomerController
                                  .listMessage[(index + 1) >=
                                          chatCustomerController
                                              .listMessage.length
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
                              chatCustomerController.timeNow.value.day -
                                          chatCustomerController
                                              .listMessage[(index + 1) >=
                                                      chatCustomerController
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
                                          "${SahaDateUtils().getDDMM(chatCustomerController.listMessage[index + 1].createdAt!)}",
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
                      : chatCustomerController
                                      .listMessage[index].createdAt!.minute -
                                  chatCustomerController
                                      .listMessage[(index + 1) >=
                                              chatCustomerController
                                                  .listMessage.length
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
                                      "${SahaDateUtils().getHHMM(chatCustomerController.listMessage[index].createdAt!)}"),
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
                        height: chatCustomerController
                                    .allImageInMessage[index]!.length ==
                                1
                            ? Get.height * 0.3
                            : chatCustomerController.allImageInMessage[index]!.length ==
                                    2
                                ? 100
                                : chatCustomerController.allImageInMessage[index]!.length == 3 ||
                                        chatCustomerController
                                                .allImageInMessage[index]!
                                                .length ==
                                            4
                                    ? 200
                                    : chatCustomerController
                                                    .allImageInMessage[index]!
                                                    .length ==
                                                5 ||
                                            chatCustomerController
                                                    .allImageInMessage[index]!
                                                    .length ==
                                                6
                                        ? 300
                                        : chatCustomerController.allImageInMessage[index]!.length == 7 ||
                                                chatCustomerController.allImageInMessage[index]!.length ==
                                                    8
                                            ? 400
                                            : chatCustomerController.allImageInMessage[index]!.length == 9 ||
                                                    chatCustomerController
                                                            .allImageInMessage[index]!
                                                            .length ==
                                                        10
                                                ? 520
                                                : 0,
                        child: Obx(
                          () {
                            var listLinkImages = chatCustomerController
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
                child: Text(chatCustomerController.listMessage[index].content!,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left),
              );
  }

  Widget buildItemImageData(
      List<ImageData> listImageData, BuildContext context) {
    var listImageUrl = listImageData.map((e) => e.linkImage).toList();
    return Wrap(
      children: [
        ...List.generate(
          listImageData.length,
          (index) => InkWell(
            onTap: () {
              seeImage(listImageUrl: listImageUrl, index: index);
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
