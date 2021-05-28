import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/components/saha_user/expanded_viewport/expanded_viewport.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/model/chat_user.dart';
import 'package:sahashop_user/screen/chat/wiget/select_images_chat_controller.dart';

import 'chat_controller.dart';

class ChatScreen extends StatelessWidget {
  Function onUpload;
  Function doneUpload;
  ChatUser chatUser;

  ChatScreen({this.chatUser}) {
    chatController = ChatController(chatUser: chatUser);
    refreshController = RefreshController();
    scrollController = ScrollController();
    selectChatImageController = new SelectChatImageController(
        onUpload: onUpload, doneUpload: doneUpload);
  }

  SelectChatImageController selectChatImageController;
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
                            selectChatImageController.loadAssets();
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
        ? Bubble(
            borderUp: true,
            margin: BubbleEdges.only(top: 10, left: 80, right: 5),
            alignment: Alignment.topRight,
            padding: BubbleEdges.all(15),
            nip: BubbleNip.rightTop,
            color: Color(0xff279f63),
            child: Column(
              children: [
                chatController.listMessage[index].linkImages != null
                    ? Container(
                        height: 340,
                        width: 220,
                        child: Obx(() {
                          var dataImages =
                              selectChatImageController.dataImages.toList();

                          if (dataImages == null || dataImages.length == 0)
                            return Container();

                          return StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            itemCount: dataImages.length,
                            itemBuilder: (BuildContext context, int index) =>
                                buildItemImageData(dataImages[index]),
                            staggeredTileBuilder: (int index) =>
                                new StaggeredTile.fit(1),
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                          );
                        }),
                      )
                    : Container(),
                Text(chatController.listMessage[index].content,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.right),
              ],
            ),
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
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: imageData.linkImage != null
                      ? CachedNetworkImage(
                          height: 300,
                          width: 300,
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
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
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
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  selectChatImageController.deleteImage(imageData.file);
                },
                child: Container(
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      "x",
                      style: TextStyle(
                        fontSize: 10,
                        height: 1,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            imageData.uploading
                ? SahaLoadingWidget(
                    size: 50,
                  )
                : Container(),
            imageData.errorUpload ? Icon(Icons.error) : Container(),
          ],
        ),
      ),
    );
  }
}
