import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/chat_customer/send_message_customer_request.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/login/login_screen.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/components/utils/customer_info.dart';
import 'package:sahashop_user/controller/config_controller.dart';
import 'package:sahashop_user/data/remote/response-request/chat/send_message_response.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/data/socket/socket.dart';
import 'package:sahashop_user/model/message.dart';
import 'package:sahashop_user/screen/home/home_controller.dart';
import 'package:sahashop_user/utils/image_utils.dart';
import 'package:flutter/material.dart';

class ChatCustomerController extends GetxController {
  var messageEditingController = new TextEditingController(text: "").obs;
  var pageLoadMore = 1;
  var isEndPageCombo = false;
  var listMessage = RxList<Message>();
  var allImageInMessage = RxList<List<dynamic>>();
  var listImageResponse = [];
  var listImageRequest = [];
  var listSaveDataImages = RxList<List<ImageData>>();
  var timeNow = DateTime.now().obs;
  var limitedSocket = 0.obs;

  DataAppCustomerController dataAppCustomerController = Get.find();
  ConfigController configController = Get.find();
  HomeController homeController = Get.find();

  @override
  void onInit() async {
    await checkLoginToCartScreen();
    super.onInit();
  }

  Future<void> checkLoginToCartScreen() async {
    if (await CustomerInfo().hasLogged()) {
      loadInitMessage();
      getDataMessageUser();
    } else {
      Get.back();
      Get.to(() => LoginScreenCustomer());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getDataMessageUser() {
    SocketUser().listenUser(dataAppCustomerController.infoCustomer.value.id,
        (data) {
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

  void loadInitMessage() {
    pageLoadMore = 1;
    isEndPageCombo = false;
    loadMoreMessage();
  }

  Future<void> loadMoreMessage() async {
    timeNow.value = DateTime.now();
    try {
      if (!isEndPageCombo) {
        var res = await CustomerRepositoryManager.chatCustomerRepository
            .getAllMessageCustomer(pageLoadMore);
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

  Future<SendMessageResponse> sendMessageToUser() async {
    timeNow.value = DateTime.now();
    try {
      listSaveDataImages.insert(0, null);
      allImageInMessage.insert(0, null);
      listMessage.insert(
          0,
          Message(
              isUser: false,
              content: messageEditingController.value.text,
              createdAt: timeNow.value));
      var res = await CustomerRepositoryManager.chatCustomerRepository
          .sendMessageToUser(SendMessageCustomerRequest(
        content: messageEditingController.value.text,
      ));
      //   print(allImageInMessage);
      messageEditingController.value.text = "";
      messageEditingController.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<SendMessageResponse> sendImageToUser() async {
    timeNow.value = DateTime.now();
    try {
      listSaveDataImages.insert(0, dataImages);
      allImageInMessage.insert(0, null);
      listMessage.insert(
          0,
          Message(
            isUser: false,
            linkImages: "",
            createdAt: timeNow.value,
          ));
      var res = await CustomerRepositoryManager.chatCustomerRepository
          .sendMessageToUser(SendMessageCustomerRequest(
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
    sendImageToUser();
    listImageRequest = [];
  }

  Future<void> uploadImageData({int indexImage, Function onOK}) async {
    try {
      //  dataImages[indexImage].uploading = true;
      //  dataImages.refresh();

      var fileUp =
          await ImageUtils.getImageFileFromAsset(dataImages[indexImage].file);
      var fileUpImageCompress = await ImageUtils.getImageCompress(fileUp);

      var link = await RepositoryManager.imageRepository
          .uploadImage(fileUpImageCompress);

      print(
          "-------------------------------------------------------$indexImage");

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
