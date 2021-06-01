import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/response-request/chat/send_message_request.dart';
import 'package:sahashop_user/data/remote/response-request/chat/send_message_response.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/data/socket/socket.dart';
import 'package:sahashop_user/model/box_chat_customer.dart';
import 'package:sahashop_user/model/message.dart';
import 'package:sahashop_user/saha_data_controller.dart';
import 'package:sahashop_user/utils/image_utils.dart';
import 'package:flutter/material.dart';

class ChatController extends GetxController {
  var isLoadingBoxChatCustomer = false.obs;
  var listBoxChatCustomer = RxList<BoxChatCustomer>();
  var pageLoadMoreBoxChatCustomer = 1;
  var isEndPageBoxChatCustomer = false;
  var isSearch = false.obs;
  var unread = 0.obs;
  var limitedSocket = 0.obs;

  SahaDataController sahaDataController = Get.find();

  @override
  void onInit() {
    refreshWhenRealtime();
    super.onInit();
  }

  @override
  void onClose() {
    // SocketUser().close();
    super.onClose();
  }

  void refreshWhenRealtime() {
    timeNow.value = DateTime.now();
    sahaDataController.unread.listen((unread) {
      if (unread != 0) {
        refreshDataAllChat();
      }
    });
  }

  // ChatController() {
  //   loadInitChatUser();
  // }

  void loadInitChatUser() {
    pageLoadMoreBoxChatCustomer = 1;
    isEndPageBoxChatCustomer = false;
    loadMoreChatUser();
  }

  Future<void> loadMoreChatUser() async {
    isLoadingBoxChatCustomer.value = true;
    try {
      var res =
          await RepositoryManager.chatRepository.getAllChatUser(pageLoadMore);
      if (res.data.data == []) {
        isEndPageBoxChatCustomer = true;
      } else {
        listBoxChatCustomer.addAll(res.data.data);
        pageLoadMoreBoxChatCustomer++;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingBoxChatCustomer.value = false;
  }

  void refreshDataAllChat() {
    listBoxChatCustomer([]);
    loadInitChatUser();
  }

////////////////////////////////////////////////////////////

  var boxChatCustomer = BoxChatCustomer().obs;

  var messageEditingController = new TextEditingController(text: "").obs;
  var pageLoadMore = 1;
  var isEndPageCombo = false;
  var listMessage = RxList<Message>();
  var allImageInMessage = RxList<List<dynamic>>();
  var listImageResponse = [];
  var listImageRequest = [];
  var listSaveDataImages = RxList<List<ImageData>>();
  var timeNow = DateTime.now().obs;

  void loadInitMessage() {
    pageLoadMore = 1;
    isEndPageCombo = false;
    loadMoreMessage();
    getDataMessageCustomer();
  }

  void getDataMessageCustomer() {
    SocketUser().listenCustomerWithId(boxChatCustomer.value.customerId, (data) {
      timeNow.value = DateTime.now();
      limitedSocket.value++;
      if (limitedSocket.value == 1) {
        print("------------------------------$data");
        listSaveDataImages.add([]);
        listMessage.insert(0, Message.fromJson(data));
        try {
          var listImage = (jsonDecode(listMessage[0].linkImages));
          allImageInMessage.insert(0, listImage);
        } catch (err) {
          allImageInMessage.insert(0, [listMessage[0].linkImages]);
        }
      }
      Future.delayed(Duration(seconds: 1), () {
        limitedSocket.value = 0;
      });
    });
  }

  Future<void> loadMoreMessage() async {
    timeNow.value = DateTime.now();
    try {
      if (!isEndPageCombo) {
        var res = await RepositoryManager.chatRepository
            .getAllMessageUser(boxChatCustomer.value.customerId, pageLoadMore);
        listMessage.addAll(res.data.data);

        listMessage.forEach((e) {
          listSaveDataImages.add([]);
          allImageInMessage.add([]);
        });

        for (int i = 0; i < listMessage.length; i++) {
          try {
            var listImage = (jsonDecode(listMessage[i].linkImages));

            allImageInMessage[i] = listImage.toList();
          } catch (err) {
            allImageInMessage[i] = [listMessage[i].linkImages];
          }
        }
        // print(allImageInMessage);

        if (res.data.nextPageUrl != null) {
          pageLoadMore++;
          isEndPageCombo = false;
        } else {
          isEndPageCombo = true;
        }
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void refreshDataMessage() {
    messageEditingController.value.text = "";
    pageLoadMore = 1;
    isEndPageCombo = false;
    listMessage([]);
    allImageInMessage([]);
    listImageResponse = [];
    listImageRequest = [];
    listSaveDataImages([]);
    timeNow.value = DateTime.now();
  }

  Future<SendMessageResponse> sendMessageToCustomer() async {
    timeNow.value = DateTime.now();
    try {
      listSaveDataImages.insert(0, null);
      allImageInMessage.insert(0, null);
      listMessage.insert(
          0,
          Message(
            isUser: true,
            content: messageEditingController.value.text,
            createdAt: timeNow.value,
          ));
      var res = await RepositoryManager.chatRepository.sendMessageToCustomer(
          boxChatCustomer.value.customerId,
          SendMessageRequest(
            content: messageEditingController.value.text,
          ));

      //   print(allImageInMessage);
      messageEditingController.value.text = "";
      messageEditingController.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<SendMessageResponse> sendImageToCustomer() async {
    timeNow.value = DateTime.now();
    try {
      listSaveDataImages.insert(0, dataImages);
      allImageInMessage.insert(0, null);
      listMessage.insert(
          0,
          Message(
            isUser: true,
            linkImages: "",
            createdAt: timeNow.value,
          ));
      var res = await RepositoryManager.chatRepository.sendMessageToCustomer(
          boxChatCustomer.value.customerId,
          SendMessageRequest(
            linkImages: jsonEncode(listImageRequest),
          ));
      // print(allImageInMessage);
      messageEditingController.value.text = "";
      messageEditingController.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  var MAX_SELECT = 10;
  var dataImages = <ImageData>[];

  void updateListImage(List<Asset> listAsset) {
    // print(listAsset);
    //  onUpload();

    var listPre = dataImages.toList();
    var newList = <ImageData>[];

    for (var asset in listAsset) {
      var dataPre = listPre.firstWhere((itemPre) => itemPre.file == asset,
          orElse: () => null);

      if (dataPre != null) {
        newList.add(dataPre);
      } else {
        newList.add(ImageData(
            file: asset,
            linkImage: null,
            errorUpload: false,
            uploading: false));
      }
    }
    dataImages = newList;

    uploadListImage();
  }

  void uploadListImage() async {
    int stackComplete = 0;

    var responses = await Future.wait(dataImages.map((imageData) {
      if (imageData.linkImage == null) {
        return uploadImageData(
            indexImage: dataImages.indexOf(imageData),
            onOK: () {
              stackComplete++;
            });
      } else
        return Future.value(null);
    }));

    //  doneUpload(dataImages.toList());

    dataImages.forEach((element) {
      listImageRequest.add(element.linkImage);
    });
    sendImageToCustomer();
    listImageRequest = [];
  }

  Future<void> uploadImageData({int indexImage, Function onOK}) async {
    try {
      var fileUp =
          await ImageUtils.getImageFileFromAsset(dataImages[indexImage].file);
      var fileUpImageCompress = await ImageUtils.getImageCompress(fileUp);

      var link = await RepositoryManager.imageRepository
          .uploadImage(fileUpImageCompress);

      dataImages[indexImage].linkImage = link;
    } catch (err) {
      print(err);
      dataImages[indexImage].linkImage = null;
      //  dataImages[indexImage].errorUpload = true;
      //    dataImages[indexImage].uploading = false;
      //  dataImages.refresh();
    }
    onOK();
  }

  Future<void> loadAssets() async {
    dataImages = [];
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: MAX_SELECT - resultList.length,
        enableCamera: true,
        //selectedAssets: dataImages.toList().map((e) => e.file).toList(),
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "SahaShop",
          allViewTitle: "Mời chọn ảnh",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (resultList.isNotEmpty) {
      updateListImage(resultList);
    } else {
      return;
    }
  }
}

class ImageData {
  Asset file;
  String linkImage;
  bool errorUpload;
  bool uploading;

  ImageData({this.file, this.linkImage, this.errorUpload, this.uploading});
}
